import 'package:jaspr_falkit/lib.dart';

/// BlogPosting schema component with full schema.org support
/// Implements https://schema.org/BlogPosting specification
class BlogPostingSchema extends Schema {
  BlogPostingSchema({
    this.headline,
    this.alternativeHeadline,
    this.description,
    this.articleBody,
    this.url,
    this.datePublished,
    this.dateModified,
    this.author,
    this.publisher,
    this.image,
    this.keywords,
    this.articleSection,
    this.wordCount,
    this.timeRequired,
    this.inLanguage,
    this.isPartOf,
    this.mainEntityOfPage,
    this.sharedContent,
    this.discussionUrl,
    this.commentCount,
    this.interactionStatistic,
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
           '@type': 'BlogPosting',
           if (headline != null) 'headline': headline,
           if (alternativeHeadline != null)
             'alternativeHeadline': alternativeHeadline,
           if (description != null) 'description': description,
           if (articleBody != null) 'articleBody': articleBody,
           if (url != null) 'url': url,
           if (datePublished != null)
             'datePublished': datePublished.toIso8601String(),
           if (dateModified != null)
             'dateModified': dateModified.toIso8601String(),
           if (author != null) 'author': author.value,
           if (publisher != null) 'publisher': publisher.value,
           if (image != null) 'image': image.value,
           if (keywords != null && keywords.isNotEmpty)
             'keywords': keywords.join(', '),
           if (articleSection != null) 'articleSection': articleSection,
           if (wordCount != null) 'wordCount': wordCount,
           if (timeRequired != null) 'timeRequired': timeRequired,
           if (inLanguage != null) 'inLanguage': inLanguage,
           if (isPartOf != null) 'isPartOf': isPartOf.value,
           if (mainEntityOfPage != null)
             'mainEntityOfPage': mainEntityOfPage.value,
           if (sharedContent != null) 'sharedContent': sharedContent,
           if (discussionUrl != null) 'discussionUrl': discussionUrl,
           if (commentCount != null) 'commentCount': commentCount,
           if (interactionStatistic != null)
             'interactionStatistic': interactionStatistic,
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

  /// Factory constructor for personal blog posts
  factory BlogPostingSchema.personal({
    required String headline,
    required DateTime datePublished,
    required SchemaDataType<PersonSchema> author,
    String? description,
    String? articleBody,
    String? url,
    SchemaDataType<ImageSchema>? image,
    List<String>? keywords,
    SchemaDataType<BlogSchema>? isPartOf,
  }) {
    return BlogPostingSchema(
      headline: headline,
      datePublished: datePublished,
      author: author,
      description: description,
      articleBody: articleBody,
      url: url,
      image: image,
      keywords: keywords,
      isPartOf: isPartOf,
    );
  }

  /// Factory constructor for corporate blog posts
  factory BlogPostingSchema.corporate({
    required String headline,
    required DateTime datePublished,
    required SchemaDataType<PersonSchema> author,
    required SchemaDataType<OrganizationSchema> publisher,
    String? description,
    String? articleBody,
    String? url,
    SchemaDataType<ImageSchema>? image,
    List<String>? keywords,
    String? articleSection,
    SchemaDataType<BlogSchema>? isPartOf,
  }) {
    return BlogPostingSchema(
      headline: headline,
      datePublished: datePublished,
      author: author,
      publisher: publisher,
      description: description,
      articleBody: articleBody,
      url: url,
      image: image,
      keywords: keywords,
      articleSection: articleSection,
      isPartOf: isPartOf,
    );
  }

  final String? headline;
  final String? alternativeHeadline;
  final String? description;
  final String? articleBody;
  final String? url;
  final DateTime? datePublished;
  final DateTime? dateModified;
  final SchemaDataType<PersonSchema>? author;
  final SchemaDataType<OrganizationSchema>? publisher;
  final SchemaDataType<ImageSchema>? image;
  final List<String>? keywords;
  final String? articleSection;
  final int? wordCount;
  final String? timeRequired;
  final String? inLanguage;
  final SchemaDataType<BlogSchema>? isPartOf;
  final SchemaDataType<WebPageSchema>? mainEntityOfPage;
  final Map<String, dynamic>? sharedContent;
  final String? discussionUrl;
  final int? commentCount;
  final Map<String, dynamic>? interactionStatistic;
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

  /// Helper method to create blog reference
  static Map<String, dynamic> createBlogReference({
    required String url,
    String? name,
    String? description,
  }) {
    return {
      '@type': 'Blog',
      'url': url,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    };
  }

  /// Helper method to create interaction statistics
  static Map<String, dynamic> createInteractionStatistic({
    required String interactionType,
    required int userInteractionCount,
  }) {
    return {
      '@type': 'InteractionCounter',
      'interactionType': {
        '@type': interactionType,
      },
      'userInteractionCount': userInteractionCount,
    };
  }
}
