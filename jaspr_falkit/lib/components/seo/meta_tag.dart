import 'package:jaspr_falkit/lib.dart';

class SeoMetaTagBuilder {
  SeoMetaTagBuilder();

  String? favicon;
  String? faviconSvg;
  String? publisher;
  String? title;
  String? description;
  List<String>? keywords;
  String? author;
  String? robots;
  String? url;
  String? imageUrl;
  String? canonical;
  OgType type = OgType.website;
  String? locale;
  String imageWidth = '1200';
  String imageHeight = '630';
  String? imageAlt;
  String? video;
  String? iconUrl;
  String? color;
  String? manifest;
  String? imageSrc;
  DefaultOpenGraphMeta? openGraph;
  ArticleOpenGraphMeta? openGraphArticle;
  TwitterMeta? twitter;
  PinterestMeta? pinterest;
  AppleMeta? apple;
  MicrosoftMeta? microsoft;
  List<AlternateLanguageTag>? alternateLanguageUrls;
  WebSiteSchemaData? schemaWebSite;
  BlogSchema? schemaBlog;
  BlogPostingSchema? schemaBlogPosting;
  PersonSchema? schemaPerson;
  OrganizationSchema? schemaOrganization;
  List<BreadcrumbItem>? breadcrumbItems;
  SeoMetaTagBuilder? builder;

  SeoMetaTags build() {
    return SeoMetaTags(
      favicon: builder?.favicon ?? favicon,
      faviconSvg: builder?.faviconSvg ?? faviconSvg,
      publisher: builder?.publisher ?? publisher,
      title: builder?.title ?? title,
      description: builder?.description ?? description,
      keywords: builder?.keywords ?? keywords,
      author: builder?.author ?? author,
      robots: builder?.robots ?? robots,
      url: builder?.url ?? url,
      imageUrl: builder?.imageUrl ?? imageUrl,
      canonical: builder?.canonical ?? canonical,
      type: builder?.type ?? type,
      locale: builder?.locale ?? locale,
      imageWidth: builder?.imageWidth ?? imageWidth,
      imageHeight: builder?.imageHeight ?? imageHeight,
      imageAlt: builder?.imageAlt ?? imageAlt,
      video: builder?.video ?? video,
      iconUrl: builder?.iconUrl ?? iconUrl,
      color: builder?.color ?? color,
      manifest: builder?.manifest ?? manifest,
      imageSrc: builder?.imageSrc ?? imageSrc,
      openGraph: builder?.openGraph ?? openGraph,
      openGraphArticle: builder?.openGraphArticle ?? openGraphArticle,
      twitter: builder?.twitter ?? twitter,
      pinterest: builder?.pinterest ?? pinterest,
      apple: builder?.apple ?? apple,
      microsoft: builder?.microsoft ?? microsoft,
      alternateLanguageUrls:
          builder?.alternateLanguageUrls ?? alternateLanguageUrls,
      // Schema Org
      schemaWebSite: builder?.schemaWebSite ?? schemaWebSite,
      schemaBlog: builder?.schemaBlog ?? schemaBlog,
      schemaBlogPosting: builder?.schemaBlogPosting ?? schemaBlogPosting,
      schemaPerson: builder?.schemaPerson ?? schemaPerson,
      schemaOrganization: builder?.schemaOrganization ?? schemaOrganization,
      breadcrumbItems: builder?.breadcrumbItems ?? breadcrumbItems,
    );
  }
}

class SeoMetaTags extends Fragment {
  SeoMetaTags({
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
  }) : super(
         children: [
           DefaultMeta(
             title: title,
             description: description,
             keywords: keywords,
             author: author,
             robots: robots,
             publisher: publisher,
             favicon: favicon,
             faviconSvg: faviconSvg,
             canonical: canonical ?? url,
             themeColor: color,
             manifest: manifest,
             imageSrc: imageSrc ?? imageUrl,
           ),
           DefaultOpenGraphMeta(
             title: openGraph?.title ?? title,
             type: openGraph?.type ?? type,
             url: openGraph?.url ?? url,
             imageUrl: openGraph?.imageUrl ?? imageUrl,
             description: openGraph?.description ?? description,
             siteName: openGraph?.siteName ?? title,
             locale: openGraph?.locale ?? locale,
             imageAlt: openGraph?.imageAlt ?? imageAlt,
             video: openGraph?.video ?? video,
             imageHeight: openGraph?.imageHeight ?? imageHeight,
             imageWidth: openGraph?.imageWidth ?? imageWidth,
           ),
           if (type == OgType.article || openGraph?.type == OgType.article)
             ArticleOpenGraphMeta(
               author: openGraphArticle?.author ?? author,
               section: openGraphArticle?.section,
               tags: openGraphArticle?.tags,
               publishedTime: openGraphArticle?.publishedTime,
               modifiedTime: openGraphArticle?.modifiedTime,
             ),
           TwitterMeta(
             site: twitter?.site,
             card: twitter?.card,
             creator: twitter?.creator,
             title: twitter?.title ?? title,
             description: twitter?.description ?? description,
             image: twitter?.image ?? imageUrl,
             imageAlt: twitter?.imageAlt ?? imageAlt,
           ),
           PinterestMeta(
             pinterestRichPin: pinterest?.pinterestRichPin,
             author: pinterest?.author ?? author,
           ),
           AppleMeta(
             title: apple?.title ?? title,
             iconUrl: apple?.iconUrl ?? iconUrl,
             color: apple?.color ?? color,
             capable: apple?.capable,
             fullscreen: apple?.fullscreen,
           ),
           MicrosoftMeta(
             tileColor: microsoft?.tileColor ?? color,
             tileImageUrl: microsoft?.tileImageUrl ?? iconUrl,
           ),
           if (alternateLanguageUrls != null &&
               (alternateLanguageUrls?.isNotEmpty ?? false))
             AlternateLanguageMeta(alternateLanguageUrls!),
           SchemaGroup(
             id: 'schema-group',
             schemas: [
               if (schemaBlog != null) schemaBlog!,
               if (type == OgType.article ||
                   openGraph?.type == OgType.article) ...[
                 BlogPostingSchema(
                   headline: schemaBlogPosting?.headline ?? title,
                   description: schemaBlogPosting?.description ?? description,
                   url: schemaBlogPosting?.url ?? url,
                   datePublished: schemaBlogPosting?.datePublished,
                   dateModified: schemaBlogPosting?.dateModified,
                   author:
                       schemaBlogPosting?.author ?? author?.toSchemaDataType(),
                   publisher:
                       schemaBlogPosting?.publisher ??
                       publisher?.toSchemaDataType(),
                   image:
                       schemaBlogPosting?.image ?? imageUrl?.toSchemaDataType(),
                   keywords: schemaBlogPosting?.keywords ?? keywords,
                   articleSection: schemaBlogPosting?.articleSection,
                   wordCount: schemaBlogPosting?.wordCount,
                   timeRequired: schemaBlogPosting?.timeRequired,
                   inLanguage: schemaBlogPosting?.inLanguage ?? locale,
                   articleBody: schemaBlogPosting?.articleBody,
                   additionalProperties:
                       schemaBlogPosting?.additionalProperties,
                 ),
               ],
               if (type == OgType.website || openGraph?.type == OgType.website)
                 WebSiteSchema(
                   name: schemaWebSite?.name ?? title,
                   description: schemaWebSite?.description ?? description,
                   url: schemaWebSite?.url ?? url,
                   inLanguage: schemaWebSite?.inLanguage ?? locale,
                   datePublished: schemaWebSite?.datePublished,
                   dateModified: schemaWebSite?.dateModified,
                   author: schemaWebSite?.author ?? author?.toSchemaDataType(),
                   publisher:
                       schemaWebSite?.publisher ??
                       publisher?.toSchemaDataType(),
                   keywords: schemaWebSite?.keywords ?? keywords,
                   image: schemaWebSite?.image ?? imageUrl?.toSchemaDataType(),
                   mainEntity: schemaWebSite?.mainEntity,
                   additionalProperties: schemaWebSite?.additionalProperties,
                 ),
               if (schemaPerson != null) schemaPerson!,
               if (schemaOrganization != null) schemaOrganization!,
               if (breadcrumbItems != null &&
                   (breadcrumbItems?.isNotEmpty ?? false))
                 BreadcrumbListSchema(items: breadcrumbItems!),
             ],
           ),
         ],
       );

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
}

class Meta extends StatelessComponent {
  const Meta({
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
  Iterable<Component> build(BuildContext context) => [
    meta(
      id: unique ? 'meta_$id$name$property'.hashStr(length: 5) : id,
      name: name,
      content: content,
      attributes: {
        if (property.isNotNullOrBlank) 'property': property!,
      },
    ),
  ];
}

class LinkHeader extends StatelessComponent {
  const LinkHeader({
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
  Iterable<Component> build(BuildContext context) => [
    link(
      href: href,
      id: unique ? 'link_$id$rel$type$as$attributes'.hashStr(length: 5) : id,
      rel: rel,
      type: type,
      as: as,
      attributes: attributes,
      events: events,
    ),
  ];
}
