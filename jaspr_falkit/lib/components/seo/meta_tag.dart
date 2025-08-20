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
    this.schemaWebPage,
    this.schemaArticle,
    this.schemaBlog,
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
  final String type;
  final String? locale;
  final String imageWidth;
  final String imageHeight;
  final String? imageAlt;
  final String? video;
  final String? iconUrl;
  final String? color;
  final String? manifest;
  final String? imageSrc;
  final DefaultOpenGraphTag? openGraph;
  final ArticleOpenGraphTag? openGraphArticle;
  final TwitterTag? twitter;
  final PinterestTag? pinterest;
  final AppleTag? apple;
  final MicrosoftTag? microsoft;
  final WebPageSchema? schemaWebPage;
  final ArticleSchema? schemaArticle;
  final BlogSchema? schemaBlog;
  final List<AlternateLanguageTag>? alternateLanguageUrls;
  final List<BreadcrumbSchemaItem>? breadcrumbItems;
}

class SeoMetaTagBuilder {
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
  String type = 'website';
  String? locale;
  String imageWidth = '1200';
  String imageHeight = '630';
  String? imageAlt;
  String? video;
  String? iconUrl;
  String? color;
  String? manifest;
  String? imageSrc;
  DefaultOpenGraphTag? openGraph;
  ArticleOpenGraphTag? openGraphArticle;
  TwitterTag? twitter;
  PinterestTag? pinterest;
  AppleTag? apple;
  MicrosoftTag? microsoft;
  WebPageSchema? schemaWebPage;
  ArticleSchema? schemaArticle;
  BlogSchema? schemaBlog;
  List<AlternateLanguageTag>? alternateLanguageUrls;
  List<BreadcrumbSchemaItem>? breadcrumbItems;
  SeoMetaTagBuilder? builder;

  SeoMetaTagBuilder();

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
      schemaWebPage: builder?.schemaWebPage ?? schemaWebPage,
      schemaArticle: builder?.schemaArticle ?? schemaArticle,
      schemaBlog: builder?.schemaBlog ?? schemaBlog,
      alternateLanguageUrls:
          builder?.alternateLanguageUrls ?? alternateLanguageUrls,
      breadcrumbItems: builder?.breadcrumbItems ?? breadcrumbItems,
    );
  }
}

class SeoMetaTags extends Fragment {
  SeoMetaTags(SeoMetaTag tag)
      : super(
          children: [
            DefaultMeta(DefaultTag(
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
            )),
            DefaultOpenGraphMeta(DefaultOpenGraphTag(
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
            )),
            if (tag.type == 'article' || tag.openGraph?.type == 'article')
              ArticleOpenGraphMeta(ArticleOpenGraphTag(
                author: tag.openGraphArticle?.author ?? tag.author,
                section: tag.openGraphArticle?.section,
                tags: tag.openGraphArticle?.tags,
                publishedTime: tag.openGraphArticle?.publishedTime,
                modifiedTime: tag.openGraphArticle?.modifiedTime,
              )),
            TwitterMeta(TwitterTag(
              site: tag.twitter?.site,
              card: tag.twitter?.card,
              creator: tag.twitter?.creator,
              title: tag.twitter?.title ?? tag.title,
              description: tag.twitter?.description ?? tag.description,
              image: tag.twitter?.image ?? tag.imageUrl,
              imageAlt: tag.twitter?.imageAlt ?? tag.imageAlt,
            )),
            PinterestMeta(PinterestTag(
              pinterestRichPin: tag.pinterest?.pinterestRichPin,
              author: tag.pinterest?.author ?? tag.author,
            )),
            AppleMeta(AppleTag(
              title: tag.apple?.title ?? tag.title,
              iconUrl: tag.apple?.iconUrl ?? tag.iconUrl,
              color: tag.apple?.color ?? tag.color,
              capable: tag.apple?.capable,
              fullscreen: tag.apple?.fullscreen,
            )),
            MicrosoftMeta(MicrosoftTag(
              tileColor: tag.microsoft?.tileColor ?? tag.color,
              tileImageUrl: tag.microsoft?.tileImageUrl ?? tag.iconUrl,
            )),
            if (tag.schemaBlog != null)
              SeoBlogSchema(BlogSchema(
                name: tag.schemaBlog?.name ?? tag.title,
                description: tag.schemaBlog?.description ?? tag.description,
                url: tag.schemaBlog?.url ?? tag.url,
                publisher: tag.schemaBlog?.publisher ?? tag.publisher,
                inLanguage: tag.schemaBlog?.inLanguage ?? tag.locale,
                blogPost: tag.schemaBlog?.blogPost,
                author: tag.schemaBlog?.author ?? tag.author,
                dateCreated: tag.schemaBlog?.dateCreated,
                dateModified: tag.schemaBlog?.dateModified,
                keywords: tag.schemaBlog?.keywords ?? tag.keywords,
                imageUrl: tag.schemaBlog?.imageUrl ?? tag.imageUrl,
                additionalProperties: tag.schemaBlog?.additionalProperties,
                authorType: tag.schemaBlog?.authorType,
                publisherType: tag.schemaBlog?.publisherType,
                publisherLogo: tag.schemaBlog?.publisherLogo ?? tag.iconUrl,
              ))
            else if (tag.type == 'article' || tag.openGraph?.type == 'article')
              SeoArticleSchemaOrg(ArticleSchema(
                headline: tag.schemaArticle?.headline ?? tag.title,
                articleSection: tag.schemaArticle?.articleSection,
                description: tag.schemaArticle?.description ?? tag.description,
                datePublished: tag.schemaArticle?.datePublished,
                dateModified: tag.schemaArticle?.dateModified,
                author: tag.schemaArticle?.author ?? tag.author,
                publisher: tag.schemaArticle?.publisher ?? tag.publisher,
                url: tag.schemaArticle?.url ?? tag.url,
                imageUrl: tag.schemaArticle?.imageUrl ?? tag.imageUrl,
                keywords: tag.schemaArticle?.keywords ?? tag.keywords,
                wordCount: tag.schemaArticle?.wordCount,
                timeRequired: tag.schemaArticle?.timeRequired,
                inLanguage: tag.schemaArticle?.inLanguage ?? tag.locale,
                additionalProperties: tag.schemaArticle?.additionalProperties,
                publisherType: tag.schemaArticle?.publisherType,
                publisherLogo: tag.schemaArticle?.publisherLogo ?? tag.iconUrl,
                authorType: tag.schemaArticle?.authorType,
              ))
            else if (tag.type == 'website' || tag.openGraph?.type == 'website')
              SeoWebPageSchema(WebPageSchema(
                name: tag.schemaWebPage?.name ?? tag.title,
                description: tag.schemaWebPage?.description ?? tag.description,
                url: tag.schemaWebPage?.url ?? tag.url,
                inLanguage: tag.schemaWebPage?.inLanguage ?? tag.locale,
                datePublished: tag.schemaWebPage?.datePublished,
                dateModified: tag.schemaWebPage?.dateModified,
                author: tag.schemaWebPage?.author ?? tag.author,
                publisher: tag.schemaWebPage?.publisher ?? tag.publisher,
                keywords: tag.schemaWebPage?.keywords ?? tag.keywords,
                imageUrl: tag.schemaWebPage?.imageUrl ?? tag.imageUrl,
                breadcrumb: tag.schemaWebPage?.breadcrumb,
                mainEntity: tag.schemaWebPage?.mainEntity,
                additionalProperties: tag.schemaWebPage?.additionalProperties,
                publisherType: tag.schemaWebPage?.publisherType,
                publisherLogo: tag.schemaWebPage?.publisherLogo ?? tag.iconUrl,
                authorType: tag.schemaWebPage?.authorType,
              )),
            if (tag.alternateLanguageUrls != null &&
                (tag.alternateLanguageUrls?.isNotEmpty ?? false))
              AlternateLanguageMeta(tag.alternateLanguageUrls!),
            if (tag.breadcrumbItems != null &&
                (tag.breadcrumbItems?.isNotEmpty ?? false))
              SeoBreadcrumbListSchema(tag.breadcrumbItems!),
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
    super.children,
  }) : super(
          attributes: {
            //elements with an id override other elements with the same id
            if (id.isNotNullOrBlank) 'id': id!,
            if (name.isNotNullOrBlank) 'name': name!,
            if (property.isNotNullOrBlank) 'property': property!,
            if (content.isNotNullOrBlank) 'content': content!,
          },
        );
}
