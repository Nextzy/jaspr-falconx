# Changelog

## 4.0.0

falconx moves from SPA-style hydration to Jaspr islands. Pages render on the server, and only `@client` islands hydrate. `jaspr_falmonitor` is unchanged and keeps its own version.

### Added

- `jaspr_falserver` (new package): `CachePolicy`, `assetMiddleware`, `versionedPath`, `splitVersion`, `versionedServerOptions`.
- `jaspr_falconx`: `ServerData`, `requestHeader`, `setResponseStatus`, `pickLocale`, `localeFromPath`, and `FalUsecase` with its `mapUserMessage` hook.
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
