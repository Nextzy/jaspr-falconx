import 'package:jaspr_falkit/lib.dart';

class BlogPostingSchema {
  const BlogPostingSchema({
    required this.headline,
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
    this.additionalProperties,
  });

  final String headline;
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
  final String? timeRequired; // e.g., "PT5M" for 5 minutes
  final String? inLanguage;
  final String? isPartOf; // URL to the blog or website
  final String? mainEntityOfPage;
  final Map<String, dynamic>? additionalProperties;

  Map<String, dynamic> toJsonForEmbedding() {
    // Returns JSON without @context for embedding in other schemas
    return {
      '@type': 'BlogPosting',
      'headline': headline,
      if (alternativeHeadline != null) 
        'alternativeHeadline': alternativeHeadline,
      if (description != null) 
        'description': description,
      if (articleBody != null) 
        'articleBody': articleBody,
      if (url != null) 
        'url': url,
      if (datePublished != null)
        'datePublished': datePublished!.toIso8601String(),
      if (dateModified != null)
        'dateModified': dateModified!.toIso8601String(),
      if (author != null)
        'author': {
          '@type': authorType ?? 'Person',
          'name': author,
        },
      if (publisher != null)
        'publisher': {
          '@type': publisherType ?? 'Organization',
          'name': publisher,
          if (publisherLogo != null)
            'logo': {
              '@type': 'ImageObject',
              'url': publisherLogo,
            },
        },
      if (image != null)
        'image': {
          '@type': 'ImageObject',
          'url': image,
        },
      if (keywords != null && keywords!.isNotEmpty)
        'keywords': keywords!.join(', '),
      if (articleSection != null)
        'articleSection': articleSection,
      if (wordCount != null)
        'wordCount': wordCount,
      if (timeRequired != null)
        'timeRequired': timeRequired,
      if (inLanguage != null)
        'inLanguage': inLanguage,
      if (isPartOf != null)
        'isPartOf': {
          '@type': 'Blog',
          'url': isPartOf,
        },
      if (mainEntityOfPage != null)
        'mainEntityOfPage': {
          '@type': 'WebPage',
          '@id': mainEntityOfPage,
        },
      if (additionalProperties != null)
        ...additionalProperties!,
    }..removeWhere((key, value) => value == null);
  }
  
  Map<String, dynamic> toJson() {
    // Returns full JSON with @context for standalone use
    return {
      '@context': 'https://schema.org',
      ...toJsonForEmbedding(),
    };
  }
}

class SeoBlogPostingSchema extends DomComponent {
  SeoBlogPostingSchema(BlogPostingSchema schema)
      : super(
          tag: 'script',
          attributes: const {'type': 'application/ld+json'},
          children: [
            raw(jsonEncode(schema.toJson())),
          ],
        );
}