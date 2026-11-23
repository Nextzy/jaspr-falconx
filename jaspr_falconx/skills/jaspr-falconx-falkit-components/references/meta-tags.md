# Meta tags

`package: jaspr_falkit`. `SeoMetaTags` (see `references/page-head.md`) renders all of these for you; use them one by one only for a page that skips `SeoMetaTags`. Every component here except `Meta` and `LinkHeader` wraps its output in `Document.head`, so it can sit anywhere in the server-rendered tree.

Every parameter is optional unless the table says otherwise. A `String?` that is `null` or blank emits no tag.

## `DefaultMeta`

| Parameter | Emits |
|---|---|
| `title` | `<title>`, text-escaped |
| `description`, `publisher`, `author`, `robots`, `themeColor` | `<meta name="...">` (`theme-color` for `themeColor`) |
| `keywords` (`List<String>`) | one `keywords` meta, trimmed and joined with `, ` |
| `canonical` | `<link rel="canonical">` |
| `favicon` | `<link rel="icon" sizes="any">` |
| `faviconSvg` | `<link rel="icon" type="image/svg+xml">` |
| `manifest` | `<link rel="manifest">` |
| `imageSrc` | `<link rel="image_src">` |

## OpenGraph

`DefaultOpenGraphMeta`:

| Parameter | Default | Emits |
|---|---|---|
| `type` (`OgType?`) | `null` | `og:type` with the type's string |
| `title`, `description`, `url`, `imageUrl`, `locale`, `video` | `null` | `og:title`, `og:description`, `og:url`, `og:image`, `og:locale`, `og:video` |
| `siteName` | `null`, falls back to `title` | `og:site_name` |
| `imageAlt` | `null`, falls back to `description` | `og:image:alt` |
| `imageWidth`, `imageHeight` | `'1200'`, `'630'` | `og:image:width`, `og:image:height`, always |

`ArticleOpenGraphMeta` takes `author`, `section`, `tags` (`List<String>`, one `article:tag` each), `publishedTime`, and `modifiedTime` (`DateTime`, written with `toIso8601String()`).

`OgType` values and the string each writes: `website`, `article`, `book`, `profile`, `videoMovie` (`video.movie`), `videoEpisode` (`video.episode`), `videoTvShow` (`video.tv_show`), `videoOther` (`video.other`), `musicSong` (`music.song`), `musicAlbum` (`music.album`), `musicPlaylist` (`music.playlist`), `musicRadioStation` (`music.radio_station`), `business` (`business.business`), `place`, `product`, `restaurant`, `fitnessCourse` (`fitness.course`). The string is the enum's `name` field, so `OgType.videoMovie.name` is `video.movie`. `OgType.fromJson` returns `website` for an unknown string.

## Platform meta

| Component | Parameters (defaults) | Always emits |
|---|---|---|
| `TwitterMeta` | `card` (`'summary_large_image'`), `site`, `creator`, `title`, `description`, `image`, `imageAlt` | `twitter:card`, with no `content` when `card` is `null` |
| `AppleMeta` | `title`, `capable`, `fullscreen`, `iconUrl`, `color`, `appleIcon`, `pwaScript` (URL of an iOS splash library, default `null`) | `apple-mobile-web-app-status-bar-style` `default`, `apple-mobile-web-app-capable`, `mobile-web-app-capable`, `apple-touch-fullscreen` (`capable` and `fullscreen` default to `yes`), and, only when `pwaScript` is set, an inline script |
| `MicrosoftMeta` | `msValidate` (`null`), `tileColor`, `tileImageUrl` | `msvalidate.01`, only when `msValidate` is not blank |
| `PinterestMeta` | `pinterestRichPin`, `author` | `pinterest-rich-pin` (`true` when `null`); `author` writes `article:author` |

`AppleMeta` adds `<link rel="apple-touch-icon">` from `appleIcon ?? iconUrl`. Its inline script waits for `window.load`, checks for iOS, then loads `pwaScript` and calls `iosPWASplash(icon, color ?? '#FFFFFF')`. With no icon it passes `null`. With `pwaScript` unset or blank it renders no script and loads nothing. Values go into the script as JSON string literals, so a quote or `</script>` in them cannot break out.

## `AlternateLanguageMeta`

`AlternateLanguageMeta(List<AlternateLanguageTag> tags)` takes a positional list. `AlternateLanguageTag({String? locale, String? url})` becomes `<link rel="alternate" hreflang="locale" href="url">`; a `null` locale drops `hreflang`, a `null` url writes `href=""`. `PageHead` builds these tags for you.

## `Meta` and `LinkHeader`

Each renders a bare `<meta>` or `<link>`; place it inside `Document.head`.

| Component | Parameters (defaults) | `id` |
|---|---|---|
| `Meta` | `id`, `name`, `property`, `content`, `unique` (`false`) | with `unique: true`, a 5-character hash of `id`, `name`, and `property` |
| `LinkHeader` | `href` (required), `id`, `rel`, `type`, `as`, `attributes`, `events`, `unique` (`true`) | with `unique: true`, a hash of `id`, `href`, `rel`, `type`, `as`, and `attributes`; the singleton links (`canonical`, `manifest`, `image_src`, `apple-touch-icon`, the favicons, and the `hreflang` alternates, one per locale) use a fixed `id`, so a deeper head replaces them |

jaspr's `Document.head` lets a deeper or later head replace an element with the same `id`, a `<meta>` with the same `name`, and any `<title>`. The hashed `id` extends that to `property` metas such as `og:title`.

```dart
class PlainHead extends StatelessComponent {
  const PlainHead({super.key});

  @override
  Component build(BuildContext context) => Component.fragment([
    const DefaultMeta(
      title: 'Pricing',
      description: 'Plans and prices',
      canonical: 'https://acme.example/en/pricing',
    ),
    const DefaultOpenGraphMeta(
      title: 'Pricing',
      type: OgType.website,
      url: 'https://acme.example/en/pricing',
      imageUrl: 'https://acme.example/og.png',
    ),
    Document.head(
      children: const [
        Meta(property: 'og:image:type', content: 'image/png', unique: true),
        LinkHeader(rel: 'preload', href: '/a.css', as: 'style', unique: false),
        LinkHeader(rel: 'preload', href: '/b.css', as: 'style', unique: false),
      ],
    ),
  ]);
}
```

## Gotchas

- Singleton links (`canonical`, `manifest`, `image_src`, `apple-touch-icon`, and the two favicon links) are keyed by `rel`, so the deepest head wins; other `unique: true` links are keyed by `rel` plus `href`, so links with different `href` coexist.
- `ArticleOpenGraphMeta`'s `article:author` and `PinterestMeta`'s `author` both write `article:author`, so an article page rendered by `SeoMetaTags` can carry it twice.
- `AppleMeta` renders its inline script only when `pwaScript` is set. A `script-src` policy must then allow the inline script and the `pwaScript` host, or iOS gets no splash screen.
