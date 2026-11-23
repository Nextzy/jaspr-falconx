---
name: jaspr-falconnect-network
description: Use when calling `jaspr_falconnect` APIs such as `jasprHttpClientConfig`, `FalRepository.runDataCatching`, `ResultStreamFetcher`, or `ResultStreamFetcherList`, or before writing an HTTP client configuration, a repository try/catch that turns errors into a `Result`, or a fetch stream that emits loading and success states of your own, or when asking where `Result` or `ComponentState` comes from, since jaspr_falconnect also re-exports dart_falconnect, the networking libraries it brings, and jaspr_falmodel.
---

# jaspr_falconnect network

Answers "does jaspr_falconnect already provide this?" here and routes "how do I call it?" to `references/repository.md`. `package: jaspr_falconnect`; its barrel also re-exports `dart_falconnect`, so `dio`, `retrofit`, `dio_cache_interceptor`, `web_socket_channel`, `HttpClientConfig`, `DefaultHttpClient`, the interceptors, and `DatasourceBoundState` come with it. HTTP, WebSocket, and JSON-RPC detail lives in the skill shipped for `dart_falconnect` (installed with this package).

`Result`, `ComponentState`, `DataLayerException`, and the other exception types that these APIs take and return come from `jaspr_falmodel` (which re-exports `dart_falmodel`). This barrel also re-exports `jaspr_falmodel`, so they need no separate import.

## Capability map

| Need | Use | Ref |
|---|---|---|
| Client configuration for a Jaspr app | `jasprHttpClientConfig(interceptors:, exceptionHandler:, timeout:, debugLogging:)` | below |
| Turn anything a data call throws into a failed `Result` | `FalRepository.runDataCatching` in a repository subclass | `references/repository.md` |
| One fetch as a stream of loading and success states | `ResultStreamFetcher<T>.fetch` | `references/repository.md` |
| Keyed fetches with debounce and bulk close | `ResultStreamFetcherList.fetchStream`, `fetchFuture`, `closeSync`, `closeAsync` | `references/repository.md` |
| Retrofit and Dio clients, `HttpClientConfig` boxes, interceptors, WebSocket, JSON-RPC, `DatasourceBoundState` | the re-exported `dart_falconnect` API | the skill shipped for `dart_falconnect` |

## `jasprHttpClientConfig`

```dart
void configureHttp() {
  DefaultHttpClient.instance.configure(
    jasprHttpClientConfig(
      timeout: const Duration(seconds: 10),
    ).copyWith(baseUrl: 'https://api.example.com'),
  );
}
```

| Parameter | Default | Effect |
|---|---|---|
| `interceptors` | `const []` | placed first in the config's `interceptors` list |
| `exceptionHandler` | `null` | the `NetworkExceptionHandlerInterceptor` at the end of the chain; `null` lets the client fall back to `DefaultNetworkExceptionHandlerInterceptor` |
| `timeout` | 20 seconds | sets `connectTimeout` and `receiveTimeout`; `sendTimeout` stays unset |
| `debugLogging` | `null`, read as jaspr's `kDebugMode` | `true` appends a `PrettyDioLogger` after your interceptors |

It also sets `contentType` to JSON. Every other `HttpClientConfig` field keeps its default (empty `baseUrl`, no `log`, `retry`, `cache`, or `auth` box); add them with `copyWith`.

## Do not reinvent

- Before adding a pub dependency or writing a helper, scan the map above and the skill shipped for `dart_falconnect`.
- When this package's barrel is imported, do not also import `dart_falconnect`, `dio`, or another library it re-exports; the symbols are already in scope.
- Do not write a try/catch that maps `DioException` and other errors to a failed `Result`; extend `FalRepository` and call `runDataCatching`.
- Do not hand-roll a `StreamController` that emits loading, then success; use `ResultStreamFetcher` or `ResultStreamFetcherList`.

## Gotchas

- The logger is added only when `debugLogging ?? kDebugMode` is true, so release builds (`kReleaseMode`) never construct it. Pass `debugLogging: false` to keep it off in debug runs too.
- The logger prints the request line and errors, with no headers or bodies. It prints to the browser console in an island and to stdout on the server.
- The logger is the last item of the returned config's `interceptors`, so `copyWith(interceptors: ...)` drops it. Pass your interceptors to `jasprHttpClientConfig` instead.
- Listing `jaspr_falmodel` beside `jaspr_falconnect` (which depends on it) as git dependencies fails `dart pub get` at a tag `ref:`, because the sibling `path: ../` dependencies resolve to the commit hash. Use the tag's full 40-character commit hash as `ref:` for every listed `jaspr_fal*` package; the "When you list more than one package" section of the `jaspr-falconx` README explains how to read it.
- These APIs return `Result`, never fpdart's `Either`.
- A fetcher reports a failed `Result` as a stream error carrying the exception, then closes; it never emits a fail state. Always pass `onError` to `listen`. See `references/repository.md`.
- Code that reaches the browser (`@client` islands and anything they import) never imports `dart:io`, `package:jaspr/server.dart`, or `jaspr_falserver`. Server code may use `dart:io`.
- Write constructors with the type name (`const Foo(...)`, `Foo._()`), never `new(...)`: consuming apps run jaspr_builder 0.23.5, which rejects primary constructors.

## Out of scope

HTTP clients, interceptors, WebSocket, JSON-RPC, and `DatasourceBoundState` (see the skill shipped for `dart_falconnect`), `Result`, `ComponentState`, and the exception types (see the skill shipped for `jaspr_falmodel`), and package internals.
