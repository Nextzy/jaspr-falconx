---
name: jaspr-falconx-package
description: Use when a Jaspr project lists jaspr_falconx in pubspec.yaml, or you are choosing which jaspr_fal* package to list, adding its git dependency, or importing it, or when calling `jaspr_falconx` APIs such as `ServerData`, `requestHeader`, `setResponseStatus`, `setResponseHeader`, `markNotCacheable`, `logServerError`, `logServerInfo`, `pageErrorStatus`, `applyPageErrorStatus`, `isExpectedPageFailure`, `pickLocale`, `localeFromPath`, `switchLocalePath`, or `FalUsecase` with `runDomainCatching` and `mapUserMessage`, or before writing server-side page data loading, response status or header code, server logging, Accept-Language parsing, locale path helpers, or a use-case try/catch of your own.
---

# jaspr-falconx package

Answers "which jaspr-falconx package do I list and import?" in `references/setup.md`, and "does `jaspr_falconx` already provide this?" here, with one file under `references/` for each part of the umbrella's own API. `jaspr_falconx` re-exports the barrels of `jaspr_falconnect`, `jaspr_falkit`, `jaspr_falmodel`, `jaspr_falmonitor`, `jaspr_falstore`, `jaspr_faltool`, and `jaspr_router`, and ships a copy of the skill each of those six jaspr packages ships, plus the skills of `dart_falconnect`, `dart_falmodel`, and `dart_faltool`. It does not re-export `jaspr_falserver` or `jaspr` itself.

## Setup

List `jaspr_falconx` (or single packages) as a git dependency from `https://github.com/Nextzy/jaspr-falconx`; the block, the `ref:` rule, the imports, and the hidden names are in `references/setup.md`.

```dart
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falconx/jaspr_falconx.dart';
```

## Capability map

| Need | Use | Ref |
|---|---|---|
| Which package to list for a need, the git dependency, `ref:`, imports, hidden and clashing names | | `references/setup.md` |
| Load page data on the server, then render it or an error page | `ServerData<T>(load:, builder:, errorBuilder:, quietWhen:)` | `references/rendering.md` |
| Read a request header, or set the status, a header, or `no-store`, from a component that also compiles in an island | `requestHeader`, `setResponseStatus`, `setResponseHeader`, `markNotCacheable` | `references/rendering.md` |
| Server log lines that also print in release builds | `logServerError` (stderr), `logServerInfo` (stdout) | `references/rendering.md` |
| 404 or 503 for a page whose data failed to load | `pageErrorStatus`, `applyPageErrorStatus`, `isExpectedPageFailure` | `references/rendering.md` |
| Locale from `Accept-Language` or from the path; swap the locale segment of a path | `pickLocale`, `localeFromPath`, `switchLocalePath` | `references/locale.md` |
| Use case base that turns every throw into a failed `Result` | `FalUsecase`: `runDomainCatching`, `requiredResultData`, `requiredFutureResultData`, `mapUserMessage` | `references/usecase.md` |
| Routes, links, route state | `Router`, `Route`, `ShellRoute`, `Link`, `RouteState` from `jaspr_router`, re-exported | the `jaspr_router` docs |
| Everything the six re-exported packages own | their API | the skill shipped for that package (table in `references/setup.md`) |

## Do not reinvent

- Before adding a pub dependency or writing a helper, scan the map above and the table in `references/setup.md`, then the skill shipped for the package that would own it.
- When the umbrella import is present, do not also import `jaspr_router`, a `jaspr_fal*` or `dart_fal*` barrel, `dio`, or another library it re-exports; the symbols are already in scope.
- Do not import `package:jaspr/server.dart` into a shared component only to read `context.headers` or call `context.setStatusCode` or `context.setHeader`; use `requestHeader`, `setResponseStatus`, `setResponseHeader`, and `markNotCacheable`, which compile in the browser and do nothing there.
- Do not parse `Accept-Language` or split locale paths by hand; use the locale functions.
- Do not write a try/catch in a use case; extend `FalUsecase` and wrap the body in `runDomainCatching`.
- Do not add a second router; `jaspr_router` comes with the umbrella.

## Gotchas

- `ServerData` renders on the server only. Built in the browser it throws `UnsupportedError`, so never put it inside a `@client` island or a component an island renders.
- `ServerData` handles a failed `Result` and sets no status code. Call `applyPageErrorStatus` in `errorBuilder`, or the error page goes out as 200 (with `cache-control: no-store`). It does not catch an exception that `load` throws; wrap the call in `runDomainCatching` (or `runDataCatching` from `jaspr_falconnect`).
- `requiredResultData(type: ...)` replaces the failure's type, so a CMS 404 rethrown with your `type` loses its status and `pageErrorStatus` answers 503. See `references/usecase.md`.
- `jaspr_falserver` is not re-exported. List it on its own and import `package:jaspr_falserver/jaspr_falserver.dart` only from the server entrypoint and code only it reaches; naming its `Middleware` type also needs `shelf` listed and imported. See `references/setup.md`.
- In a server file that imports `package:jaspr/server.dart` beside the umbrella, `Response` is both shelf's and dio's (`ambiguous_import`); hide the one you do not use. Beside the umbrella, `HttpResponse` is Retrofit's and shadows `dart:io`'s without a diagnostic. See `references/setup.md`.
- The `jaspr_faltool` barrel, and so the umbrella, hides fpdart's `Unit` and `option` and numeral's `NumeralNumExtension`; jaspr's CSS `Unit`, `<option>` element, and `.percent` win.
- `Log` from `jaspr_faltool` prints nothing in a release build. Use `logServerError` and `logServerInfo` for lines a production server must keep.
- A `ref:` tag fails version solving when one package you list depends on another you list (for example `jaspr_falconnect` with `jaspr_falmodel`); then every listed package needs the tag's full commit hash. See `references/setup.md`.
- Code that reaches the browser (`@client` islands and anything they import) never imports `dart:io`, `package:jaspr/server.dart`, or `jaspr_falserver`. Server code may use `dart:io`.
- Write constructors with the type name (`const Foo(...)`, `Foo._()`), never `new(...)`: consuming apps run jaspr_builder 0.23.5, which rejects primary constructors.

## Out of scope

The API of each re-exported package (see the skill shipped for `jaspr_falconnect`, `jaspr_falkit`, `jaspr_falmodel`, `jaspr_falmonitor`, `jaspr_falstore`, `jaspr_faltool`, and the three `dart_fal*` packages), server middleware (the skill shipped for `jaspr_falserver`), `jaspr_router` and `jaspr` themselves, and package internals.
