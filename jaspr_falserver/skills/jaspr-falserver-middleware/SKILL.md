---
name: jaspr-falserver-middleware
description: Use when calling `jaspr_falserver` APIs such as `assetMiddleware`, `versionedServerOptions`, `versionedPath`, `CacheHeaderPolicy`, `securityHeadersMiddleware`, `sitemapMiddleware`, `renderSitemap`, `SitemapUrl`, or `resolveServerCmsBaseUrl` in a Jaspr server entrypoint, or before writing Cache-Control, security-header, sitemap, or build-versioned asset middleware of your own.
---

# jaspr_falserver middleware

Answers "does jaspr_falserver already provide this?" here and routes "how do I call it?" to one file under `references/`. `package: jaspr_falserver`; shelf middleware and helpers for a Jaspr server behind a CDN. The `Middleware` type these functions return comes from `package:shelf/shelf.dart`, which neither this barrel nor `package:jaspr/server.dart` re-exports, so an app that names the type lists `shelf` in its own `pubspec.yaml` and imports it.

The package is server-only: it imports `package:jaspr/server.dart` and `dart:io`. Import it only from the server entrypoint (`main.server.dart`) and code that only the server entrypoint reaches, never from a `@client` island, a component an island imports, or shared code. A component that sets a response header during server rendering uses `setResponseHeader` or `markNotCacheable` from `jaspr_falconx`, which do nothing in the browser.

## Capability map

| Need | Use | Ref |
|---|---|---|
| Serve `/_v/<buildId>/<file>` and set `Cache-Control` | `assetMiddleware(buildId:, policy:)` | `references/assets.md` |
| Move Jaspr's client script and stylesheet under the build version | `versionedServerOptions(base, buildId)` | `references/assets.md` |
| Version a link you write in the head | `versionedPath(path, buildId)`; `splitVersion`, `kVersionPrefix` | `references/assets.md` |
| Change the cache lifetimes | `CacheHeaderPolicy(htmlEdgeTtl:, imageTtl:, fontTtl:)` | `references/assets.md` |
| `Referrer-Policy`, `Permissions-Policy`, `Content-Security-Policy` | `securityHeadersMiddleware(...)` and the `default*` constants | `references/headers.md` |
| `/sitemap.xml` | `sitemapMiddleware(load, path:)`, `SitemapUrl`, `renderSitemap` | `references/sitemap.md` |
| Use a private CMS URL only when it answers | `resolveServerCmsBaseUrl`, `validInternalCmsUrl`, `pingOk` | below |

## Wiring

```dart
// Set with --dart-define-server=BUILD_ID=<id>; empty in local runs.
const String kBuildId = String.fromEnvironment('BUILD_ID');
String? get buildId => kBuildId.isEmpty ? null : kBuildId;

// generatedOptions is defaultServerOptions from main.server.options.dart.
void setUpServer(ServerOptions generatedOptions) {
  Jaspr.initializeApp(
    options: versionedServerOptions(generatedOptions, buildId),
  );

  // The first middleware added is the outermost layer.
  ServerApp.addMiddleware(securityHeadersMiddleware());
  ServerApp.addMiddleware(assetMiddleware(buildId: buildId));
  ServerApp.addMiddleware(sitemapMiddleware(loadSitemapUrls));
  // Then call runApp with your Document.
}

Future<Iterable<SitemapUrl>> loadSitemapUrls() async => const [
  SitemapUrl(loc: 'https://example.com/'),
];
```

Keep this order. `securityHeadersMiddleware` goes first so it also covers responses the inner layers answer themselves, such as the 404 for a versioned page route. `assetMiddleware` sits above `sitemapMiddleware` so the sitemap response gets `Cache-Control`. A compression middleware such as `gzipMiddleware` from `shelf_gzip` goes between the security headers and `assetMiddleware`.

Build with a new id for every deploy, for example `jaspr build --dart-define-server=BUILD_ID=$(git rev-parse --short HEAD)`. Without `BUILD_ID`, URLs stay unversioned and every `_v/` request gets `no-store`.

## Internal CMS URL

```dart
// internalUrl is, for example, Platform.environment['CMS_INTERNAL_API_BASE_URL'].
Future<String> cmsBaseUrl(String? internalUrl) => resolveServerCmsBaseUrl(
  publicUrl: 'https://cms.example.com',
  internalUrl: internalUrl,
  probe: pingOk,
  log: print,
);
```

| Function | Behavior |
|---|---|
| `resolveServerCmsBaseUrl({required publicUrl, internalUrl, required probe, log})` | returns the internal URL only when `probe` returns `true`; returns `publicUrl` when `internalUrl` is unset or invalid (`probe` not called) or when `probe` returns `false` or throws, and then passes `log` one line with the reason (none for an unset URL) |
| `validInternalCmsUrl(value)` | trims and removes one trailing `/`; returns `null` unless the value is an absolute `http` or `https` URL with a host |
| `pingOk(baseUrl, {path = '/server/ping', timeout = 2 s})` | `true` on a 200 within `timeout` in total; throws `StateError('HTTP <code>')` on another status, and throws on a network error or timeout |

Call `resolveServerCmsBaseUrl` once at startup, so a dead private network falls back to the public URL instead of failing every page.

## Do not reinvent

- Before writing shelf middleware for caching, security headers, a sitemap, or asset versioning, scan the map above.
- Do not build `_v/<id>/` URLs by hand; use `versionedPath`, which agrees with `assetMiddleware`.

## Gotchas

- Server-only throughout: the barrel brings in `package:jaspr/server.dart` (for `ServerOptions`) and `dart:io` (the sitemap's `stderr` line and `pingOk`'s `HttpClient`), which the browser build cannot compile.
- Code that reaches the browser (`@client` islands and anything they import) never imports `dart:io`, `package:jaspr/server.dart`, or `jaspr_falserver`. Server code may use `dart:io`.
- `versionedServerOptions` copies the four `ServerOptions` fields of jaspr 0.23 (`clientId`, `clients`, `stylesId`, `styles`) one by one. When a newer jaspr adds a field, the copy drops it until this package adds it.
- Every middleware here keeps a header the inner handler already set: `assetMiddleware` keeps `cache-control`, and `securityHeadersMiddleware` keeps each of its three headers.
- Write constructors with the type name (`const Foo(...)`, `Foo._()`), never `new(...)`: consuming apps run jaspr_builder 0.23.5, which rejects primary constructors.

## Out of scope

General shelf usage, CDN configuration beyond the notes in `references/assets.md`, and package internals.
