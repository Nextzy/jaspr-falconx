# Use case

`package: jaspr_falconx` (`lib/src/domain/fal_usecase.dart`). `Result`, `CommonException`, `DomainLayerException`, and the error-type enums are `dart_falmodel`'s, re-exported through `jaspr_falmodel`; `DioException` is dio's, re-exported through `jaspr_falconnect`. See the skills shipped for `dart_falmodel` and `dart_falconnect` (installed with this package).

## `FalUsecase`

An abstract base class with no abstract members and no constructor parameters; extend it and call its methods from your use case.

| Method | Behaviour |
|---|---|
| `Future<Result<T>> runDomainCatching<T>(Future<Result<T>> Function() execute)` | returns the `Result` of `execute`. A thrown `DioException` becomes `Result.failure(e.toException())` (a `NetworkException` that keeps the status); a thrown `CommonException` becomes a failure with that same exception; anything else thrown (an `Exception` or an `Error`) becomes a `DomainLayerException` with `type: SystemErrorType.unexpected`, `originalException`, and `stackTrace`. It never throws |
| `T requiredResultData<T>(Result<T?> result, {Object? type, bool Function(T value)? validator, String? languageCode, String? userMessage, String? developerMessage})` | returns the value of a successful `result` that is non-null and passes `validator`. Otherwise it throws, so call it inside `runDomainCatching` (see the table below) |
| `Future<T> requiredFutureResultData<T>(Future<Result<T?>> result, {...same named parameters})` | awaits `result`, then returns `requiredResultData` of it |
| `String? mapUserMessage({required Object? type, required String? languageCode})` | returns `null`; override it to supply translated user messages |

What `requiredResultData` throws:

| `result` | Thrown exception |
|---|---|
| successful, but `null` or failing `validator` | `DomainLayerException(type: type ?? BusinessErrorType.notFound, originalException: type == null ? null : <a not-found DomainLayerException>, userMessage: userMessage ?? mapUserMessage(type: type, languageCode: languageCode), developerMessage: developerMessage)` |
| failed with `exception` | `exception.copyWith(type: type, originalException: type == null ? null : exception, userMessage: userMessage ?? exception.userMessage ?? mapUserMessage(type: type, languageCode: languageCode), developerMessage: developerMessage)`; `copyWith` keeps every field you pass `null` for |

## Sample

```dart
class Post {
  const Post({required this.slug, required this.title});
  final String slug;
  final String title;
}

// Domain contract; the data layer implements it, for example with a
// FalRepository from jaspr_falconnect.
abstract class PostRepository {
  Future<Result<Post?>> findBySlug(String slug);
}

const Map<String, String> postLoadFailed = {
  'en': 'This post could not be loaded.',
  'th': 'ไม่สามารถโหลดโพสต์นี้ได้',
};

class GetPostUsecase extends FalUsecase {
  GetPostUsecase(this._repository);

  final PostRepository _repository;

  Future<Result<Post>> call(String slug, {String? languageCode}) =>
      runDomainCatching(() async {
        final post = await requiredFutureResultData(
          _repository.findBySlug(slug),
          languageCode: languageCode,
        );
        return Result.success(post);
      });

  @override
  String? mapUserMessage({
    required Object? type,
    required String? languageCode,
  }) => postLoadFailed[languageCode ?? 'en'];
}
```

Give `ServerData` (`references/rendering.md`) `load: () => getPost(slug)`, since `load` takes no arguments; with `quietWhen: isExpectedPageFailure` and `applyPageErrorStatus`, a CMS 403 or 404 logs one info line and the page gets status 404.

## Gotchas

- The rethrown failure keeps its class when that class overrides `copyWith`, as `DomainLayerException`, `DataLayerException`, and `TodoException` do. A `NetworkException` comes back as a plain `CommonException` without `statusCode` and `response`, and only its type still carries the status. Pass `type:` and the original exception, with its CMS status, stays in `originalException`.
- `mapUserMessage` receives the `type` argument you passed, which is `null` when you passed none; it never sees the failure's own type. On a failed `result` it runs only when the exception has no `userMessage` and you passed none.
- A `Result.success(null)`, or a value that fails `validator`, makes `requiredResultData` throw a `DomainLayerException` that `pageErrorStatus` maps to 404. Without `type` its type is `BusinessErrorType.notFound` and `originalException` is `null`; with `type` it keeps your type and sets a not-found `DomainLayerException` as `originalException`.
- `runDomainCatching` keeps a thrown `CommonException` as it is, while `runDataCatching` from `jaspr_falconnect` keeps a `DataLayerException` and wraps any other `CommonException` in a `DataLayerException` with the same type.
- Code that reaches the browser (`@client` islands and anything they import) never imports `dart:io`, `package:jaspr/server.dart`, or `jaspr_falserver`. Server code may use `dart:io`.
- Write constructors with the type name (`const Foo(...)`, `Foo._()`), never `new(...)`: consuming apps run jaspr_builder 0.23.5, which rejects primary constructors.
