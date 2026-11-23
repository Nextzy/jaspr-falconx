# Page head

`package: jaspr_falkit`: `PageHead`, `PageSeoContext`, `SeoDefaults`, and `SeoMetaTags`. Render all of them on the server, outside `@client` islands.

## Layout

Put one `SeoDefaults` above every page, and one `PageHead` per page. `PageHead` computes the URLs from the route and hands them to your `seo` builder, which returns the page's `SeoMetaTags`.

```dart
const String siteUrl = 'https://acme.example';

class SiteLayout extends StatelessComponent {
  const SiteLayout({
    required this.languageCode,
    required this.path,
    required this.title,
    required this.description,
    required this.child,
    super.key,
  });

  /// Language of this page, for example `th` for `/th/projects/42`.
  final String languageCode;

  /// Route location, for example `/en/projects/42`.
  final String path;
  final String title;
  final String description;
  final Component child;

  @override
  Component build(BuildContext context) => SeoDefaults(
    siteName: 'Acme',
    siteUrl: siteUrl,
    imageUrl: '$siteUrl/og.png',
    favicon: '/favicon.ico',
    twitter: const TwitterMeta(site: '@acme'),
    child: Component.fragment([
      Document.head(
        children: const [ThemeBootScript(), SpeculationRules()],
      ),
      PageHead(
        languageCode: languageCode,
        supportedLanguageCodes: const ['en', 'th'],
        siteUrl: siteUrl,
        path: path,
        rootBreadcrumbName: 'Home',
        breadcrumbName: (segment) => segment == 'projects' ? 'Projects' : null,
        seo: (seo) => SeoMetaTags(
          title: title,
          description: description,
          url: seo.url,
          canonical: seo.canonical,
          alternateLanguageUrls: seo.alternateLanguageUrls,
          breadcrumbItems: seo.breadcrumbItems,
        ),
      ),
      const NavigationProgress(),
      child,
    ]),
  );
}
```

`PageHead` does not read the language from `path`; pass the page's own code, or a `/th/...` page renders `lang="en"` and English breadcrumb URLs.

## `PageHead`

Emits `Document.html(attributes: {'lang': languageCode})` and `Document.head(children: [seo(context)])`.

| Parameter | Required | Meaning |
|---|---|---|
| `languageCode` | yes | `<html lang>` and the first segment of every breadcrumb URL |
| `supportedLanguageCodes` | yes | one `hreflang` alternate per code |
| `siteUrl` | yes | origin without a trailing slash |
| `path` | yes | route location starting with `/`; the query and fragment are dropped |
| `seo` | yes | `SeoMetaTags Function(PageSeoContext seo)` |
| `rootBreadcrumbName` | yes | name of the first breadcrumb |
| `breadcrumbName` | no | `String? Function(String segment)`; `null` keeps the raw segment |
| `defaultLanguageCode` | no | language the `x-default` alternate points at; `null` points it at the current page |

What it computes into `PageSeoContext`:

| Field | Value for `siteUrl: 'https://acme.example'`, `path: '/en/projects/42?x=1'`, codes `['en', 'th']` |
|---|---|
| `url` | `https://acme.example/en/projects/42` |
| `canonical` | the same as `url` |
| `alternateLanguageUrls` | `en` and `th` with the first segment swapped, then `x-default` |
| `breadcrumbItems` | `Home` at `/en`, `projects` (or your `breadcrumbName`) at `/en/projects`, `42` at `/en/projects/42` |

- The first path segment counts as a language code only when it is exactly two characters. Without one (`/policies/abc`), every alternate is the same URL, and the breadcrumbs keep every segment but still get the `languageCode` prefix (`/en/policies`).
- An empty path (`''` or `/`) gives no breadcrumbs.
- `PageSeoContext` has a public `const` constructor with the same four required fields, for tests or for building `SeoMetaTags` without `PageHead`.

## `SeoDefaults`

An `InheritedComponent` that any `SeoMetaTags` below it reads through `SeoDefaults.of(context)`. A value set on `SeoMetaTags` wins over the default.

| Field | Default | Used for |
|---|---|---|
| `child` | required | the subtree |
| `favicon`, `faviconSvg`, `manifest`, `color` | `null` | icon links, manifest, `theme-color`, Apple and Microsoft colors |
| `publisher`, `author` | `null` | meta tags, `article:author`, and the WebSite and BlogPosting schemas |
| `locale` | `null` | `og:locale` and schema `inLanguage` |
| `iconUrl` | `null` | `apple-touch-icon` and the Microsoft tile image |
| `imageUrl`, `imageAlt` | `null` | `og:image`, `twitter:image`, `image_src`, schema `image` |
| `imageWidth`, `imageHeight` | `'1200'`, `'630'` | `og:image:width` and `og:image:height` |
| `siteName` | `null` | `og:site_name` and the WebSite schema `name` |
| `siteUrl` | `null` | the WebSite schema `url` |
| `robots` | `'index,follow'` | `<meta name="robots">` |
| `twitter`, `pinterest`, `apple`, `microsoft` | `null` | per-platform defaults (Microsoft: `tileColor` and `tileImageUrl` only) |
| `schemaOrganization`, `schemaPerson` | `null` | added to every page's JSON-LD group |

Per-page fields are not inherited: `title`, `description`, `keywords`, `url`, `canonical`, `type`, `video`, `imageSrc`, `openGraph`, `openGraphArticle`, `alternateLanguageUrls`, `breadcrumbItems`, `schemaWebSite`, `schemaBlog`, `schemaBlogPosting`.

`updateShouldNotify` compares only `favicon`, `siteName`, `siteUrl`, `publisher`, `imageUrl`, `color`, and `robots`.

## `SeoMetaTags`

Every field is optional. One render emits, inside `Document.head`:

| Output | Source |
|---|---|
| `DefaultMeta` | `title`, `description`, `keywords`, `author`, `robots`, `publisher`, `favicon`, `faviconSvg`, `canonical ?? url`, `color` as `theme-color`, `manifest`, `imageSrc ?? imageUrl` |
| `DefaultOpenGraphMeta` | each `openGraph` field, else the page field (`title`, `type`, `url`, `imageUrl`, `description`, `locale`, `imageAlt`, `video`, sizes); `og:site_name` comes from `SeoDefaults.siteName` |
| `ArticleOpenGraphMeta` | only for `OgType.article`; `openGraphArticle` fields, `author` falls back to the resolved author |
| `TwitterMeta` | `site` and `creator`: `twitter`, then `SeoDefaults.twitter`. `card`: `twitter`, then `SeoDefaults.twitter`, then `summary_large_image` when there is an image. `title` and `description`: `twitter`, then the page `title` and `description`. `image` and `imageAlt`: `twitter`, then the resolved `imageUrl` and `imageAlt` (page value, then `SeoDefaults.imageUrl` and `SeoDefaults.imageAlt`) |
| `PinterestMeta`, `AppleMeta`, `MicrosoftMeta` | the per-platform field, then the `SeoDefaults` one, then `author`, `title`, `iconUrl`, `color` |
| `AlternateLanguageMeta` | `alternateLanguageUrls`, when not empty |
| `SchemaGroup(id: 'schema-group')` | `schemaBlog`, a WebSite schema (always), a BlogPosting schema (article only), `schemaPerson`, `schemaOrganization` (page value or default), and a `BreadcrumbListSchema` when `breadcrumbItems` is not empty |

An article page:

```dart
SeoMetaTags articleTags(PageSeoContext seo) => SeoMetaTags(
  title: 'Shipping islands',
  description: 'How we hydrate only what moves.',
  url: seo.url,
  canonical: seo.canonical,
  type: OgType.article,
  alternateLanguageUrls: seo.alternateLanguageUrls,
  breadcrumbItems: seo.breadcrumbItems,
  openGraphArticle: ArticleOpenGraphMeta(
    section: 'Engineering',
    tags: const ['jaspr'],
    publishedTime: DateTime.utc(2026, 11, 1),
  ),
  schemaBlogPosting: BlogPostingSchema(
    datePublished: DateTime.utc(2026, 11, 1),
    articleSection: 'Engineering',
    wordCount: 1200,
  ),
);
```

## Gotchas

- The WebSite schema is rebuilt from `schemaWebSite` using only `name`, `description`, `url`, `inLanguage`, `datePublished`, `dateModified`, `author`, `publisher`, `keywords`, `image`, `mainEntity`, and `additionalProperties`. A `WebSchemaHelper.createWebSite(searchUrlTemplate: ...)` passed here loses its `potentialAction` and `sameAs`. Put them in `additionalProperties` (for example `{'potentialAction': WebSiteSchema.createSearchAction(searchUrlTemplate: ...)}`), or render a full schema yourself in `Document.head` without the `schema-group` id.
- The BlogPosting schema is rebuilt from `schemaBlogPosting` using only `headline`, `description`, `url`, `datePublished`, `dateModified`, `author`, `publisher`, `image`, `keywords`, `articleSection`, `wordCount`, `timeRequired`, `inLanguage`, `articleBody`, and `additionalProperties`. `headline` falls back to `title`, `url` to `url`.
- WebSite schema fallbacks: `name` is `schemaWebSite.name`, then `siteName`, then the page `title`; `url` is `schemaWebSite.url`, then `siteUrl`, then the page `url`. Set `siteUrl` on `SeoDefaults` so every page reports the same site URL.
- Without `SeoDefaults.siteName`, `og:site_name` falls back to the page title.
- `msvalidate.01` always carries `verification_token`: `SeoMetaTags` builds `MicrosoftMeta` without `msValidate`, and a `MicrosoftMeta` rendered beside `PageHead` does not replace it (the deeper head wins). Verify the site with Bing another way.
- `SeoDefaults.twitter` supplies only `site`, `card`, and `creator`. Its `title`, `description`, `image`, and `imageAlt` are never read, so `SeoDefaults(twitter: TwitterMeta(image: x))` never emits `x`; set a site-wide image with `SeoDefaults.imageUrl`, or per page with `SeoMetaTags.twitter`.
- `twitter:card` is emitted with no `content` when there is no image and no card is set.
- `og:image:width` and `og:image:height` are always emitted, even without an image.
- To stop indexing one page, pass `robots: 'noindex'`; the default is `index,follow`.
- `title` is written into `<title>` as raw HTML. Strip `<` from untrusted titles.
