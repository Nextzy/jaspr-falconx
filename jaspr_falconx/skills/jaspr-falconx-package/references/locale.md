# Locale

`package: jaspr_falconx` (`lib/src/locale/`). Pure functions over plain language-code strings; they run on the server and in the browser. They do not use `Locale` from `jaspr_falmodel`.

## Functions

| Function | Returns |
|---|---|
| `String? localeFromPath(String path, Iterable<String> supported)` | the first non-empty segment of `path` when `supported` contains it exactly, else `null`; ignores `?query` and `#fragment`, and looks at no later segment |
| `String pickLocale(String? acceptLanguage, Iterable<String> supported, {required String fallback})` | the best `supported` language from an `Accept-Language` value, else `fallback` |
| `String switchLocalePath(String path, String toCode, Iterable<String> supported)` | `path` with its first segment replaced by `toCode` when that segment is in `supported`, else with `toCode` prefixed; keeps `?query` and `#fragment` |

`pickLocale` lowercases each tag, drops its region subtag (`th-TH` matches `th`), ranks by q-value (ties keep header order), and refuses `q=0`. A missing, blank, or unmatched header returns `fallback`.

| Call (`supported` = `['th', 'en']`) | Result |
|---|---|
| `localeFromPath('/th/blog?x=1', supported)` | `'th'` |
| `localeFromPath('/blog', supported)` | `null` |
| `localeFromPath('/TH/blog', supported)` | `null` |
| `pickLocale('th-TH,th;q=0.9,en;q=0.8', supported, fallback: 'en')` | `'th'` |
| `pickLocale('fr, en;q=0.5', supported, fallback: 'th')` | `'en'` |
| `pickLocale('en;q=0.5,th;q=0.5', supported, fallback: 'th')` | `'en'` |
| `pickLocale(null, supported, fallback: 'th')` | `'th'` |
| `switchLocalePath('/th/blogs/abc?page=2', 'en', supported)` | `'/en/blogs/abc?page=2'` |
| `switchLocalePath('/blogs', 'en', supported)` | `'/en/blogs'` |
| `switchLocalePath('/', 'en', supported)` | `'/en'` |
| `switchLocalePath('/th/blog/', 'en', supported)` | `'/en/blog'` |

## Sample

```dart
const List<String> supportedLocales = ['th', 'en'];
const String defaultLocale = 'th';

// Sends `/` to the visitor's preferred locale. On the server the header is
// read from the request; in the browser requestHeader returns null, so the
// fallback wins.
Route localeRootRoute() => Route(
  path: '/',
  redirect: (context, state) {
    final code = pickLocale(
      requestHeader(context, 'accept-language'),
      supportedLocales,
      fallback: defaultLocale,
    );
    return '/$code';
  },
);

String currentLocale(RouteState state) =>
    localeFromPath(state.location, supportedLocales) ?? defaultLocale;

String languageSwitchHref(RouteState state, String toCode) =>
    switchLocalePath(state.location, toCode, supportedLocales);
```

`Route` and `RouteState` are `jaspr_router`'s, re-exported by `jaspr_falconx`; `requestHeader` is in `references/rendering.md`.

## Gotchas

- List `supported` as lowercase base language codes (`'th'`, `'en'`). `pickLocale` compares only the lowercased language subtag, so an entry such as `'zh-TW'` or `'EN'` never matches; `localeFromPath` and `switchLocalePath` match segments exactly, so `/TH/...` is not a locale path.
- `*` in `Accept-Language` matches nothing unless `supported` contains `'*'`; a q-value that does not parse counts as 0 and refuses the language.
- `pickLocale` needs a real request. A `static`-mode build renders each page once at build time, with no visitor's `Accept-Language`, so the redirect above always picks `fallback` there.
- `switchLocalePath` does not check `toCode` against `supported`, collapses empty segments, and drops a trailing `/`.
- Code that reaches the browser (`@client` islands and anything they import) never imports `dart:io`, `package:jaspr/server.dart`, or `jaspr_falserver`. Server code may use `dart:io`.
