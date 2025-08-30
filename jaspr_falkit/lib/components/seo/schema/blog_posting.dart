import 'package:jaspr_falkit/lib.dart';
import 'package:jaspr_falkit/components/seo/schema/base_schema.dart';

/// Data class for BlogPosting schema
class BlogPostingSchemaData {
  const BlogPostingSchemaData({
    this.headline,
    this.alternativeHeadline,
    this.description,
    this.articleBody,
    this.url,
    this.datePublished,
    this.dateModified,
    this.author,
    this.authorType,
    this.publisher,
    this.publisherType,
    this.publisherLogo,
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
  });

  final String? headline;
  final String? alternativeHeadline;
  final String? description;
  final String? articleBody;
  final String? url;
  final DateTime? datePublished;
  final DateTime? dateModified;
  final String? author;
  final String? authorType;
  final String? publisher;
  final String? publisherType;
  final String? publisherLogo;
  final String? image;
  final List<String>? keywords;
  final String? articleSection;
  final int? wordCount;
  final String? timeRequired;
  final String? inLanguage;
  final String? isPartOf;
  final String? mainEntityOfPage;
  final Map<String, dynamic>? sharedContent;
  final String? discussionUrl;
  final int? commentCount;
  final Map<String, dynamic>? interactionStatistic;
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

/// BlogPosting schema component with full schema.org support
class BlogPostingSchema extends Schema {
  /// Constructor with data class
  BlogPostingSchema(BlogPostingSchemaData data)
      : this.custom(
          headline: data.headline,
          alternativeHeadline: data.alternativeHeadline,
          description: data.description,
          articleBody: data.articleBody,
          url: data.url,
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
          image: data.image,
          keywords: data.keywords,
          articleSection: data.articleSection,
          wordCount: data.wordCount,
          timeRequired: data.timeRequired,
          inLanguage: data.inLanguage,
          isPartOf: data.isPartOf != null
              ? {
                  '@type': 'Blog',
                  'url': data.isPartOf,
                }
              : null,
          mainEntityOfPage: data.mainEntityOfPage != null
              ? {
                  '@type': 'WebPage',
                  '@id': data.mainEntityOfPage,
                }
              : null,
          sharedContent: data.sharedContent,
          discussionUrl: data.discussionUrl,
          commentCount: data.commentCount,
          interactionStatistic: data.interactionStatistic,
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
  BlogPostingSchema.custom({
    String? headline,
    String? alternativeHeadline,
    String? description,
    String? articleBody,
    String? url,
    String? datePublished,
    String? dateModified,
    Map<String, dynamic>? author,
    Map<String, dynamic>? publisher,
    String? image,
    List<String>? keywords,
    String? articleSection,
    int? wordCount,
    String? timeRequired,
    String? inLanguage,
    Map<String, dynamic>? isPartOf,
    Map<String, dynamic>? mainEntityOfPage,
    Map<String, dynamic>? sharedContent,
    String? discussionUrl,
    int? commentCount,
    Map<String, dynamic>? interactionStatistic,
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
            '@type': 'BlogPosting',
            if (headline != null) 'headline': headline,
            if (alternativeHeadline != null)
              'alternativeHeadline': alternativeHeadline,
            if (description != null) 'description': description,
            if (articleBody != null) 'articleBody': articleBody,
            if (url != null) 'url': url,
            if (datePublished != null) 'datePublished': datePublished,
            if (dateModified != null) 'dateModified': dateModified,
            if (author != null) 'author': author,
            if (publisher != null) 'publisher': publisher,
            if (image != null)
              'image': {'@type': 'ImageObject', 'url': image},
            if (keywords != null && keywords.isNotEmpty)
              'keywords': keywords.join(', '),
            if (articleSection != null)
              'articleSection': articleSection,
            if (wordCount != null) 'wordCount': wordCount,
            if (timeRequired != null) 'timeRequired': timeRequired,
            if (inLanguage != null) 'inLanguage': inLanguage,
            if (isPartOf != null) 'isPartOf': isPartOf,
            if (mainEntityOfPage != null)
              'mainEntityOfPage': mainEntityOfPage,
            if (sharedContent != null) 'sharedContent': sharedContent,
            if (discussionUrl != null) 'discussionUrl': discussionUrl,
            if (commentCount != null) 'commentCount': commentCount,
            if (interactionStatistic != null)
              'interactionStatistic': interactionStatistic,
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
    required String datePublished,
    required Map<String, dynamic> author,
    String? description,
    String? articleBody,
    String? url,
    String? image,
    List<String>? keywords,
    Map<String, dynamic>? isPartOf,
  }) {
    return BlogPostingSchema.custom(
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
    required String datePublished,
    required Map<String, dynamic> author,
    required Map<String, dynamic> publisher,
    String? description,
    String? articleBody,
    String? url,
    String? image,
    List<String>? keywords,
    String? articleSection,
    Map<String, dynamic>? isPartOf,
  }) {
    return BlogPostingSchema.custom(
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

  /// Method to convert to JSON for embedding in other schemas
  Map<String, dynamic> toJsonForEmbedding() {
    final json = <String, dynamic>{};
    final childrenList = children;
    if (childrenList != null && childrenList.isNotEmpty) {
      final firstChild = childrenList.first;
      if (firstChild is RawText) {
        final content = jsonDecode(firstChild.text) as Map<String, dynamic>;
        content.remove('@context');
        return content;
      }
    }
    return json;
  }
}

// Backward compatibility alias
typedef SeoBlogPostingSchema = BlogPostingSchema;
