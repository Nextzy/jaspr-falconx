# Migrate `Either<Failure, T>` → `Result<T>`

**Date:** 2026-04-07
**Status:** Design approved, ready for implementation plan

## Goal

Replace all usages of `Either<Failure, T>` in the `jaspr-falconx` monorepo
with `Result<T>` (from `dart_falmodel`), unifying error handling on
`CommonException` instead of `Failure` (a `UserFeedback` subclass).

## Scope

Source files affected (4):

- `jaspr_falconnect/lib/engine/fetches/stream_fetcher.dart`
- `jaspr_falconnect/lib/engine/fetches/stream_fetcher_list.dart`
- `jaspr_falconx/lib/src/states/riverpod_codec.dart`
- `jaspr_falconx/lib/src/states/page_controller.dart`

Doc to update (1):

- `docs/superpowers/plans/2026-04-07-package-version-migration.md`
  (references old `RiverpodEitherEncoder/Decoder` names)

## Background

`Either<Failure, T>` and `Result<T>` are not type-compatible:

- `Either` pairs with `Failure` (a `UserFeedback` subclass: `message`, `level`)
- `Result` pairs with `CommonException` (`type`, `userMessage`,
  `developerMessage`, `originalException`, `stackTrace`)

These represent different concerns (user-facing feedback vs. exception with
layer/type metadata), so migration requires a boundary adapter where the
result interacts with `ComponentState.fail(feedback: UserFeedback?)`.

## Design

### 1. Adapter extension (new)

Location: `jaspr_falconx/lib/src/extensions/common_exception_feedback_ext.dart`
(local scope — not upstreamed to `jaspr_falmodel`).

```dart
extension CommonExceptionFeedbackX on CommonException {
  Failure toFailure({FeedbackLevel level = FeedbackLevel.medium}) => Failure(
        message: userMessage ?? developerMessage,
        level: level,
      );
}
```

`level` is optional with `FeedbackLevel.medium` default; callers may override.

### 2. Renames

| Old | New |
| --- | --- |
| `EitherStreamFetcher<T>` | `ResultStreamFetcher<T>` |
| `EitherStreamFetcherList` | `ResultStreamFetcherList` |
| `RiverpodEitherCodec<T>` | `RiverpodResultCodec<T>` |
| `RiverpodEitherEncoder<T>` | `RiverpodResultEncoder<T>` |
| `RiverpodEitherDecoder<T>` | `RiverpodResultDecoder<T>` |
| `riverpodEitherCodec(...)` | `riverpodResultCodec(...)` |

### 3. Type and API replacements

| Old | New |
| --- | --- |
| `Either<Failure, T>` | `Result<T>` |
| `Left(Failure(message: m))` | `Result.failure(CommonException(type: ErrorType.unknown, userMessage: m))` |
| `Right(v)` | `Result.success(v)` |
| `either.fold(l, r)` | `result.resolve(r, (e, _) => l(e))` |
| `either.isFailure` | `result.isFailure` |
| `either.failure` | `result.exception` |
| `either.failureOrNull` | `result.exceptionOrNull` |
| `either.dataOrNull` | `result.valueOrNull` |

### 4. Codec JSON shape (breaking)

Old shape:
```json
{"failure": {"message": "...", "level": "medium"}, "data": ...}
```

New shape:
```json
{"exception": {"type": "notFound", "userMessage": "...", "developerMessage": "..."}, "data": ...}
```

Encoder serializes `type` via `(type as Enum?)?.name ?? type.toString()`.
`originalException` and `stackTrace` are intentionally not serialized
(runtime-only state, not meaningful after hydration).

**Decoder fallback:** If `type` field is missing or unknown,
fall back to `ErrorType.unknown`:

```dart
Object _parseErrorType(String? name) {
  if (name == null) return ErrorType.unknown;
  try {
    return ErrorType.values.byName(name);
  } catch (_) {
    return ErrorType.unknown;
  }
}
```

**Wire compatibility:** The new shape is NOT compatible with the old shape.
Accepted because SSR hydration uses matched client/server builds — there is no
cross-version hydration scenario in practice.

### 5. `page_controller.dart` boundary

```dart
final result = context.read(_preloadProvider!).value;
if (result?.isFailure ?? false) {
  return ComponentState.fail(null, feedback: result!.exception.toFailure());
}
return ComponentState.initial(result?.valueOrNull);
```

The abstract method changes from:

```dart
Future<Either<Failure, DATA?>> preloadCall();
```

to:

```dart
Future<Result<DATA?>> preloadCall();
```

**Breaking change:** All subclasses of `PreloadComponentNotifier` must update
their `preloadCall()` return type. Confirmed no external subclasses exist
outside this repo; internal subclasses will be migrated in the same change.

### 6. `stream_fetcher.dart`

`_streamController.addError(failure)` becomes:

```dart
_streamController.addError(exception, exception.stackTrace);
```

This is a minor improvement — stack trace was previously unavailable via
`Failure`, and `CommonException` carries it natively.

### 7. Plan doc update

`docs/superpowers/plans/2026-04-07-package-version-migration.md` contains
code samples referencing `RiverpodEitherEncoder/Decoder` — update those
snippets to the new `Result`-based names to keep the doc coherent.

## Decisions (confirmed)

1. **Adapter location:** `jaspr_falconx` (local), not upstreamed.
2. **Decoder fallback type:** `ErrorType.unknown` for missing/unknown `type`.
3. **JSON shape is breaking:** Accepted — SSR builds always matched.
4. **No external subclasses** of `PreloadComponentNotifier` — breaking
   `preloadCall()` signature is contained to this repo.

## Out of scope

- Upstreaming the adapter to `jaspr_falmodel`
- Changing `ComponentState.fail` to accept `CommonException` directly
- Any refactor of `CommonException` / `ErrorType` / `Failure` / `UserFeedback`
- Any code outside the 4 listed source files (and the plan doc)

## Testing

- Unit test: `CommonExceptionFeedbackX.toFailure()` — default level, custom level,
  null-message fallback behavior
- Unit test: `RiverpodResultCodec` round-trip for success, failure,
  unknown `type` fallback, missing `type` fallback
- Existing `stream_fetcher` / `page_controller` consumers must compile and
  pass their current tests after signature updates
