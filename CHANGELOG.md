# Changelog

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
- The `jaspr_riverpod` dependency and its re-export.

### Migration: SPA hydration to islands

- `PreloadFamily` and `syncWith`: use `ServerData` on server-only pages. Riverpod 3's default provider retry kept a failed server-side `FutureProvider.future` from ever settling, so requests hung (seen on an unknown policy id). `ServerData` has no retry, and a failed `Result` renders the error builder with `cache-control: no-store`.
- `ThemeManager`: put `ThemeBootScript` in the document head and call `setThemePreference` from a `@client` island.
- Page SEO base: use `PageHead`.
- App cache middleware: use `jaspr_falserver.assetMiddleware` with `versionedServerOptions`, which gives client assets fingerprinted URLs.
- Client entry: use `runApp(const ClientApp())` from Jaspr, so only `@client` islands hydrate.

#### Wiring

`jaspr_falserver/README.md` has the full server recipe: `Jaspr.initializeApp(options: versionedServerOptions(defaultServerOptions, buildId))`, `gzipMiddleware` added before `assetMiddleware`, `BUILD_ID` passed with `jaspr build --dart-define-server=BUILD_ID=<id>`, `versionedPath` for links in the head, the header table, and the Cloudflare Cache Rule that HTML needs before the edge caches it.

Name the header policy `CacheHeaderPolicy`; the 4.0.0 drafts called it `CachePolicy`. A page that renders with partial data calls `markNotCacheable(context)`, and a page that answers 503 can add `Retry-After` with `setResponseHeader(context, 'retry-after', '60')`.
