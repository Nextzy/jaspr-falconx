import 'package:jaspr_falkit/lib.dart';

/// WebPage schema with all schema.org properties
class WebPageSchema extends Schema {
  /// Main constructor with all schema.org properties
  WebPageSchema({
    this.name,
    this.description,
    this.url,
    this.inLanguage,
    this.datePublished,
    this.dateModified,
    this.author,
    this.publisher,
    this.keywords,
    this.primaryImageOfPage,
    this.breadcrumb,
    this.mainEntity,
    this.mainContentOfPage,
    this.lastReviewed,
    this.reviewedBy,
    this.significantLink,
    this.speakable,
    this.specialty,
    this.relatedLink,
    this.about,
    this.accessMode,
    this.accessibilityFeature,
    this.accessibilityHazard,
    this.accessibilitySummary,
    this.accessibilityAPI,
    this.audience,
    this.contentRating,
    this.contentLocation,
    this.copyrightYear,
    this.copyrightHolder,
    this.license,
    this.isPartOf,
    this.hasPart,
    this.headline,
    this.alternativeHeadline,
    this.thumbnailUrl,
    this.video,
    this.audio,
    this.mentions,
    this.potentialAction,
    this.additionalProperties,
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'WebPage',
           if (name != null) 'name': name,
           if (description != null) 'description': description,
           if (url != null) 'url': url,
           if (inLanguage != null) 'inLanguage': inLanguage,
           if (datePublished != null) 'datePublished': datePublished,
           if (dateModified != null) 'dateModified': dateModified,
           if (author != null) 'author': author.value,
           if (publisher != null) 'publisher': publisher.value,
           if (keywords != null && keywords.isNotEmpty)
             'keywords': keywords.join(', '),
           if (primaryImageOfPage != null)
             'primaryImageOfPage': primaryImageOfPage.value,
           if (breadcrumb != null) 'breadcrumb': breadcrumb.value,
           if (mainEntity != null) 'mainEntity': mainEntity,
           if (mainContentOfPage != null)
             'mainContentOfPage': mainContentOfPage,
           if (lastReviewed != null) 'lastReviewed': lastReviewed,
           if (reviewedBy != null) 'reviewedBy': reviewedBy,
           if (significantLink != null && significantLink.isNotEmpty)
             'significantLink': significantLink,
           if (speakable != null) 'speakable': speakable,
           if (specialty != null && specialty.isNotEmpty)
             'specialty': specialty,
           if (relatedLink != null && relatedLink.isNotEmpty)
             'relatedLink': relatedLink,
           if (about != null) 'about': about,
           if (accessMode != null) 'accessMode': accessMode,
           if (accessibilityFeature != null && accessibilityFeature.isNotEmpty)
             'accessibilityFeature': accessibilityFeature,
           if (accessibilityHazard != null && accessibilityHazard.isNotEmpty)
             'accessibilityHazard': accessibilityHazard,
           if (accessibilitySummary != null)
             'accessibilitySummary': accessibilitySummary,
           if (accessibilityAPI != null) 'accessibilityAPI': accessibilityAPI,
           if (audience != null) 'audience': audience,
           if (contentRating != null) 'contentRating': contentRating,
           if (contentLocation != null) 'contentLocation': contentLocation,
           if (copyrightYear != null) 'copyrightYear': copyrightYear,
           if (copyrightHolder != null) 'copyrightHolder': copyrightHolder,
           if (license != null) 'license': license,
           if (isPartOf != null) 'isPartOf': isPartOf,
           if (hasPart != null) 'hasPart': hasPart,
           if (headline != null) 'headline': headline,
           if (alternativeHeadline != null)
             'alternativeHeadline': alternativeHeadline,
           if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
           if (video != null) 'video': video,
           if (audio != null) 'audio': audio,
           if (mentions != null) 'mentions': mentions,
           if (potentialAction != null && potentialAction.isNotEmpty)
             'potentialAction': potentialAction,
           if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Creates a basic WebPage schema with essential SEO properties
  factory WebPageSchema.basic({
    required String name,
    required String url,
    String? description,
    String? datePublished,
    String? dateModified,
    SchemaDataType<PersonSchema>? author,
    SchemaDataType<OrganizationSchema>? publisher,
    SchemaDataType<ImageSchema>? primaryImageOfPage,
  }) {
    return WebPageSchema(
      name: name,
      url: url,
      description: description,
      datePublished: datePublished,
      dateModified: dateModified,
      author: author,
      publisher: publisher,
      primaryImageOfPage: primaryImageOfPage,
    );
  }

  /// Creates a WebPage schema for article-like content
  factory WebPageSchema.article({
    required String headline,
    required String url,
    required String datePublished,
    required SchemaDataType<PersonSchema> author,
    String? description,
    String? dateModified,
    SchemaDataType<OrganizationSchema>? publisher,
    SchemaDataType<ImageSchema>? primaryImageOfPage,
    List<String>? keywords,
    SchemaDataType<BreadcrumbListSchema>? breadcrumb,
    String? lastReviewed,
    Map<String, dynamic>? reviewedBy,
  }) {
    return WebPageSchema(
      name: headline,
      headline: headline,
      url: url,
      description: description,
      datePublished: datePublished,
      dateModified: dateModified,
      author: author,
      publisher: publisher,
      primaryImageOfPage: primaryImageOfPage,
      keywords: keywords,
      breadcrumb: breadcrumb,
      lastReviewed: lastReviewed,
      reviewedBy: reviewedBy,
    );
  }

  /// Helper method to create speakable sections for voice assistants
  static Map<String, dynamic> createSpeakable({
    List<String>? cssSelector,
    List<String>? xpath,
  }) {
    return {
      '@type': 'SpeakableSpecification',
      if (cssSelector != null && cssSelector.isNotEmpty)
        'cssSelector': cssSelector,
      if (xpath != null && xpath.isNotEmpty) 'xpath': xpath,
    };
  }

  /// Helper method to create a video object
  static Map<String, dynamic> createVideo({
    required String name,
    required String description,
    required String thumbnailUrl,
    required String uploadDate,
    String? duration,
    String? contentUrl,
    String? embedUrl,
  }) {
    return {
      '@type': 'VideoObject',
      'name': name,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'uploadDate': uploadDate,
      if (duration != null) 'duration': duration,
      if (contentUrl != null) 'contentUrl': contentUrl,
      if (embedUrl != null) 'embedUrl': embedUrl,
    };
  }

  /// Helper method to create about/mentions entity
  static Map<String, dynamic> createEntity({
    required String type,
    required String name,
    String? url,
    String? description,
  }) {
    return {
      '@type': type,
      'name': name,
      if (url != null) 'url': url,
      if (description != null) 'description': description,
    };
  }

  final String? name;
  final String? description;
  final String? url;
  final String? inLanguage;
  final String? datePublished;
  final String? dateModified;
  final SchemaDataType<PersonSchema>? author;
  final SchemaDataType<OrganizationSchema>? publisher;
  final List<String>? keywords;
  final SchemaDataType<ImageSchema>? primaryImageOfPage;
  final SchemaDataType<BreadcrumbListSchema>? breadcrumb;
  final Map<String, dynamic>? mainEntity;
  final Map<String, dynamic>? mainContentOfPage;
  final String? lastReviewed;
  final Map<String, dynamic>? reviewedBy;
  final List<String>? significantLink;
  final Map<String, dynamic>? speakable;
  final List<String>? specialty;
  final List<String>? relatedLink;
  final Map<String, dynamic>? about;
  final String? accessMode;
  final List<String>? accessibilityFeature;
  final List<String>? accessibilityHazard;
  final String? accessibilitySummary;
  final String? accessibilityAPI;
  final String? audience;
  final String? contentRating;
  final String? contentLocation;
  final String? copyrightYear;
  final String? copyrightHolder;
  final String? license;
  final Map<String, dynamic>? isPartOf;
  final Map<String, dynamic>? hasPart;
  final String? headline;
  final String? alternativeHeadline;
  final String? thumbnailUrl;
  final Map<String, dynamic>? video;
  final Map<String, dynamic>? audio;
  final Map<String, dynamic>? mentions;
  final List<Map<String, dynamic>>? potentialAction;
  final Map<String, dynamic>? additionalProperties;
}
