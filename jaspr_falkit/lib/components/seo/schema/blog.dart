import 'package:jaspr_falkit/lib.dart';

/// Blog schema component with full schema.org support
/// Implements https://schema.org/Blog specification
class BlogSchema extends Schema {
  BlogSchema({
    this.name,
    this.description,
    this.url,
    this.publisher,
    this.publisherType,
    this.publisherLogo,
    this.inLanguage,
    this.blogPost,
    this.author,
    this.authorType,
    this.dateCreated,
    this.dateModified,
    this.keywords,
    this.image,
    this.about,
    this.accountablePerson,
    this.aggregateRating,
    this.audience,
    this.award,
    this.copyrightHolder,
    this.copyrightYear,
    this.creator,
    this.discussionUrl,
    this.editor,
    this.encoding,
    this.funder,
    this.genre,
    this.hasPart,
    this.headline,
    this.interactionStatistic,
    this.isAccessibleForFree,
    this.isBasedOn,
    this.isFamilyFriendly,
    this.isPartOf,
    this.issn,
    this.license,
    this.mainEntity,
    this.mainEntityOfPage,
    this.mentions,
    this.offers,
    this.position,
    this.potentialAction,
    this.provider,
    this.publication,
    this.review,
    this.schemaVersion,
    this.sourceOrganization,
    this.sponsor,
    this.thumbnailUrl,
    this.timeRequired,
    this.translator,
    this.typicalAgeRange,
    this.version,
    this.video,
    this.workExample,
    this.additionalProperties,
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'Blog',
           'name': ?name,
           'description': ?description,
           'url': ?url,
           if (publisher != null) 'publisher': publisher.value,
           'inLanguage': ?inLanguage,
           if (blogPost != null && blogPost.isNotEmpty)
             'blogPost': blogPost
                 .map(
                   (blog) => blog.schemaData,
                 )
                 .toList(),
           if (author != null) 'author': author.value,
           'dateCreated': ?dateCreated,
           'dateModified': ?dateModified,
           if (keywords != null && keywords.isNotEmpty)
             'keywords': keywords.join(', '),
           if (image != null) 'image': image.value,
           'about': ?about,
           'accountablePerson': ?accountablePerson,
           'aggregateRating': ?aggregateRating,
           'audience': ?audience,
           'award': ?award,
           'copyrightHolder': ?copyrightHolder,
           'copyrightYear': ?copyrightYear,
           'creator': ?creator,
           'discussionUrl': ?discussionUrl,
           'editor': ?editor,
           'encoding': ?encoding,
           'funder': ?funder,
           'genre': ?genre,
           'hasPart': ?hasPart,
           'headline': ?headline,
           'interactionStatistic': ?interactionStatistic,
           'isAccessibleForFree': ?isAccessibleForFree,
           'isBasedOn': ?isBasedOn,
           'isFamilyFriendly': ?isFamilyFriendly,
           'isPartOf': ?isPartOf,
           'issn': ?issn,
           'license': ?license,
           'mainEntity': ?mainEntity,
           'mainEntityOfPage': ?mainEntityOfPage,
           'mentions': ?mentions,
           'offers': ?offers,
           if (position != null) 'position': position.value,
           'potentialAction': ?potentialAction,
           'provider': ?provider,
           'publication': ?publication,
           'review': ?review,
           'schemaVersion': ?schemaVersion,
           'sourceOrganization': ?sourceOrganization,
           'sponsor': ?sponsor,
           'thumbnailUrl': ?thumbnailUrl,
           'timeRequired': ?timeRequired,
           'translator': ?translator,
           'typicalAgeRange': ?typicalAgeRange,
           'version': ?version,
           'video': ?video,
           'workExample': ?workExample,
           if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Factory constructor for personal blogs
  factory BlogSchema.personal({
    required String name,
    required String url,
    required SchemaDataType<PersonSchema> author,
    String? description,
    List<BlogPostingSchema>? blogPost,
    List<String>? keywords,
    SchemaDataType<ImageSchema>? image,
  }) {
    return BlogSchema(
      name: name,
      url: url,
      author: author,
      description: description,
      blogPost: blogPost,
      keywords: keywords,
      image: image,
    );
  }

  /// Factory constructor for corporate blogs
  factory BlogSchema.corporate({
    required String name,
    required String url,
    required SchemaDataType<OrganizationSchema> publisher,
    String? description,
    List<BlogPostingSchema>? blogPost,
    List<String>? keywords,
    SchemaDataType<ImageSchema>? image,
    Map<String, dynamic>? sponsor,
  }) {
    return BlogSchema(
      name: name,
      url: url,
      publisher: publisher,
      description: description,
      blogPost: blogPost,
      keywords: keywords,
      image: image,
      sponsor: sponsor,
    );
  }

  final String? name;
  final String? description;
  final String? url;
  final SchemaDataType<OrganizationSchema>? publisher;
  final String? publisherType;
  final String? publisherLogo;
  final String? inLanguage;
  final List<BlogPostingSchema>? blogPost;
  final SchemaDataType<PersonSchema>? author;
  final String? authorType;
  final DateTime? dateCreated;
  final DateTime? dateModified;
  final List<String>? keywords;
  final SchemaDataType<ImageSchema>? image;
  final Map<String, dynamic>? about;
  final Map<String, dynamic>? accountablePerson;
  final Map<String, dynamic>? aggregateRating;
  final Map<String, dynamic>? audience;
  final String? award;
  final String? copyrightHolder;
  final String? copyrightYear;
  final Map<String, dynamic>? creator;
  final String? discussionUrl;
  final Map<String, dynamic>? editor;
  final Map<String, dynamic>? encoding;
  final Map<String, dynamic>? funder;
  final String? genre;
  final Map<String, dynamic>? hasPart;
  final String? headline;
  final Map<String, dynamic>? interactionStatistic;
  final bool? isAccessibleForFree;
  final Map<String, dynamic>? isBasedOn;
  final bool? isFamilyFriendly;
  final Map<String, dynamic>? isPartOf;
  final String? issn;
  final String? license;
  final Map<String, dynamic>? mainEntity;
  final Map<String, dynamic>? mainEntityOfPage;
  final Map<String, dynamic>? mentions;
  final Map<String, dynamic>? offers;
  final SchemaDataType<Schema>? position;
  final Map<String, dynamic>? potentialAction;
  final Map<String, dynamic>? provider;
  final Map<String, dynamic>? publication;
  final Map<String, dynamic>? review;
  final String? schemaVersion;
  final Map<String, dynamic>? sourceOrganization;
  final Map<String, dynamic>? sponsor;
  final String? thumbnailUrl;
  final String? timeRequired;
  final Map<String, dynamic>? translator;
  final String? typicalAgeRange;
  final String? version;
  final Map<String, dynamic>? video;
  final Map<String, dynamic>? workExample;
  final Map<String, dynamic>? additionalProperties;

  /// Helper method to create blog post reference
  static Map<String, dynamic> createBlogPost({
    required String headline,
    required String url,
    String? datePublished,
    Map<String, dynamic>? author,
    String? description,
  }) {
    return {
      '@type': 'BlogPosting',
      'headline': headline,
      'url': url,
      'datePublished': ?datePublished,
      'author': ?author,
      'description': ?description,
    };
  }

  /// Helper method to create aggregate rating
  static Map<String, dynamic> createAggregateRating({
    required double ratingValue,
    required int reviewCount,
    double? bestRating,
    double? worstRating,
  }) {
    return {
      '@type': 'AggregateRating',
      'ratingValue': ratingValue,
      'reviewCount': reviewCount,
      'bestRating': ?bestRating,
      'worstRating': ?worstRating,
    };
  }

  /// Helper method to create review
  static Map<String, dynamic> createReview({
    required String reviewBody,
    required Map<String, dynamic> author,
    required double ratingValue,
    String? datePublished,
  }) {
    return {
      '@type': 'Review',
      'reviewBody': reviewBody,
      'author': author,
      'reviewRating': {
        '@type': 'Rating',
        'ratingValue': ratingValue,
      },
      'datePublished': ?datePublished,
    };
  }
}

// Backward compatibility alias
typedef SeoBlogSchema = BlogSchema;
