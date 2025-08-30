import 'package:jaspr_falkit/lib.dart';
import 'package:jaspr_falkit/components/seo/schema/base_schema.dart';

/// WebPageSchemaData - Data class for backward compatibility
class WebPageSchemaData {
  const WebPageSchemaData({
    this.name,
    this.description,
    this.url,
    this.inLanguage,
    this.datePublished,
    this.dateModified,
    this.author,
    this.authorType,
    this.publisher,
    this.publisherType,
    this.publisherLogo,
    this.keywords,
    this.imageUrl,
    this.breadcrumb,
    this.mainEntity,
    this.additionalProperties,
  });

  final String? name;
  final String? description;
  final String? url;
  final String? inLanguage;
  final DateTime? datePublished;
  final DateTime? dateModified;
  final String? author;
  final String? authorType;
  final String? publisher;
  final String? publisherType;
  final String? publisherLogo;
  final List<String>? keywords;
  final String? imageUrl;
  final Map<String, dynamic>? breadcrumb;
  final Map<String, dynamic>? mainEntity;
  final Map<String, dynamic>? additionalProperties;
}

/// Enhanced WebPage schema with all schema.org properties
class WebPageSchema extends Schema {
  /// Constructor for backward compatibility with WebPageSchemaData
  WebPageSchema(WebPageSchemaData data)
    : this.enhanced(
        name: data.name,
        description: data.description,
        url: data.url,
        inLanguage: data.inLanguage,
        datePublished: data.datePublished?.toIso8601String(),
        dateModified: data.dateModified?.toIso8601String(),
        author: data.author != null ? {
          '@type': data.authorType ?? 'Person',
          'name': data.author,
        } : null,
        publisher: data.publisher != null ? {
          '@type': data.publisherType ?? 'Organization',
          'name': data.publisher,
          if (data.publisherLogo != null) 'logo': {
            '@type': 'ImageObject',
            'url': data.publisherLogo,
          },
        } : null,
        keywords: data.keywords,
        primaryImageOfPage: data.imageUrl,
        breadcrumb: data.breadcrumb,
        mainEntity: data.mainEntity,
        additionalProperties: data.additionalProperties,
      );

  /// Enhanced constructor with all schema.org properties
  WebPageSchema.enhanced({
    String? name,
    String? description,
    String? url,
    String? inLanguage,
    String? datePublished,
    String? dateModified,
    Map<String, dynamic>? author,
    Map<String, dynamic>? publisher,
    List<String>? keywords,
    String? primaryImageOfPage,
    Map<String, dynamic>? breadcrumb,
    Map<String, dynamic>? mainEntity,
    Map<String, dynamic>? mainContentOfPage,
    String? lastReviewed,
    Map<String, dynamic>? reviewedBy,
    List<String>? significantLink,
    Map<String, dynamic>? speakable,
    List<String>? specialty,
    List<String>? relatedLink,
    Map<String, dynamic>? about,
    String? accessMode,
    List<String>? accessibilityFeature,
    List<String>? accessibilityHazard,
    String? accessibilitySummary,
    String? accessibilityAPI,
    String? audience,
    String? contentRating,
    String? contentLocation,
    String? copyrightYear,
    String? copyrightHolder,
    String? license,
    Map<String, dynamic>? isPartOf,
    Map<String, dynamic>? hasPart,
    String? headline,
    String? alternativeHeadline,
    String? thumbnailUrl,
    Map<String, dynamic>? video,
    Map<String, dynamic>? audio,
    Map<String, dynamic>? mentions,
    List<Map<String, dynamic>>? potentialAction,
    Map<String, dynamic>? additionalProperties,
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
                 if (author != null) 'author': author,
                 if (publisher != null) 'publisher': publisher,
                 if (keywords != null && keywords.isNotEmpty) 
                   'keywords': keywords.join(', '),
                 if (primaryImageOfPage != null)
                   'primaryImageOfPage': {
                     '@type': 'ImageObject',
                     'url': primaryImageOfPage,
                   },
                 if (breadcrumb != null) 'breadcrumb': breadcrumb,
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
                 if (accessibilityFeature != null && 
                     accessibilityFeature.isNotEmpty)
                   'accessibilityFeature': accessibilityFeature,
                 if (accessibilityHazard != null && 
                     accessibilityHazard.isNotEmpty)
                   'accessibilityHazard': accessibilityHazard,
                 if (accessibilitySummary != null) 
                   'accessibilitySummary': accessibilitySummary,
                 if (accessibilityAPI != null) 
                   'accessibilityAPI': accessibilityAPI,
                 if (audience != null) 'audience': audience,
                 if (contentRating != null) 'contentRating': contentRating,
                 if (contentLocation != null) 
                   'contentLocation': contentLocation,
                 if (copyrightYear != null) 'copyrightYear': copyrightYear,
                 if (copyrightHolder != null) 
                   'copyrightHolder': copyrightHolder,
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
    Map<String, dynamic>? author,
    Map<String, dynamic>? publisher,
    String? primaryImageOfPage,
  }) {
    return WebPageSchema.enhanced(
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
    required Map<String, dynamic> author,
    String? description,
    String? dateModified,
    Map<String, dynamic>? publisher,
    String? primaryImageOfPage,
    List<String>? keywords,
    Map<String, dynamic>? breadcrumb,
    String? lastReviewed,
    Map<String, dynamic>? reviewedBy,
  }) {
    return WebPageSchema.enhanced(
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

  /// Helper method to create an author structure
  static Map<String, dynamic> createAuthor({
    required String name,
    String type = 'Person',
    String? url,
    String? email,
  }) {
    return {
      '@type': type,
      'name': name,
      if (url != null) 'url': url,
      if (email != null) 'email': email,
    };
  }

  /// Helper method to create a publisher structure
  static Map<String, dynamic> createPublisher({
    required String name,
    String? url,
    String? logo,
  }) {
    return {
      '@type': 'Organization',
      'name': name,
      if (url != null) 'url': url,
      if (logo != null)
        'logo': {
          '@type': 'ImageObject',
          'url': logo,
        },
    };
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
}

// For backward compatibility - alias to the new class
typedef WebPageEnhancedSchema = WebPageSchema;
