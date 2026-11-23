# Logging and build mode

`package: jaspr_faltool`. `Log` wraps a `Logger` from the `logger` package, which the barrel re-exports through `dart_faltool`; `BuildConfig` reads jaspr's `kReleaseMode`.

## `Log`

All-static. Every method returns without writing when `kReleaseMode` is true. A `null` message logs as `'Null'` from `t`, `d`, `i`, `f`, `title`, and `success`, and as `null` from `w` and `e`.

| Member | Signature | Notes |
|---|---|---|
| `setup` | `static void setup({LogFilter? filter, LogPrinter? printer, LogOutput? output, Level? level})` | Replaces the shared `Logger`; an omitted argument takes logger's default |
| `t`, `d`, `i`, `f` | `static void x(Object? message, {DateTime? time, Object? error, StackTrace? stackTrace})` | Trace, debug, info, fatal |
| `w`, `e` | same as `t` | When `message` is an `Error`, `error` defaults to it and `stackTrace` to its `stackTrace`; when it is an `Exception`, `error` defaults to it |
| `error` | `static void error(Object error, StackTrace? stackTrace, {DateTime? time})` | Positional; logs at error level |
| `title`, `success` | `static void x(Object? message)` | Bold white or bold green ANSI text through `print`, in chunks of 1020 characters |

There is no `tag` parameter.

```dart
void configureLogging() {
  Log.setup(filter: ProductionFilter(), level: Level.debug);
}

Future<void> saveProfile(Future<void> Function() save) async {
  Log.i('Saving profile');
  try {
    await save();
    Log.success('Profile saved');
  } on Exception catch (error, stackTrace) {
    Log.e('Save failed', error: error, stackTrace: stackTrace);
  }
}
```

## `BuildConfig`

| Getter | Value |
|---|---|
| `BuildConfig.debug` | `!kReleaseMode` |
| `BuildConfig.release` | `kReleaseMode` |

```dart
String apiBaseUrl() =>
    BuildConfig.release ? 'https://api.example.com' : 'http://localhost:8081';
```

## Gotchas

- `Log` defaults to logger's `DevelopmentFilter`, which logs only when asserts are on. `Log.setup(filter: ProductionFilter())` logs in every run where `kReleaseMode` is false.
- `title` and `success` skip the `Logger`, so `setup` (filter, printer, output, level) has no effect on them. They print `message.toString()` encoded as a JSON string, so the output is quoted and newlines show as `\n`.
- Release builds log nothing through `Log`; production server logging needs another sink.
