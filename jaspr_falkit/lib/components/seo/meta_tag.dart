import 'package:jaspr_falkit/lib.dart';

class SeoMetaTag {
  const SeoMetaTag._internal({
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

  factory SeoMetaTag.builder() => SeoMetaTagBuilder().build();

  //**** Default SEO *****//
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

  SeoMetaTag build() {
    return SeoMetaTag._internal(
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
  SeoMetaTags(SeoMetaTag tag)
    : super(
        children: [
          DefaultMeta(
            title: tag.title,
            description: tag.description,
            keywords: tag.keywords,
            author: tag.author,
            robots: tag.robots,
            publisher: tag.publisher,
            favicon: tag.favicon,
            faviconSvg: tag.faviconSvg,
            canonical: tag.canonical ?? tag.url,
            themeColor: tag.color,
            manifest: tag.manifest,
            imageSrc: tag.imageSrc ?? tag.imageUrl,
          ),
          DefaultOpenGraphMeta(
            title: tag.openGraph?.title ?? tag.title,
            type: tag.openGraph?.type ?? tag.type,
            url: tag.openGraph?.url ?? tag.url,
            imageUrl: tag.openGraph?.imageUrl ?? tag.imageUrl,
            description: tag.openGraph?.description ?? tag.description,
            siteName: tag.openGraph?.siteName ?? tag.title,
            locale: tag.openGraph?.locale ?? tag.locale,
            imageAlt: tag.openGraph?.imageAlt ?? tag.imageAlt,
            video: tag.openGraph?.video ?? tag.video,
            imageHeight: tag.openGraph?.imageHeight ?? tag.imageHeight,
            imageWidth: tag.openGraph?.imageWidth ?? tag.imageWidth,
          ),
          if (tag.type == OgType.article ||
              tag.openGraph?.type == OgType.article)
            ArticleOpenGraphMeta(
              author: tag.openGraphArticle?.author ?? tag.author,
              section: tag.openGraphArticle?.section,
              tags: tag.openGraphArticle?.tags,
              publishedTime: tag.openGraphArticle?.publishedTime,
              modifiedTime: tag.openGraphArticle?.modifiedTime,
            ),
          TwitterMeta(
            site: tag.twitter?.site,
            card: tag.twitter?.card,
            creator: tag.twitter?.creator,
            title: tag.twitter?.title ?? tag.title,
            description: tag.twitter?.description ?? tag.description,
            image: tag.twitter?.image ?? tag.imageUrl,
            imageAlt: tag.twitter?.imageAlt ?? tag.imageAlt,
          ),
          PinterestMeta(
            pinterestRichPin: tag.pinterest?.pinterestRichPin,
            author: tag.pinterest?.author ?? tag.author,
          ),
          AppleMeta(
            title: tag.apple?.title ?? tag.title,
            iconUrl: tag.apple?.iconUrl ?? tag.iconUrl,
            color: tag.apple?.color ?? tag.color,
            capable: tag.apple?.capable,
            fullscreen: tag.apple?.fullscreen,
          ),
          MicrosoftMeta(
            tileColor: tag.microsoft?.tileColor ?? tag.color,
            tileImageUrl: tag.microsoft?.tileImageUrl ?? tag.iconUrl,
          ),
          if (tag.alternateLanguageUrls != null &&
              (tag.alternateLanguageUrls?.isNotEmpty ?? false))
            AlternateLanguageMeta(tag.alternateLanguageUrls!),
          SchemaGroup(
            id: 'schema-group',
            schemas: [
              if (tag.schemaBlog != null) tag.schemaBlog!,
              if (tag.type == OgType.article ||
                  tag.openGraph?.type == OgType.article) ...[
                BlogPostingSchema(
                  headline: tag.schemaBlogPosting?.headline ?? tag.title,
                  description:
                      tag.schemaBlogPosting?.description ?? tag.description,
                  url: tag.schemaBlogPosting?.url ?? tag.url,
                  datePublished: tag.schemaBlogPosting?.datePublished,
                  dateModified: tag.schemaBlogPosting?.dateModified,
                  author:
                      tag.schemaBlogPosting?.author ??
                      tag.author?.toSchemaDataType(),
                  publisher:
                      tag.schemaBlogPosting?.publisher ??
                      tag.publisher?.toSchemaDataType(),
                  image:
                      tag.schemaBlogPosting?.image ??
                      tag.imageUrl?.toSchemaDataType(),
                  keywords: tag.schemaBlogPosting?.keywords ?? tag.keywords,
                  articleSection: tag.schemaBlogPosting?.articleSection,
                  wordCount: tag.schemaBlogPosting?.wordCount,
                  timeRequired: tag.schemaBlogPosting?.timeRequired,
                  inLanguage: tag.schemaBlogPosting?.inLanguage ?? tag.locale,
                  articleBody: tag.schemaBlogPosting?.articleBody,
                  additionalProperties:
                      tag.schemaBlogPosting?.additionalProperties,
                ),
              ],
              if (tag.type == OgType.website ||
                  tag.openGraph?.type == OgType.website)
                WebSiteSchema(
                  name: tag.schemaWebSite?.name ?? tag.title,
                  description:
                      tag.schemaWebSite?.description ?? tag.description,
                  url: tag.schemaWebSite?.url ?? tag.url,
                  inLanguage: tag.schemaWebSite?.inLanguage ?? tag.locale,
                  datePublished: tag.schemaWebSite?.datePublished,
                  dateModified: tag.schemaWebSite?.dateModified,
                  author:
                      tag.schemaWebSite?.author ??
                      tag.author?.toSchemaDataType(),
                  publisher:
                      tag.schemaWebSite?.publisher ??
                      tag.publisher?.toSchemaDataType(),
                  keywords: tag.schemaWebSite?.keywords ?? tag.keywords,
                  image:
                      tag.schemaWebSite?.image ??
                      tag.imageUrl?.toSchemaDataType(),
                  mainEntity: tag.schemaWebSite?.mainEntity,
                  additionalProperties: tag.schemaWebSite?.additionalProperties,
                ),
              if (tag.schemaPerson != null) tag.schemaPerson!,
              if (tag.schemaOrganization != null) tag.schemaOrganization!,
              if (tag.breadcrumbItems != null &&
                  (tag.breadcrumbItems?.isNotEmpty ?? false))
                BreadcrumbListSchema(items: tag.breadcrumbItems!),
            ],
          ),
        ],
      );
}

class Meta extends DomComponent {
  Meta({
    super.tag = 'meta',
    String? id,
    String? name,
    String? property,
    String? content,
    bool unique = false,
    super.children,
  }) : super(
         attributes: {
           if (unique) 'id': 'meta_$name$property$id'.hashStr(length: 5),
           if (id.isNotNullOrBlank && unique == false) 'id': id!,
           if (name.isNotNullOrBlank) 'name': name!,
           if (property.isNotNullOrBlank) 'property': property!,
           if (content.isNotNullOrBlank) 'content': content!,
         },
       );
}

class LinkHeader extends DomComponent {
  LinkHeader({
    super.key,
    super.classes,
    super.styles,
    required String href,
    super.events,
    String? id,
    String? rel,
    String? type,
    String? as,
    Map<String, String>? attributes,
    bool unique = false,
  }) : super(
         tag: 'link',
         attributes: {
           ...?attributes,
           if (unique) 'id': 'link_$rel$type$as$href'.hashStr(length: 5),
           if (id.isNotNullOrBlank && unique == false) 'id': id!,
           'href': href,
           if (rel != null) 'rel': rel,
           if (type != null) 'type': type,
           if (as != null) 'as': as,
         },
       );
}
