import 'package:jaspr_falkit/lib.dart';

/// Site-wide SEO defaults provided via [InheritedComponent].
///
/// Place near the root of the app. Any [SeoMetaTags] descendant will fall
/// back to these values for fields it does not specify itself.
///
/// Inheritable fields are limited to those that make sense as a site-wide
/// default. Per-page concerns (title, description, url, canonical, type,
/// schemaBlogPosting, breadcrumbItems, alternateLanguageUrls, keywords)
/// are intentionally NOT inheritable and must be set on each [SeoMetaTags].
class SeoDefaults extends InheritedComponent {
  const new({
    required super.child,
    this.favicon,
    this.faviconSvg,
    this.publisher,
    this.author,
    this.locale,
    this.manifest,
    this.iconUrl,
    this.color,
    this.imageUrl,
    this.imageAlt,
    this.imageWidth = '1200',
    this.imageHeight = '630',
    this.siteName,
    this.siteUrl,
    this.robots = 'index,follow',
    this.twitter,
    this.pinterest,
    this.apple,
    this.microsoft,
    this.schemaOrganization,
    this.schemaPerson,
    super.key,
  });

  final String? favicon;
  final String? faviconSvg;
  final String? publisher;
  final String? author;
  final String? locale;
  final String? manifest;
  final String? iconUrl;
  final String? color;
  final String? imageUrl;
  final String? imageAlt;
  final String imageWidth;
  final String imageHeight;

  /// Brand / website name (e.g. "FalconX"). Used as `og:site_name`.
  final String? siteName;

  /// Root URL of the site, used as fallback for [WebSiteSchema.url].
  final String? siteUrl;

  /// Default robots directive. Defaults to `index,follow`.
  final String robots;

  final TwitterMeta? twitter;
  final PinterestMeta? pinterest;
  final AppleMeta? apple;
  final MicrosoftMeta? microsoft;
  final OrganizationSchema? schemaOrganization;
  final PersonSchema? schemaPerson;

  static SeoDefaults? of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<SeoDefaults>();
  }

  @override
  bool updateShouldNotify(SeoDefaults oldComponent) {
    // Defaults are typically static; only re-render if the brand identity
    // changes (rare). Cheap reference equality is enough here.
    return favicon != oldComponent.favicon ||
        siteName != oldComponent.siteName ||
        siteUrl != oldComponent.siteUrl ||
        publisher != oldComponent.publisher ||
        imageUrl != oldComponent.imageUrl ||
        color != oldComponent.color ||
        robots != oldComponent.robots;
  }
}

class SeoMetaTags extends StatelessComponent {
  const new({
    //**** Default SEO *****//
    this.favicon,
    this.faviconSvg,
    this.publisher,
    this.title,
    this.description,
    this.keywords,
    this.author,
    this.robots,
    this.url,
    this.imageUrl,
    this.canonical,
    required this.type,
    this.locale,
    required this.imageWidth,
    required this.imageHeight,
    this.imageAlt,
    this.video,
    this.iconUrl,
    this.color,
    this.manifest,
    this.openGraph,
    this.openGraphArticle,
    this.imageSrc,
    this.twitter,
    this.pinterest,
    this.apple,
    this.microsoft,
    this.schemaWebSite,
    this.schemaBlog,
    this.schemaBlogPosting,
    this.schemaPerson,
    this.schemaOrganization,
    this.alternateLanguageUrls,
    this.breadcrumbItems,
  });

  final String? favicon;
  final String? faviconSvg;
  final String? publisher;
  final String? title;
  final String? description;
  final List<String>? keywords;
  final String? author;
  final String? robots;
  final String? url;
  final String? imageUrl;
  final String? canonical;
  final OgType type;
  final String? locale;
  final String imageWidth;
  final String imageHeight;
  final String? imageAlt;
  final String? video;
  final String? iconUrl;
  final String? color;
  final String? manifest;
  final String? imageSrc;
  final DefaultOpenGraphMeta? openGraph;
  final ArticleOpenGraphMeta? openGraphArticle;
  final TwitterMeta? twitter;
  final PinterestMeta? pinterest;
  final AppleMeta? apple;
  final MicrosoftMeta? microsoft;
  final List<AlternateLanguageTag>? alternateLanguageUrls;
  final List<BreadcrumbItem>? breadcrumbItems;
  final WebSiteSchemaData? schemaWebSite;
  final BlogSchema? schemaBlog;
  final BlogPostingSchema? schemaBlogPosting;
  final PersonSchema? schemaPerson;
  final OrganizationSchema? schemaOrganization;

  @override
  Component build(BuildContext context) {
    final defaults = SeoDefaults.of(context);

    // Resolve every inheritable field once: per-page value wins, then
    // site-wide default, then null. This keeps the JSX-style tree below
    // readable and avoids the old `builder?.x ?? x` repetition.
    final resolvedFavicon = favicon ?? defaults?.favicon;
    final resolvedFaviconSvg = faviconSvg ?? defaults?.faviconSvg;
    final resolvedPublisher = publisher ?? defaults?.publisher;
    final resolvedAuthor = author ?? defaults?.author;
    final resolvedLocale = locale ?? defaults?.locale;
    final resolvedManifest = manifest ?? defaults?.manifest;
    final resolvedIconUrl = iconUrl ?? defaults?.iconUrl;
    final resolvedColor = color ?? defaults?.color;
    final resolvedImageUrl = imageUrl ?? defaults?.imageUrl;
    final resolvedImageAlt = imageAlt ?? defaults?.imageAlt;
    final resolvedImageWidth =
        imageWidth.isNotEmpty ? imageWidth : (defaults?.imageWidth ?? '1200');
    final resolvedImageHeight =
        imageHeight.isNotEmpty ? imageHeight : (defaults?.imageHeight ?? '630');
    final resolvedRobots = robots ?? defaults?.robots ?? 'index,follow';
    final resolvedSiteName = defaults?.siteName;
    final resolvedSiteUrl = defaults?.siteUrl;

    final defaultTwitter = defaults?.twitter;
    final defaultPinterest = defaults?.pinterest;
    final defaultApple = defaults?.apple;
    final defaultMicrosoft = defaults?.microsoft;

    final isArticle =
        type == OgType.article || openGraph?.type == OgType.article;

    // Default Twitter card to summary_large_image when an image is present
    // — otherwise Twitter falls back to a tiny preview even though we ship
    // a 1200x630 image.
    final twitterImage = twitter?.image ?? resolvedImageUrl;
    final resolvedTwitterCard = twitter?.card ??
        defaultTwitter?.card ??
        (twitterImage != null ? 'summary_large_image' : null);

    return Document.head(
      children: [
        DefaultMeta(
          title: title,
          description: description,
          keywords: keywords,
          author: resolvedAuthor,
          robots: resolvedRobots,
          publisher: resolvedPublisher,
          favicon: resolvedFavicon,
          faviconSvg: resolvedFaviconSvg,
          canonical: canonical ?? url,
          themeColor: resolvedColor,
          manifest: resolvedManifest,
          imageSrc: imageSrc ?? resolvedImageUrl,
        ),
        DefaultOpenGraphMeta(
          title: openGraph?.title ?? title,
          type: openGraph?.type ?? type,
          url: openGraph?.url ?? url,
          imageUrl: openGraph?.imageUrl ?? resolvedImageUrl,
          description: openGraph?.description ?? description,
          // og:site_name should be the brand, NOT the page title.
          siteName: openGraph?.siteName ?? resolvedSiteName,
          locale: openGraph?.locale ?? resolvedLocale,
          imageAlt: openGraph?.imageAlt ?? resolvedImageAlt,
          video: openGraph?.video ?? video,
          imageHeight: openGraph?.imageHeight ?? resolvedImageHeight,
          imageWidth: openGraph?.imageWidth ?? resolvedImageWidth,
        ),
        if (isArticle)
          ArticleOpenGraphMeta(
            author: openGraphArticle?.author ?? resolvedAuthor,
            section: openGraphArticle?.section,
            tags: openGraphArticle?.tags,
            publishedTime: openGraphArticle?.publishedTime,
            modifiedTime: openGraphArticle?.modifiedTime,
          ),
        TwitterMeta(
          site: twitter?.site ?? defaultTwitter?.site,
          card: resolvedTwitterCard,
          creator: twitter?.creator ?? defaultTwitter?.creator,
          title: twitter?.title ?? title,
          description: twitter?.description ?? description,
          image: twitterImage,
          imageAlt: twitter?.imageAlt ?? resolvedImageAlt,
        ),
        PinterestMeta(
          pinterestRichPin:
              pinterest?.pinterestRichPin ?? defaultPinterest?.pinterestRichPin,
          author: pinterest?.author ??
              defaultPinterest?.author ??
              resolvedAuthor,
        ),
        AppleMeta(
          title: apple?.title ?? defaultApple?.title ?? title,
          iconUrl: apple?.iconUrl ?? defaultApple?.iconUrl ?? resolvedIconUrl,
          color: apple?.color ?? defaultApple?.color ?? resolvedColor,
          capable: apple?.capable ?? defaultApple?.capable,
          fullscreen: apple?.fullscreen ?? defaultApple?.fullscreen,
        ),
        MicrosoftMeta(
          tileColor: microsoft?.tileColor ??
              defaultMicrosoft?.tileColor ??
              resolvedColor,
          tileImageUrl: microsoft?.tileImageUrl ??
              defaultMicrosoft?.tileImageUrl ??
              resolvedIconUrl,
        ),
        if (alternateLanguageUrls?.isNotEmpty ?? false)
          AlternateLanguageMeta(alternateLanguageUrls!),
        SchemaGroup(
          id: 'schema-group',
          schemas: [
            ?schemaBlog,
            // WebSite schema is rendered on EVERY page (Google recommends this
            // for sitelinks searchbox + brand entity). BlogPosting is added
            // additionally on article pages — they are NOT mutually exclusive.
            WebSiteSchema(
              name: schemaWebSite?.name ?? resolvedSiteName ?? title,
              description: schemaWebSite?.description ?? description,
              url: schemaWebSite?.url ?? resolvedSiteUrl ?? url,
              inLanguage: schemaWebSite?.inLanguage ?? resolvedLocale,
              datePublished: schemaWebSite?.datePublished,
              dateModified: schemaWebSite?.dateModified,
              author:
                  schemaWebSite?.author ?? resolvedAuthor?.toSchemaDataType(),
              publisher: schemaWebSite?.publisher ??
                  resolvedPublisher?.toSchemaDataType(),
              keywords: schemaWebSite?.keywords ?? keywords,
              image:
                  schemaWebSite?.image ?? resolvedImageUrl?.toSchemaDataType(),
              mainEntity: schemaWebSite?.mainEntity,
              additionalProperties: schemaWebSite?.additionalProperties,
            ),
            if (isArticle)
              BlogPostingSchema(
                headline: schemaBlogPosting?.headline ?? title,
                description: schemaBlogPosting?.description ?? description,
                url: schemaBlogPosting?.url ?? url,
                datePublished: schemaBlogPosting?.datePublished,
                dateModified: schemaBlogPosting?.dateModified,
                author: schemaBlogPosting?.author ??
                    resolvedAuthor?.toSchemaDataType(),
                publisher: schemaBlogPosting?.publisher ??
                    resolvedPublisher?.toSchemaDataType(),
                image: schemaBlogPosting?.image ??
                    resolvedImageUrl?.toSchemaDataType(),
                keywords: schemaBlogPosting?.keywords ?? keywords,
                articleSection: schemaBlogPosting?.articleSection,
                wordCount: schemaBlogPosting?.wordCount,
                timeRequired: schemaBlogPosting?.timeRequired,
                inLanguage: schemaBlogPosting?.inLanguage ?? resolvedLocale,
                articleBody: schemaBlogPosting?.articleBody,
                additionalProperties: schemaBlogPosting?.additionalProperties,
              ),
            ?schemaPerson ?? defaults?.schemaPerson,
            ?schemaOrganization ?? defaults?.schemaOrganization,
            if (breadcrumbItems?.isNotEmpty ?? false)
              BreadcrumbListSchema(items: breadcrumbItems!),
          ],
        ),
      ],
    );
  }
}

class Meta extends StatelessComponent {
  const new({
    this.id,
    this.name,
    this.property,
    this.content,
    this.unique = false,
  });

  final String? id;
  final String? name;
  final String? property;
  final String? content;
  final bool unique;

  @override
  Component build(BuildContext context) => meta(
    id: unique ? 'meta_$id$name$property'.hashSha256(length: 5) : id,
    name: name,
    content: content,
    attributes: {
      if (property.isNotNullOrBlank) 'property': property!,
    },
  );
}

class LinkHeader extends StatelessComponent {
  const new({
    required this.href,
    this.id,
    this.rel,
    this.type,
    this.as,
    this.attributes,
    this.events,
    this.unique = true,
  });

  final String href;
  final String? id;
  final String? rel;
  final String? type;
  final String? as;
  final Map<String, String>? attributes;
  final Map<String, EventCallback>? events;
  final bool unique;

  @override
  Component build(BuildContext context) => link(
    href: href,
    id: unique ? 'link_$id$rel$type$as$attributes'.hashSha256(length: 5) : id,
    rel: rel,
    type: type,
    as: as,
    attributes: attributes,
    events: events,
  );
}
