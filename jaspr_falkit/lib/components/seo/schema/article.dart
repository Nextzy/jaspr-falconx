import 'package:jaspr_falkit/lib.dart';
import 'package:jaspr_falkit/components/seo/schema/base_schema.dart';

/// Data class for Article schema
class ArticleSchemaData {
  const ArticleSchemaData({
    this.headline,
    this.alternativeHeadline,
    this.description,
    this.datePublished,
    this.dateModified,
    this.author,
    this.authorType,
    this.publisher,
    this.publisherType,
    this.publisherLogo,
    this.url,
    this.imageUrl,
    this.keywords,
    this.articleSection,
    this.articleBody,
    this.wordCount,
    this.timeRequired,
    this.inLanguage,
    this.about,
    this.mentions,
    this.citation,
    this.comment,
    this.contributor,
    this.copyrightHolder,
    this.copyrightYear,
    this.creator,
    this.editor,
    this.genre,
    this.hasPart,
    this.isAccessibleForFree,
    this.isPartOf,
    this.license,
    this.mainEntity,
    this.position,
    this.thumbnailUrl,
    this.video,
    this.audio,
    this.speakable,
    this.backstory,
    this.additionalProperties,
  });

  final String? headline;
  final String? alternativeHeadline;
  final String? description;
  final DateTime? datePublished;
  final DateTime? dateModified;
  final String? author;
  final String? authorType;
  final String? publisher;
  final String? publisherType;
  final String? publisherLogo;
  final String? url;
  final String? imageUrl;
  final List<String>? keywords;
  final String? articleSection;
  final String? articleBody;
  final int? wordCount;
  final String? timeRequired;
  final String? inLanguage;
  final Map<String, dynamic>? about;
  final Map<String, dynamic>? mentions;
  final dynamic citation;
  final Map<String, dynamic>? comment;
  final Map<String, dynamic>? contributor;
  final String? copyrightHolder;
  final String? copyrightYear;
  final Map<String, dynamic>? creator;
  final Map<String, dynamic>? editor;
  final String? genre;
  final Map<String, dynamic>? hasPart;
  final bool? isAccessibleForFree;
  final Map<String, dynamic>? isPartOf;
  final String? license;
  final Map<String, dynamic>? mainEntity;
  final dynamic position;
  final String? thumbnailUrl;
  final Map<String, dynamic>? video;
  final Map<String, dynamic>? audio;
  final Map<String, dynamic>? speakable;
  final String? backstory;
  final Map<String, dynamic>? additionalProperties;
}

/// Article schema component with full schema.org support
class ArticleSchema extends Schema {
  /// Constructor with data class
  ArticleSchema(ArticleSchemaData data)
      : this.custom(
          headline: data.headline,
          alternativeHeadline: data.alternativeHeadline,
          description: data.description,
          datePublished: data.datePublished?.toIso8601String(),
          dateModified: data.dateModified?.toIso8601String(),
          author: data.author != null
              ? {
                  '@type': data.authorType ?? 'Person',
                  'name': data.author,
                }
              : null,
          publisher: data.publisher != null
              ? {
                  '@type': data.publisherType ?? 'Organization',
                  'name': data.publisher,
                  if (data.publisherLogo != null)
                    'logo': {
                      '@type': 'ImageObject',
                      'url': data.publisherLogo,
                    },
                }
              : null,
          url: data.url,
          image: data.imageUrl,
          keywords: data.keywords,
          articleSection: data.articleSection,
          articleBody: data.articleBody,
          wordCount: data.wordCount,
          timeRequired: data.timeRequired,
          inLanguage: data.inLanguage,
          about: data.about,
          mentions: data.mentions,
          citation: data.citation,
          comment: data.comment,
          contributor: data.contributor,
          copyrightHolder: data.copyrightHolder,
          copyrightYear: data.copyrightYear,
          creator: data.creator,
          editor: data.editor,
          genre: data.genre,
          hasPart: data.hasPart,
          isAccessibleForFree: data.isAccessibleForFree,
          isPartOf: data.isPartOf,
          license: data.license,
          mainEntity: data.mainEntity,
          position: data.position,
          thumbnailUrl: data.thumbnailUrl,
          video: data.video,
          audio: data.audio,
          speakable: data.speakable,
          backstory: data.backstory,
          additionalProperties: data.additionalProperties,
        );

  /// Custom constructor with individual parameters
  ArticleSchema.custom({
    String? headline,
    String? alternativeHeadline,
    String? description,
    String? datePublished,
    String? dateModified,
    Map<String, dynamic>? author,
    Map<String, dynamic>? publisher,
    String? url,
    String? image,
    List<String>? keywords,
    String? articleSection,
    String? articleBody,
    int? wordCount,
    String? timeRequired,
    String? inLanguage,
    Map<String, dynamic>? about,
    Map<String, dynamic>? mentions,
    dynamic citation,
    Map<String, dynamic>? comment,
    Map<String, dynamic>? contributor,
    String? copyrightHolder,
    String? copyrightYear,
    Map<String, dynamic>? creator,
    Map<String, dynamic>? editor,
    String? genre,
    Map<String, dynamic>? hasPart,
    bool? isAccessibleForFree,
    Map<String, dynamic>? isPartOf,
    String? license,
    Map<String, dynamic>? mainEntity,
    dynamic position,
    String? thumbnailUrl,
    Map<String, dynamic>? video,
    Map<String, dynamic>? audio,
    Map<String, dynamic>? speakable,
    String? backstory,
    Map<String, dynamic>? additionalProperties,
  }) : super(
          schemaData: {
            '@context': 'https://schema.org',
            '@type': 'Article',
                  if (headline != null) 'headline': headline,
                  if (alternativeHeadline != null)
                    'alternativeHeadline': alternativeHeadline,
                  if (description != null) 'description': description,
                  if (datePublished != null) 'datePublished': datePublished,
                  if (dateModified != null) 'dateModified': dateModified,
                  if (author != null) 'author': author,
                  if (publisher != null) 'publisher': publisher,
                  if (url != null) 'url': url,
                  if (image != null)
                    'image': image is String
                        ? {'@type': 'ImageObject', 'url': image}
                        : image,
                  if (keywords != null && keywords.isNotEmpty)
                    'keywords': keywords.join(', '),
                  if (articleSection != null)
                    'articleSection': articleSection,
                  if (articleBody != null) 'articleBody': articleBody,
                  if (wordCount != null) 'wordCount': wordCount,
                  if (timeRequired != null) 'timeRequired': timeRequired,
                  if (inLanguage != null) 'inLanguage': inLanguage,
                  if (about != null) 'about': about,
                  if (mentions != null) 'mentions': mentions,
                  if (citation != null) 'citation': citation,
                  if (comment != null) 'comment': comment,
                  if (contributor != null) 'contributor': contributor,
                  if (copyrightHolder != null)
                    'copyrightHolder': copyrightHolder,
                  if (copyrightYear != null) 'copyrightYear': copyrightYear,
                  if (creator != null) 'creator': creator,
                  if (editor != null) 'editor': editor,
                  if (genre != null) 'genre': genre,
                  if (hasPart != null) 'hasPart': hasPart,
                  if (isAccessibleForFree != null)
                    'isAccessibleForFree': isAccessibleForFree,
                  if (isPartOf != null) 'isPartOf': isPartOf,
                  if (license != null) 'license': license,
                  if (mainEntity != null) 'mainEntity': mainEntity,
                  if (position != null) 'position': position,
                  if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
                  if (video != null) 'video': video,
                  if (audio != null) 'audio': audio,
                  if (speakable != null) 'speakable': speakable,
                  if (backstory != null) 'backstory': backstory,
                  if (additionalProperties != null) ...additionalProperties,
          },
        );

  /// Factory constructor for news articles
  factory ArticleSchema.newsArticle({
    required String headline,
    required String datePublished,
    required Map<String, dynamic> publisher,
    String? description,
    String? articleSection,
    Map<String, dynamic>? author,
    String? url,
    String? image,
    List<String>? keywords,
  }) {
    return ArticleSchema.custom(
      headline: headline,
      datePublished: datePublished,
      publisher: publisher,
      description: description,
      articleSection: articleSection,
      author: author,
      url: url,
      image: image,
      keywords: keywords,
    );
  }

  /// Factory constructor for tech articles
  factory ArticleSchema.techArticle({
    required String headline,
    required String datePublished,
    required Map<String, dynamic> author,
    String? description,
    String? articleBody,
    String? url,
    String? image,
    List<String>? keywords,
    String? genre,
    Map<String, dynamic>? about,
  }) {
    return ArticleSchema.custom(
      headline: headline,
      datePublished: datePublished,
      author: author,
      description: description,
      articleBody: articleBody,
      url: url,
      image: image,
      keywords: keywords,
      genre: genre ?? 'Technology',
      about: about,
    );
  }

  /// Helper method to create author object
  static Map<String, dynamic> createAuthor({
    required String name,
    String type = 'Person',
    String? url,
    String? email,
    String? jobTitle,
    Map<String, dynamic>? affiliation,
  }) {
    return {
      '@type': type,
      'name': name,
      if (url != null) 'url': url,
      if (email != null) 'email': email,
      if (jobTitle != null) 'jobTitle': jobTitle,
      if (affiliation != null) 'affiliation': affiliation,
    };
  }

  /// Helper method to create publisher object
  static Map<String, dynamic> createPublisher({
    required String name,
    String? url,
    String? logo,
    Map<String, dynamic>? address,
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
      if (address != null) 'address': address,
    };
  }

  /// Helper method to create video object
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

  /// Helper method to create speakable specification
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
}

// Backward compatibility alias
typedef ArticleSchemaOrg = ArticleSchema;