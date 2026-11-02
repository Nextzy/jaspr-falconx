# jaspr_falserver

Server-only helpers for a Jaspr app that sits behind a CDN. The package gives every response a `Cache-Control` header and serves build-versioned asset URLs:

- `assetMiddleware` is a shelf middleware. It serves `/_v/<buildId>/<file>` from `<file>` and sets `Cache-Control` through a `CacheHeaderPolicy`.
- `versionedServerOptions` moves the client script (and the standalone stylesheet, when the app uses one) under `_v/<buildId>/`.
- `versionedPath` builds the same versioned URL for links you write yourself.

It imports `package:jaspr/server.dart`, so only server entrypoints (`main.server.dart`) may import it. Code that islands can reach uses the conditional helpers in `jaspr_falconx` instead (`markNotCacheable`, `setResponseHeader`, `setResponseStatus`).

## Wiring

Pass the build id at build time, read it in the server entrypoint, and install the middleware after `Jaspr.initializeApp`:

```dart
import 'package:jaspr/server.dart';
import 'package:jaspr_falserver/jaspr_falserver.dart';
import 'package:shelf_gzip/shelf_gzip.dart';

import 'main.server.options.dart';

/// Set with `--dart-define-server=BUILD_ID=<id>`; empty in local runs.
const String kBuildId = String.fromEnvironment('BUILD_ID');
String? get buildId => kBuildId.isEmpty ? null : kBuildId;

void main() {
  Jaspr.initializeApp(
    options: versionedServerOptions(defaultServerOptions, buildId),
  );

  // Order matters: the first middleware added is the outermost one.
  ServerApp.addMiddleware(gzipMiddleware);
  ServerApp.addMiddleware(assetMiddleware(buildId: buildId));

  runApp(/* your Document */);
}
```

Add `gzipMiddleware` (from `shelf_gzip`) first and `assetMiddleware` second. Gzip is then the outer layer: it compresses the body that `assetMiddleware` returns and keeps the `Cache-Control` header it set.

Build with a new id for every deploy, for example the commit hash:

```bash
jaspr build --dart-define-server=BUILD_ID=$(git rev-parse --short HEAD)
```

Without `BUILD_ID`, `buildId` is null: URLs stay unversioned and any `_v/` request gets `no-store`.

### Links in the document head

`versionedServerOptions` only moves the script and stylesheet that Jaspr injects itself. Version every other file you link from the head with `versionedPath`:

```dart
link(rel: 'stylesheet', href: versionedPath('styles.css', buildId)),
script(src: versionedPath('scripts/analytics.js', buildId), defer: true),
```

`versionedPath` drops one leading `/` and returns the path unchanged when `buildId` is null or empty. The result is relative (`_v/<buildId>/styles.css`), so it resolves from the site root only when the page has `<base href="/">`, which Jaspr's `Document` emits by default. If your app changes `<base>`, prefix the result with `/` yourself.

## Header policy

`assetMiddleware` answers each response with the first row that matches, top to bottom; every row except the 404 comes from `CacheHeaderPolicy`. A header the page already set (for example with `markNotCacheable`) is kept.

| Response | `Cache-Control` |
|---|---|
| Any method other than `GET` or `HEAD` | `no-store` |
| Any response with a `set-cookie` header | `no-store` |
| Any status other than 2xx or 304 | `no-store` |
| `_v/<current build id>/<file>` | `public, max-age=31536000, immutable` |
| `_v/<other id>/<file>`, a tab left open across a deploy | `no-store` (the current file is served) |
| `_v/<id>/<path without a file extension>` | 404 with `no-store` |
| Image (`avif`, `webp`, `svg`, `png`, `jpg`, `jpeg`, `gif`, `ico`) | `public, max-age=86400` |
| Font (`woff2`, `woff`, `ttf`, `otf`) | `public, max-age=2592000` |
| Anything else, HTML included | `public, max-age=0, s-maxage=86400` |

Browsers always revalidate HTML (`max-age=0`), while the CDN keeps it for `s-maxage`. A 304 gets the same header as the 2xx it revalidates.

The three lifetimes are constructor parameters:

```dart
assetMiddleware(
  buildId: buildId,
  policy: const CacheHeaderPolicy(
    htmlEdgeTtl: Duration(hours: 1), // default: 1 day
    imageTtl: Duration(days: 7), // default: 1 day
    fontTtl: Duration(days: 365), // default: 30 days
  ),
);
```

### Pages that must not be cached

`ServerData` from `jaspr_falconx` sets `no-store` when its load fails. A page that renders with partial data (one of several CMS calls failed) must call `markNotCacheable(context)` itself, or the CDN keeps the incomplete page for `htmlEdgeTtl`.

## Internal CMS URL

A server that reaches its CMS over a private network skips the CDN for its own calls. `resolveServerCmsBaseUrl` picks the base URL once at startup: it uses the internal URL only when `probe` reports it reachable, and falls back to the public URL otherwise, so a dead private network never turns every page into a 503.

```dart
final cmsBaseUrl = await resolveServerCmsBaseUrl(
  publicUrl: publicUrl,
  internalUrl: Platform.environment['CMS_INTERNAL_API_BASE_URL'],
  probe: pingOk, // GET <baseUrl>/server/ping, 200 within 2 s
  log: print,
);
```

`validInternalCmsUrl` trims a value and removes one trailing `/`; it returns `null` unless the value is an absolute `http` or `https` URL with a host. `pingOk` returns `true` on 200, throws `StateError('HTTP <code>')` on another status, and throws on a network error or timeout.

## Sitemap

`sitemapMiddleware` serves `/sitemap.xml` (GET and HEAD) from a `load` callback that returns `SitemapUrl` entries. Each entry has a `loc`, optional hreflang `alternates`, and an optional `lastModified`; `renderSitemap` writes the XML and escapes every URL.

```dart
ServerApp.addMiddleware(assetMiddleware(buildId: buildId));
ServerApp.addMiddleware(sitemapMiddleware(() async => [
  SitemapUrl(
    loc: 'https://example.com/th',
    alternates: {'th': 'https://example.com/th', 'en': 'https://example.com/en'},
  ),
]));
```

Register it after `assetMiddleware`, which then sets `Cache-Control` on the response; the sitemap middleware sets none. When `load` throws, it answers 503 with `retry-after: 60` and writes one line to stderr.

## Security headers

`securityHeadersMiddleware` adds `Referrer-Policy`, `Permissions-Policy`, and `Content-Security-Policy` to every response, whatever the status or method. A header the page already set is kept.

```dart
ServerApp.addMiddleware(gzipMiddleware);
ServerApp.addMiddleware(assetMiddleware(buildId: buildId));
ServerApp.addMiddleware(securityHeadersMiddleware());
```

| Header | Default |
|---|---|
| `Referrer-Policy` | `strict-origin-when-cross-origin` |
| `Permissions-Policy` | `camera=(), microphone=(), geolocation=(), payment=(), usb=()` |
| `Content-Security-Policy` | `frame-ancestors 'self'; base-uri 'self'; object-src 'none'` |

The CSP has no `script-src`: that needs hashes for inline scripts and for scripts Cloudflare injects, so add it yourself. Pass a value to replace a default, or `null` to turn that header off:

```dart
securityHeadersMiddleware(
  contentSecurityPolicy: null,
  referrerPolicy: 'no-referrer',
);
```

A value containing `\r` or `\n` throws `ArgumentError` when the middleware is created.

## Cloudflare

Cloudflare does not cache HTML by default, so the HTML rows above have no effect at the edge until a Cache Rule makes HTML eligible for cache and tells Cloudflare to respect the origin `Cache-Control`.

Do not add `stale-while-revalidate` to the HTML header. Cloudflare documents that `s-maxage` disables it.

Purge the edge on every deploy and whenever content changes. Until a purge runs, the edge serves the old HTML for up to `htmlEdgeTtl`.
