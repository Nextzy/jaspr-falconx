# Setup

The jaspr-falconx packages are not on pub.dev. List each one you import as a git dependency from one repository, `https://github.com/Nextzy/jaspr-falconx`.

## Which package

`jaspr_falconx` re-exports every package below except `jaspr_falserver`, and ships a copy of each one's skill. Every package ships its own skill plus copies of the skills of the packages its barrel re-exports: `jaspr_faltool` also ships the `dart_faltool` skill, `jaspr_falmodel` the `dart_falmodel` one, `jaspr_falconnect` the `dart_falconnect` one, and `jaspr_falkit` the `jaspr_falmodel` and `dart_falmodel` ones. `jaspr_falstore`, `jaspr_falmonitor`, and `jaspr_falserver` ship only their own. For how to call a package, read the skill shipped for it.

| Need | Package | Barrel |
|---|---|---|
| Server page data (`ServerData`), request and response helpers, server logs, page error status, locale helpers, `FalUsecase`, the re-exported `jaspr_router` | `jaspr_falconx` (this skill) | `package:jaspr_falconx/jaspr_falconx.dart` |
| `Log`, `BuildConfig`, date formatting, `truncateText`, `EmojiWrapper`, share links; the `dart_faltool` extensions and libraries (`rxdart`, `fpdart`, `intl`, ...) | `jaspr_faltool` | `package:jaspr_faltool/jaspr_faltool.dart` |
| `ComponentState<T>`, `FullComponentState`, `ComponentSize`, `ThemeMode`, `Locale`; `Result`, `UserFeedback`, and the exceptions of `dart_falmodel` | `jaspr_falmodel` | `package:jaspr_falmodel/jaspr_falmodel.dart` |
| `jasprHttpClientConfig`, `FalRepository`, `ResultStreamFetcher`, `ResultStreamFetcherList`; Dio, Retrofit, WebSocket, and JSON-RPC from `dart_falconnect` | `jaspr_falconnect` | `package:jaspr_falconnect/jaspr_falconnect.dart` |
| `PageHead`, SEO meta tags, Schema.org JSON-LD, `ThemeBootScript` and `setThemePreference`, `SpeculationRules`, `NavigationProgress` | `jaspr_falkit` | `package:jaspr_falkit/jaspr_falkit.dart` |
| Browser localStorage (`KeyValueStorage`) | `jaspr_falstore` | `package:jaspr_falstore/jaspr_falstore.dart` |
| Sentry errors and Umami analytics (`Monitoring`) | `jaspr_falmonitor` | `package:jaspr_falmonitor/jaspr_falmonitor.dart` |
| Server-only shelf middleware: versioned assets, `Cache-Control`, security headers, sitemap, internal CMS URL | `jaspr_falserver` | `package:jaspr_falserver/jaspr_falserver.dart` |

A single package's barrel re-exports only what its skill says. `jaspr_falkit` re-exports `jaspr_falmodel`; `jaspr_falconnect` does not, so code that names `Result` or `ComponentState` next to `jaspr_falconnect` also lists `jaspr_falmodel` (or lists `jaspr_falconx` instead). No `jaspr_fal*` barrel re-exports `jaspr`; list and import it yourself.

## Git dependency

```yaml
dependencies:
  jaspr_falconx:                     # or one package from the table
    git:
      url: https://github.com/Nextzy/jaspr-falconx
      ref: <version>                 # a tag such as the latest from `git ls-remote --tags`, or its commit hash; see below
      path: jaspr_falconx            # the package name: jaspr_faltool, jaspr_falserver, ...
environment:
  sdk: ">=3.13.0 <4.0.0"            # not below the constraint in jaspr_falconx/pubspec.yaml
```

Add `jaspr` beside it with a constraint that allows the one in `jaspr_falconx/pubspec.yaml`.

### One `ref:` for every listed package

Use the same `ref:` and the same `url` spelling for every `jaspr_fal*` package you list, across every pubspec of a workspace. Pub treats a `.git` suffix, an SSH URL, or another ref as a different source.

Inside the repository, a package names its siblings with `path: ../<package>`. Pub resolves such a path inside the same git checkout, at the commit hash your `ref:` resolved to, not at the tag name. So:

- A tag works when no package you list depends on another package you list: `jaspr_falconx` alone, `jaspr_falconx` with `jaspr_falserver`, or `jaspr_falstore` with `jaspr_falmonitor`.
- When one listed package depends on another, a tag fails version solving with "jaspr_falmodel from git ... at `<hash>` in jaspr_falmodel is required". Write the tag's full 40-character commit hash as `ref:` for every listed package; a short hash fails the same way. Read it with `git ls-remote --tags https://github.com/Nextzy/jaspr-falconx 'refs/tags/<version>' 'refs/tags/<version>^{}'`. For an annotated tag this prints two lines; take the hash on the `refs/tags/<version>^{}` line, because the other one is the tag object's hash and fails the same way. A lightweight tag prints one line, and its hash is the commit.

| Package | Depends on these siblings |
|---|---|
| `jaspr_faltool` | none |
| `jaspr_falmodel` | `jaspr_faltool` |
| `jaspr_falconnect` | `jaspr_falmodel`, `jaspr_faltool` |
| `jaspr_falstore` | `jaspr_falmodel`, `jaspr_faltool` |
| `jaspr_falmonitor` | `jaspr_faltool` |
| `jaspr_falkit` | `jaspr_falmodel`, `jaspr_falstore`, `jaspr_faltool` |
| `jaspr_falconx` | every package except `jaspr_falserver` |
| `jaspr_falserver` | none (only `jaspr` and `shelf`) |

`jaspr_faltool`, `jaspr_falmodel`, and `jaspr_falconnect` depend on `dart_faltool`, `dart_falmodel`, and `dart_falconnect` as git dependencies from `https://github.com/Nextzy/dart-falconx`, at the ref their own `pubspec.yaml` pins. List a `dart_fal*` package yourself only with that url and that ref.

To build against a local clone, put `dependency_overrides` with `path:` entries in a gitignored `pubspec_overrides.yaml` beside the app's `pubspec.yaml`.

## Imports

```dart
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falconx/jaspr_falconx.dart';
```

A project that lists single packages imports each barrel from the table instead. An app that imports a package directly (`jaspr_router`, `retrofit`, `shelf`, a `dart_fal*` barrel) also lists it in its own `pubspec.yaml`, or `dart analyze` reports `depend_on_referenced_packages`. With the umbrella import, `jaspr_router` is already in scope; do not list or import it separately.

### `jaspr_falserver` in server code only

`jaspr_falserver` imports `dart:io` and `package:jaspr/server.dart`, so the browser build cannot compile it. List it on its own, and import `package:jaspr_falserver/jaspr_falserver.dart` only from the server entrypoint (`main.server.dart`) and code that only the server entrypoint reaches. Its functions return shelf's `Middleware`, which neither its barrel nor `package:jaspr/server.dart` re-exports: to name that type, list `shelf` and import `package:shelf/shelf.dart`. The skill shipped for `jaspr_falserver` covers the wiring.

## Hidden and clashing names

- The `jaspr_faltool` barrel, and so the umbrella, hides fpdart's `Unit` and `option`, so jaspr's CSS `Unit` and `<option>` element win; write `Option.of(...)` or `some(...)` for an fpdart option. It also hides numeral's `NumeralNumExtension`, so `.percent` on a number is jaspr's CSS unit. See the skill shipped for `jaspr_faltool`.
- `dart_falconnect` hides Retrofit's `Headers`, `CacheControl`, and `Parser`, and dio_cache_interceptor's `BaseRequest`, `BaseResponse`, and `HttpDate`. For Retrofit's, list `retrofit` and write `import 'package:retrofit/retrofit.dart' as retrofit;`; an unprefixed import beside the umbrella makes `@Headers` an `ambiguous_import` with dio's. See the skill shipped for `dart_falconnect`.
- `package:jaspr/server.dart` exports shelf's `Handler`, `Request`, and `Response`, and the umbrella exports dio's `Response`. In a server file that imports both and names `Response`, hide it on the import you do not use:

```dart
import 'package:jaspr/server.dart';
import 'package:jaspr_falconx/jaspr_falconx.dart' hide Response;

Response healthCheck(Request request) {
  logServerInfo('health check ${request.url}');
  return Response.ok('ok');
}
```

- `dart:io` and the umbrella both declare `HttpResponse` (the umbrella's is Retrofit's). Dart lets the package name win over the `dart:` one without a diagnostic, so `HttpResponse` beside the umbrella is always Retrofit's, which code Retrofit generates for a method returning `HttpResponse<T>` needs. In server code that needs `dart:io`'s, write `import 'dart:io' as io;` and `io.HttpResponse`.
- Code that reaches the browser (`@client` islands and anything they import) never imports `dart:io`, `package:jaspr/server.dart`, or `jaspr_falserver`. Server code may use `dart:io`.
