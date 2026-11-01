# Changelog

## 4.3.0

A page can now answer 404 or 503 from the CMS status, a locale switcher can build its links, and a server can reach the CMS over a private URL and publish a sitemap. `jaspr_falmonitor` is unchanged and keeps its own version.

### Added

- `jaspr_falconx`: `pageErrorStatus(error)` returns 404 when the CMS answered 403 or 404, and 503 for every other failure, so crawlers retry. `isExpectedPageFailure(error)` is true for a missing record, which suits `ServerData.quietWhen`. `switchLocalePath(path, toCode, supported)` replaces the locale segment of a path, or prefixes one when the path has none, and keeps the query and fragment.
- `jaspr_falserver`: `validInternalCmsUrl` normalizes a private CMS URL and returns null when it is empty or not an absolute `http`/`https` URL. `resolveServerCmsBaseUrl` picks that URL only when a probe reaches it, and otherwise falls back to the public URL. It falls back silently when the internal URL is unset or blank, and logs one line when the URL is set but malformed or the probe fails or throws. `pingOk` is a probe for it: it asks `/server/ping` and returns true on a 200, and it throws on another status, a network error, or a 2-second timeout. `SitemapUrl`, `renderSitemap`, and `sitemapMiddleware` write a sitemap with hreflang alternates and serve it on GET and HEAD; a failing loader gives 503 with `retry-after: 60`.
- `jaspr_falkit`: `PageHead` takes an optional `defaultLanguageCode`. When set, the `x-default` alternate points at that language's URL; when null, it points at the current page as before.
- `jaspr_falconnect`: `FalRepository` is the data-layer sibling of `FalUsecase`. Its `runDataCatching` returns the call's `Result` and turns a thrown `DioException`, `CommonException`, or any other object into a failed `Result` holding a `DataLayerException`.

### Changed

- `jaspr_falserver`: `assetMiddleware` keeps versioned URLs away from the sitemap route.

### Fixed

- `jaspr_falkit`: `DefaultOpenGraphMeta` no longer preloads the share image, so the page stops downloading it early on every load.
- `jaspr_falkit`: `PageHead` builds the canonical, `og:url`, alternates, and `PageSeoContext.url` from the path alone, so a query string such as `?fbclid=abc` or a fragment no longer reaches them.

## 4.2.0

`NavigationProgress` is now flat by default, with no shadow. The new `glow` parameter restores the 4.1.0 look.

## 4.1.0

A site that does full page loads on navigation can now show a thin progress bar, and `ServerData` can log an expected failure without a stack trace. `jaspr_falmonitor` is unchanged and keeps its own version.

### Added

- `jaspr_falkit`: `NavigationProgress`. It draws a bar fixed to the top of the page when the next page takes longer than `showDelay` (150 ms by default) to arrive after a link click. You can set `color`, `height`, and `zIndex`. The bar does not creep for visitors who prefer reduced motion. It is a plain inline script, so it works before any island loads.
- `jaspr_falconx`: `ServerData.quietWhen`. When it returns true for a failed load, `ServerData` logs one info line with the exception type and message and no stack trace. The response stays the same: `no-store` and `errorBuilder`. The line goes through the new `logServerInfo`, which writes to stderr on the server, in release builds too.

## 4.0.0

falconx moves from SPA-style hydration to Jaspr islands. Pages render on the server, and only `@client` islands hydrate. `jaspr_falmonitor` is unchanged and keeps its own version.

### Added

- `jaspr_falserver` (new package): `CacheHeaderPolicy`, `assetMiddleware`, `versionedPath`, `splitVersion`, `versionedServerOptions`. `CacheHeaderPolicy` takes `htmlEdgeTtl`, `imageTtl`, and `fontTtl`, and gives a public policy only to a `GET` or `HEAD` response that sets no cookie. It is not called `CachePolicy` because `dio_cache_interceptor` exports a `CachePolicy` through `jaspr_falconnect`, and the two names would clash in a server entrypoint that imports both barrels.
- `jaspr_falconx`: `ServerData`, `requestHeader`, `setResponseStatus`, `setResponseHeader`, `markNotCacheable`, `logServerError`, `pickLocale`, `localeFromPath`, and `FalUsecase` with its `mapUserMessage` hook. `markNotCacheable(context)` sets `cache-control: no-store` on the page being rendered; call it when the page renders with partial data. `setResponseHeader(context, name, value)` sets any response header, such as `Retry-After`. Both do nothing in the browser. `logServerError` writes to stderr on the server, in release builds too, and `ServerData` uses it to log a failed load.
- `jaspr_falkit`: `ThemeBootScript`, `themeStorageKey`, `nextThemeMode`, `setThemePreference` (requires `ThemeBootScript` in the document head), `PageHead`, `PageSeoContext`, `SpeculationRules`, `speculationRulesJson`.
- `jaspr_faltool`: formatter extensions. The string member is `truncateText` because `dart_faltool` already defines `String.truncate`. Apps that move their own `truncate` extension onto falconx must rename those calls.
- `jaspr_falconnect`: `jasprHttpClientConfig`, and a dependency on `pretty_dio_logger`. Its `debugLogging` parameter defaults to `kDebugMode`, so release builds do not add the logger interceptor.

### Removed (breaking)

- `PreloadFamily`, `PreloadListFamily`, `PreloadComponentNotifier`, `ComponentStateNotifier`, `NullableComponentStateNotifier`.
- The json and riverpod codecs.
- `ThemeManager` and `ThemeProvider`.
- The `jaspr_riverpod` dependency and its re-export. Apps that still use Riverpod must depend on `jaspr_riverpod` directly. The `jaspr_falconx` barrel no longer hides `AsyncError`, so `AsyncError` from `dart:async` is visible again through it.

### Migration: SPA hydration to islands

- `PreloadFamily` and `syncWith`: use `ServerData` on server-only pages. Riverpod 3's default provider retry kept a failed server-side `FutureProvider.future` from ever settling, so requests hung (seen on an unknown policy id). `ServerData` has no retry, and a failed `Result` renders the error builder with `cache-control: no-store`.
- `ThemeManager`: put `ThemeBootScript` in the document head and call `setThemePreference` from a `@client` island.
- Page SEO base: use `PageHead`.
- App cache middleware: use `jaspr_falserver.assetMiddleware` with `versionedServerOptions`, which gives client assets fingerprinted URLs.
- Client entry: use `runApp(const ClientApp())` from Jaspr, so only `@client` islands hydrate.

#### Wiring

`jaspr_falserver/README.md` has the full server recipe: `Jaspr.initializeApp(options: versionedServerOptions(defaultServerOptions, buildId))`, `gzipMiddleware` added before `assetMiddleware`, `BUILD_ID` passed with `jaspr build --dart-define-server=BUILD_ID=<id>`, `versionedPath` for links in the head, the header table, and the Cloudflare Cache Rule that HTML needs before the edge caches it.

Name the header policy `CacheHeaderPolicy`; the 4.0.0 drafts called it `CachePolicy`. A page that renders with partial data calls `markNotCacheable(context)`, and a page that answers 503 can add `Retry-After` with `setResponseHeader(context, 'retry-after', '60')`.
