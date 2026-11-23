# Repository and fetchers

`package: jaspr_falconnect`. `Result`, `ComponentState`, `DataLayerException`, `CommonException`, and `SystemErrorType` are `jaspr_falmodel` types; this barrel does not re-export them.

## `FalRepository`

An abstract base class with no constructor parameters and one method:

`Future<Result<T>> runDataCatching<T>(Future<Result<T>> Function() execute)`

It awaits `execute` and returns its `Result`, success or failure, unchanged. Anything `execute` throws becomes a failed `Result`:

| Thrown | Failure exception |
|---|---|
| `DioException` | the `NetworkException` that `toException()` builds from it |
| `DataLayerException` | the same exception |
| any other `CommonException`, such as a `NetworkNotFoundException` | a `DataLayerException` with the same `type`, `userMessage`, `developerMessage`, `originalException`, and `stackTrace` |
| any other object | a `DataLayerException` with `type: SystemErrorType.unexpected`, `developerMessage: e.toString()`, the object as `originalException`, and the stack trace |

Wrap each repository method's whole body, so a thrown error never reaches the caller. With `Result` in scope (from `jaspr_falmodel`), a method reads `Future<Result<Article>> article(int id) => runDataCatching(() async => Result.success(await _api.getArticle(id)));`, where `_api` is your Retrofit client. `DatasourceBoundState.asRemoteResultFuture` from `dart_falconnect` also returns a `Future<Result<T>>` and can be the body.

## `ResultStreamFetcher<T>`

Turns one `Stream<Result<T>>` into a `Stream<ComponentState<T?>>`.

| Member | Behavior |
|---|---|
| `ResultStreamFetcher([StreamController<ComponentState<T?>>? controller])` | uses `controller`, or a new single-subscription `StreamController` |
| `Stream<ComponentState<T?>> fetch(Stream<Result<T>> call)` | emits `ComponentState.loading(null)`, then `ComponentState.success(data)` for every success in `call` |
| `stream` | the same stream `fetch` returns |
| `isClose` | `true` once the controller is closed |
| `Future<void> close()` | cancels the `call` subscription and closes the stream |

A failed `Result`, or an error thrown inside `call`, is added to the stream as an error carrying the exception and its stack trace, and the fetcher closes. When `call` is done, the fetcher closes too. A closed fetcher cannot fetch again; make a new one.

## `ResultStreamFetcherList`

Keeps one `ResultStreamFetcher` per key.

| Member | Behavior |
|---|---|
| `fetchStream<T>({required Object key, required Stream<Result<T>> call, bool debounceFetch = true})` | starts a fetcher for `key` and returns its stream |
| `fetchFuture<T>({required Object key, required Future<Result<T>> call, bool debounceFetch = true})` | the same, for one `Future` |
| `void closeSync()` | closes every fetcher without waiting |
| `Future<void> closeAsync()` | closes every fetcher and waits for all of them |

Each call first drops the fetchers that already closed. Then, for a key whose fetcher is still open:

- `debounceFetch: true` ignores the new `call` and returns the open fetcher's stream.
- `debounceFetch: false` closes the open fetcher and starts a new one.

```dart
@client
class ArticleTitle extends StatefulComponent {
  const ArticleTitle({required this.id, super.key});

  final int id;

  @override
  State<ArticleTitle> createState() => _ArticleTitleState();
}

class _ArticleTitleState extends State<ArticleTitle> {
  final _fetchers = ResultStreamFetcherList();
  String? _title;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) _load();
  }

  void _load() {
    // A Future<Result<String>>; in an app it comes from a FalRepository method.
    final call = DatasourceBoundState.asRemoteResultFuture(
      createCallFuture: () => DefaultHttpClient.instance.dio
          .get<Map<String, Object?>>('/articles/${component.id}'),
      processResponse: (response) => response.data?['title'] as String? ?? '',
    );
    _fetchers.fetchFuture(key: 'title', call: call).listen(
      // state is a ComponentState<String?> from jaspr_falmodel.
      (state) {
        if (!mounted) return;
        setState(() {
          _isLoading = state.isLoading;
          _title = state.data;
        });
      },
      onError: (Object error) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      },
    );
  }

  @override
  void dispose() {
    _fetchers.closeSync();
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    if (_hasError) return Component.text('Could not load the title');
    if (_isLoading) return Component.text('Loading');
    return Component.text(_title ?? '');
  }
}
```

The island starts the fetch behind `kIsWeb`, because `initState` also runs while the server pre-renders it.

## Gotchas

- Failures arrive through `onError`, never as a fail `ComponentState`. A `listen` without `onError` sends the exception to the zone's uncaught error handler.
- The stream is single-subscription. A debounced second call for an open key returns the first call's stream, and listening to it again throws `StateError` (`Stream has already been listened to`). Share one subscription per key, or pass `debounceFetch: false`.
- A debounced call ignores its own `call`: a future's result is discarded, and a stream is never listened to.
- Reusing a key for a different `T` while its fetcher is open throws a `TypeError` from the cast. Give each type its own key.
- `closeSync` and `closeAsync` close the fetchers but do not empty the list; closed fetchers are dropped on the next `fetchStream` or `fetchFuture`.
