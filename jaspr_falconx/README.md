# jaspr_falconx

Shared helpers for Jaspr sites built on falconx.

## Page error status

`pageErrorStatus(error)` maps a failed page load to an HTTP status: 404 when the CMS answered 403 or 404, otherwise 503 so crawlers retry. `isExpectedPageFailure(error)` is true for the 404 case.

```dart
final status = pageErrorStatus(error); // 404 or 503
```

## Locale path

`switchLocalePath(path, toCode, supported)` swaps the leading locale segment, or prefixes it when the path has none. It keeps the query and the fragment.

```dart
switchLocalePath('/th/blogs/abc?page=2', 'en', ['th', 'en']); // /en/blogs/abc?page=2
```

## Repository error handling

Extend `FalRepository` (from `jaspr_falconnect`) and wrap each data call in `runDataCatching`. It returns the call's `Result`, and turns a thrown error into a failed `Result`: a `DioException` becomes the `NetworkException` from `toException()`, a `CommonException` becomes a `DataLayerException` with the same type, and any other error becomes an unexpected `DataLayerException`.

```dart
class BlogRepository extends FalRepository {
  Future<Result<Blog>> get(String id) => runDataCatching(() async {
    final blog = await _remote.get(id);
    return Result.success(blog);
  });
}
```
