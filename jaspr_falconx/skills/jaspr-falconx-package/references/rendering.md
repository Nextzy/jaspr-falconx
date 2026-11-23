# Rendering

`package: jaspr_falconx` (`lib/src/rendering/`). `ServerData`, the request and response helpers, and the server logs each have a server version and a browser version behind a conditional export, so a component that calls the helpers or the logs still compiles to JavaScript. The page error status functions are plain code that calls the response helpers. `Result`, `CommonException`, and `NetworkException` are `dart_falmodel`'s, re-exported through `jaspr_falmodel`; see the skill shipped for `dart_falmodel` (installed with this package).

## `ServerData<T>`

| Parameter | Type |
|---|---|
| `load` (required) | `Future<Result<T>> Function()` |
| `builder` (required) | `Component Function(BuildContext context, T data)` |
| `errorBuilder` (required) | `Component Function(BuildContext context, CommonException error)` |
| `quietWhen` | `bool Function(CommonException error)?` |
| `key` | `Key?` |

On the server, `ServerData` awaits `load` while it renders (through jaspr's `AsyncBuilder`), then:

| `load` returns | `ServerData` does |
|---|---|
| a successful `Result` | renders `builder(context, value)`; sets no header |
| a failed `Result`, `quietWhen` absent or false | `logServerError('ServerData<T> load failed', error: error, stackTrace: error.stackTrace)`, sets `cache-control: no-store`, renders `errorBuilder(context, error)` |
| a failed `Result`, `quietWhen(error)` true | `logServerInfo` with one line, `ServerData<T> load failed: <runtimeType> [<type>] <developerMessage, else userMessage>`, line breaks replaced by spaces; then the same `no-store` and `errorBuilder` |

It sets no status code; the error builder picks one. In the browser, building `ServerData` throws `UnsupportedError('ServerData renders on the server only')`.

```dart
class Article {
  const Article({required this.title});
  final String title;
}

class ArticlePage extends StatelessComponent {
  const ArticlePage({required this.slug, required this.loadArticle, super.key});

  final String slug;
  // For example a FalUsecase method that returns runDomainCatching(...).
  final Future<Result<Article>> Function(String slug) loadArticle;

  @override
  Component build(BuildContext context) {
    return ServerData<Article>(
      load: () => loadArticle(slug),
      quietWhen: isExpectedPageFailure,
      builder: (context, article) => Component.text(article.title),
      errorBuilder: (context, error) {
        applyPageErrorStatus(context, error);
        return Component.text(
          isExpectedPageFailure(error) ? 'Page not found' : 'Please try again soon',
        );
      },
    );
  }
}
```

## Request and response helpers

| Function | On the server | In the browser |
|---|---|---|
| `String? requestHeader(BuildContext context, String name)` | the header from `context.headers`, matched case-insensitively; `null` when absent | always `null` |
| `void setResponseStatus(BuildContext context, int statusCode)` | `context.setStatusCode(statusCode)` | does nothing |
| `void setResponseHeader(BuildContext context, String name, String value)` | `context.setHeader(name, value)` | does nothing |
| `void markNotCacheable(BuildContext context)` | sets `cache-control: no-store` | does nothing |

Call `markNotCacheable` when a page renders with incomplete data, so neither a browser nor a CDN keeps the degraded page. `assetMiddleware` from `jaspr_falserver` keeps a `cache-control` header the render already set.

```dart
class PartialBanner extends StatelessComponent {
  const PartialBanner({required this.hasAllData, super.key});

  final bool hasAllData;

  @override
  Component build(BuildContext context) {
    if (!hasAllData) markNotCacheable(context);
    final agent = requestHeader(context, 'user-agent') ?? 'unknown';
    return Component.text('Rendered for $agent');
  }
}
```

## Server logs

| Function | On the server | In the browser |
|---|---|---|
| `void logServerError(Object? message, {Object? error, StackTrace? stackTrace})` | writes `[ERROR] <message>` to stderr, then the text of `error` on the next line, then `stackTrace` unless the error text already contains it (as `CommonException.toString` does) | `Log.e`, which prints only in debug builds |
| `void logServerInfo(Object? message)` | writes `[INFO] <message>` to stdout | `Log.i`, which prints only in debug builds |

Both write in a release build, unlike `Log` from `jaspr_faltool`. `logServerInfo` stays off stderr because log hosts such as Railway tag every stderr line as an error; use it for an expected failure that needs a line but no stack trace. It does not join line breaks in `message` (only `ServerData` does that for its own line), so pass one line.

```dart
void reportCmsFailure(CommonException error) {
  logServerError('CMS request failed', error: error, stackTrace: error.stackTrace);
}
```

## Page error status

| Function | Returns or does |
|---|---|
| `int pageErrorStatus(CommonException error)` | 404 when the error, or a `CommonException` in its `originalException` chain, is a missing record (the CMS answered 403, which Directus gives for an unknown id, or 404, or the type is `BusinessErrorType.notFound`); 503 for every other failure (5xx, timeout, network, unexpected), so crawlers retry |
| `void applyPageErrorStatus(BuildContext context, CommonException error)` | `setResponseStatus` with `pageErrorStatus(error)`; a 503 also gets `retry-after: 60`. Does nothing in the browser |
| `bool isExpectedPageFailure(CommonException error)` | `pageErrorStatus(error) == 404`; pass it as `quietWhen` so a missing record logs one info line |

Each link of the chain gives a CMS status: a `NetworkException`'s `statusCode`, or, for any other `CommonException`, the `statusCode` of its `type` when that is a `NetworkErrorType`. `FalUsecase.requiredResultData` rethrows a plain `CommonException` that drops `statusCode`. A failed result rethrown with `type:` keeps the original failure in `originalException`; without `type:` only the failure's type carries the status. Null data without `type:` throws a not-found `DomainLayerException` (`BusinessErrorType.notFound`, no marker); with `type:` it keeps your type and sets a not-found `DomainLayerException` as `originalException`. The walk finds the 404 in each case.

## Gotchas

- Render `ServerData` only in the server-rendered tree, never inside a `@client` island or a component an island renders.
- `ServerData` turns a thrown `load` into a failed result: a thrown `CommonException` as it is, another `Exception` wrapped as `SystemErrorType.unexpected` with it as `originalException`, anything else wrapped with its text in `developerMessage`. It is logged and still gets `cache-control: no-store`.
- Without `applyPageErrorStatus` (or `setResponseStatus`) in `errorBuilder`, the error page is served with status 200.
- Code that reaches the browser (`@client` islands and anything they import) never imports `dart:io`, `package:jaspr/server.dart`, or `jaspr_falserver`. Server code may use `dart:io`. With the helpers here, a shared component needs no server import.
- Write constructors with the type name (`const Foo(...)`, `Foo._()`), never `new(...)`: consuming apps run jaspr_builder 0.23.5, which rejects primary constructors.
