# Sitemap

`package: jaspr_falserver`. Server-only: import it only from the server entrypoint and code that only the server entrypoint reaches.

## `SitemapUrl` and `renderSitemap`

| Member | Behavior |
|---|---|
| `SitemapUrl({required String loc, Map<String, String> alternates = const {}, DateTime? lastModified})` | one `<url>`: `loc`, hreflang alternates keyed by language code, and an optional last-modified time |
| `String renderSitemap(Iterable<SitemapUrl> urls)` | a `<urlset>` document with the `xhtml` namespace; escapes `&`, `<`, `>`, `"`, and `'` in every URL and language code |

`lastModified` is converted to UTC and written as a date only (`<lastmod>2026-11-23</lastmod>`). Each `alternates` entry becomes `<xhtml:link rel="alternate" hreflang="<language>" href="<url>"/>`, in map order.

```dart
final homeEntries = [
  SitemapUrl(
    loc: 'https://example.com/th',
    alternates: const {
      'th': 'https://example.com/th',
      'en': 'https://example.com/en',
    },
    lastModified: DateTime.utc(2026, 11, 23),
  ),
];

String homeSitemapXml() => renderSitemap(homeEntries);
```

## `sitemapMiddleware`

`Middleware sitemapMiddleware(Future<Iterable<SitemapUrl>> Function() load, {String path = '/sitemap.xml'})`

- Answers `GET` and `HEAD` on `path` (a leading `/` is optional) with `renderSitemap(await load())` and `content-type: application/xml; charset=utf-8`.
- Every other request passes through, as does a request that `assetMiddleware` rewrote from a `_v/` URL.
- When `load` throws, answers 503 with `retry-after: 60` and writes one line to stderr.
- Sets no `cache-control`; `assetMiddleware` above it does (`public, max-age=0, s-maxage=<htmlEdgeTtl>` for the sitemap).

```dart
Middleware sitemap() => sitemapMiddleware(
  () async => homeEntries,
  path: '/sitemap.xml',
);
```

## Gotchas

- `load` runs on every sitemap request, with no caching. Cache the list yourself when it comes from a slow CMS call.
- `path` is compared with the request's handler-relative `url.path`, so it must match exactly; a query string is ignored by that comparison, but a trailing `/` is not.
- Register it after `assetMiddleware`; above it, the sitemap response gets no `Cache-Control`.
