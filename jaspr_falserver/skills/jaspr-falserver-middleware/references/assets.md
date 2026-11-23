# Assets and cache headers

`package: jaspr_falserver`. Server-only: import it only from the server entrypoint and code that only the server entrypoint reaches.

## `assetMiddleware`

`Middleware assetMiddleware({required String? buildId, CacheHeaderPolicy policy = const CacheHeaderPolicy()})`

For each request:

1. A path `_v/<id>/<rest>` whose last segment has no file extension (a page route such as `_v/<id>/en/profile`) gets a 404 with `cache-control: no-store`; the inner handler is never called.
2. Any other `_v/<id>/<rest>` is forwarded as `/<rest>`, whatever `<id>` is, so a tab left open across a deploy still gets the current file.
3. The response gets the `cache-control` value `policy` chooses, unless the inner handler already set one.

## Header policy

`CacheHeaderPolicy.headerFor` returns the first row that matches, top to bottom, for the original request path (version prefix included).

| Response | `Cache-Control` |
|---|---|
| Inner handler already set `cache-control` | kept |
| Method other than `GET` or `HEAD` | `no-store` |
| Response with a `set-cookie` header | `no-store` |
| Status other than 2xx or 304 | `no-store` |
| `_v/<current build id>/<file>` | `public, max-age=31536000, immutable` |
| `_v/<other id>/<file>`, or any `_v/` path when `buildId` is null or empty | `no-store` |
| Image (`avif`, `webp`, `svg`, `png`, `jpg`, `jpeg`, `gif`, `ico`) | `public, max-age=<imageTtl>` (default 1 day) |
| Font (`woff2`, `woff`, `ttf`, `otf`) | `public, max-age=<fontTtl>` (default 30 days) |
| Anything else, HTML included | `public, max-age=0, s-maxage=<htmlEdgeTtl>` (default 1 day) |

Browsers always revalidate HTML (`max-age=0`), while the CDN keeps it for `s-maxage`. A 304 gets the same header as the 2xx it revalidates.

```dart
// Middleware is from package:shelf.
Middleware assetsWithShortHtmlCache(String? buildId) => assetMiddleware(
  buildId: buildId,
  policy: const CacheHeaderPolicy(
    htmlEdgeTtl: Duration(hours: 1),
    imageTtl: Duration(days: 7),
    fontTtl: Duration(days: 365),
  ),
);
```

## Versioned paths

| Member | Behavior |
|---|---|
| `kVersionPrefix` | `'_v'` |
| `versionedPath(path, buildId)` | `_v/<buildId>/<path>` with one leading `/` dropped; with a null or empty `buildId`, `path` without that leading `/` |
| `splitVersion(path)` | `(id:, rest:)` for `_v/<id>/<rest>` (a leading `/` allowed), else `null` |
| `versionedServerOptions(base, buildId)` | a copy of `base` with `clientId` and `stylesId` passed through `versionedPath` |

```dart
String stylesheetHref(String? buildId) => versionedPath('styles.css', buildId);

bool isVersionedRequest(String path) => splitVersion(path) != null;
```

`versionedServerOptions` moves only the script and stylesheet that Jaspr injects. Version every other file you link from the head with `versionedPath`. Its result is relative (`_v/<id>/styles.css`), so it resolves from the site root only under `<base href="/">`, which Jaspr's `Document` emits by default; if your app changes `base`, prefix the result with `/`.

## Pages that must not be cached

A page whose server render used partial data (one of several CMS calls failed) must say so, or the CDN keeps the incomplete page for `htmlEdgeTtl`. Call `markNotCacheable` from `jaspr_falconx` in that component; `assetMiddleware` then keeps its `no-store`.

## CDN notes

- Cloudflare does not cache HTML by default, so the HTML row has no effect at the edge until a Cache Rule makes HTML eligible for cache and respects the origin `Cache-Control`.
- Do not add `stale-while-revalidate` to the HTML header; Cloudflare documents that `s-maxage` disables it.
- Purge the edge on every deploy and whenever content changes. Until a purge runs, the edge serves the old HTML for up to `htmlEdgeTtl`.

## Gotchas

- The 404 for a versioned page route is answered inside `assetMiddleware`, so a middleware added after it never sees that response; add `securityHeadersMiddleware` before it.
- `buildId` null in local runs is expected: links stay unversioned and nothing gets `immutable`.
- `versionedServerOptions` copies the jaspr 0.23 `ServerOptions` fields one by one; a field a newer jaspr adds is dropped until this package copies it.
