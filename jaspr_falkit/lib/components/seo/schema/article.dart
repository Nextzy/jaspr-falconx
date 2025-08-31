import 'package:jaspr_falkit/lib.dart';

/// Article schema component with full schema.org support
class ArticleSchema extends Schema {
  ArticleSchema({
    this.headline,
    this.alternativeHeadline,
    this.description,
    this.datePublished,
    this.dateModified,
    this.author,
    this.publisher,
    this.url,
    this.image,
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
           if (author != null) 'author': author.value,
           if (publisher != null) 'publisher': publisher.value,
           if (url != null) 'url': url,
           if (image != null) 'image': image.value,
           if (keywords != null && keywords.isNotEmpty)
             'keywords': keywords.join(', '),
           if (articleSection != null) 'articleSection': articleSection,
           if (articleBody != null) 'articleBody': articleBody,
           if (wordCount != null) 'wordCount': wordCount,
           if (timeRequired != null) 'timeRequired': timeRequired,
           if (inLanguage != null) 'inLanguage': inLanguage,
           if (about != null) 'about': about,
           if (mentions != null) 'mentions': mentions,
           if (citation != null) 'citation': citation,
           if (comment != null) 'comment': comment,
           if (contributor != null) 'contributor': contributor.value,
           if (copyrightHolder != null) 'copyrightHolder': copyrightHolder,
           if (copyrightYear != null) 'copyrightYear': copyrightYear,
           if (creator != null) 'creator': creator.value,
           if (editor != null) 'editor': editor.value,
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
    required SchemaDataType<OrganizationSchema> publisher,
    String? description,
    String? articleSection,
    SchemaDataType<PersonSchema>? author,
    String? url,
    SchemaDataType<ImageSchema>? image,
    List<String>? keywords,
  }) {
    return ArticleSchema(
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
    required SchemaDataType<PersonSchema> author,
    String? description,
    String? articleBody,
    String? url,
    SchemaDataType<ImageSchema>? image,
    List<String>? keywords,
    String? genre,
    Map<String, dynamic>? about,
  }) {
    return ArticleSchema(
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

  /// Factory constructor for blog posts
  factory ArticleSchema.blogPost({
    required String headline,
    required String datePublished,
    required SchemaDataType<PersonSchema> author,
    String? description,
    String? articleBody,
    String? url,
    SchemaDataType<ImageSchema>? image,
    List<String>? keywords,
    String? dateModified,
    SchemaDataType<OrganizationSchema>? publisher,
  }) {
    return ArticleSchema(
      headline: headline,
      datePublished: datePublished,
      dateModified: dateModified,
      author: author,
      publisher: publisher,
      description: description,
      articleBody: articleBody,
      url: url,
      image: image,
      keywords: keywords,
    );
  }

  /// Factory constructor for scholarly articles
  factory ArticleSchema.scholarlyArticle({
    required String headline,
    required String datePublished,
    required SchemaDataType<PersonSchema> author,
    required String articleBody,
    String? description,
    String? url,
    SchemaDataType<ImageSchema>? image,
    List<String>? keywords,
    dynamic citation,
    String? genre,
    dynamic isPartOf,
  }) {
    return ArticleSchema(
      headline: headline,
      datePublished: datePublished,
      author: author,
      articleBody: articleBody,
      description: description,
      url: url,
      image: image,
      keywords: keywords,
      citation: citation,
      genre: genre ?? 'Academic',
      isPartOf: isPartOf is Map<String, dynamic> ? isPartOf : null,
    );
  }

  final String? headline;
  final String? alternativeHeadline;
  final String? description;
  final String? datePublished;
  final String? dateModified;
  final SchemaDataType<PersonSchema>? author;
  final SchemaDataType<OrganizationSchema>? publisher;
  final String? url;
  final SchemaDataType<ImageSchema>? image;
  final List<String>? keywords;
  final String? articleSection;
  final String? articleBody;
  final int? wordCount;
  final String? timeRequired;
  final String? inLanguage;
  final Map<String, dynamic>? about;
  final Map<String, dynamic>? mentions;
  final dynamic citation; // Can be String, List, or Map
  final Map<String, dynamic>? comment;
  final SchemaDataType<PersonSchema>? contributor;
  final String? copyrightHolder;
  final String? copyrightYear;
  final SchemaDataType<PersonSchema>? creator;
  final SchemaDataType<PersonSchema>? editor;
  final String? genre;
  final Map<String, dynamic>? hasPart;
  final bool? isAccessibleForFree;
  final Map<String, dynamic>? isPartOf;
  final String? license;
  final Map<String, dynamic>? mainEntity;
  final dynamic position; // Can be String or Number
  final String? thumbnailUrl;
  final Map<String, dynamic>? video;
  final Map<String, dynamic>? audio;
  final Map<String, dynamic>? speakable;
  final String? backstory;
  final Map<String, dynamic>? additionalProperties;

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

  /// Helper method to create audio object
  static Map<String, dynamic> createAudio({
    required String name,
    required String description,
    required String contentUrl,
    String? duration,
    String? encodingFormat,
    String? uploadDate,
  }) {
    return {
      '@type': 'AudioObject',
      'name': name,
      'description': description,
      'contentUrl': contentUrl,
      if (duration != null) 'duration': duration,
      if (encodingFormat != null) 'encodingFormat': encodingFormat,
      if (uploadDate != null) 'uploadDate': uploadDate,
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

  /// Helper method to create citation
  static Map<String, dynamic> createCitation({
    required String name,
    required String author,
    String? publisher,
    String? datePublished,
    String? url,
    String? doi,
  }) {
    return {
      '@type': 'CreativeWork',
      'name': name,
      'author': {'@type': 'Person', 'name': author},
      if (publisher != null) 'publisher': publisher,
      if (datePublished != null) 'datePublished': datePublished,
      if (url != null) 'url': url,
      if (doi != null) 'identifier': {'@type': 'PropertyValue', 'value': doi},
    };
  }
}

// Backward compatibility alias
typedef ArticleSchemaOrg = ArticleSchema;
typedef ArticleSchemaData = ArticleSchema;
