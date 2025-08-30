import 'package:jaspr_falkit/lib.dart';
import 'package:jaspr_falkit/components/seo/schema/base_schema.dart';

/// Data class for Blog schema
class BlogSchemaData {
  const BlogSchemaData({
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
    this.imageUrl,
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
  });

  final String? name;
  final String? description;
  final String? url;
  final String? publisher;
  final String? publisherType;
  final String? publisherLogo;
  final String? inLanguage;
  final List<Map<String, dynamic>>? blogPost;
  final String? author;
  final String? authorType;
  final DateTime? dateCreated;
  final DateTime? dateModified;
  final List<String>? keywords;
  final String? imageUrl;
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
  final dynamic position;
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
}

/// Blog schema component with full schema.org support
/// Implements https://schema.org/Blog specification
class BlogSchema extends Schema {
  /// Constructor with data class
  BlogSchema(BlogSchemaData data)
      : this.custom(
          name: data.name,
          description: data.description,
          url: data.url,
          publisher: data.publisher != null
              ? Schema.createOrganization(
                  name: data.publisher!,
                  url: data.url,
                  logo: data.publisherLogo,
                )
              : null,
          inLanguage: data.inLanguage,
          blogPost: data.blogPost,
          author: data.author != null
              ? Schema.createPerson(
                  name: data.author!,
                )
              : null,
          dateCreated: data.dateCreated?.toIso8601String(),
          dateModified: data.dateModified?.toIso8601String(),
          keywords: data.keywords,
          image: data.imageUrl,
          about: data.about,
          accountablePerson: data.accountablePerson,
          aggregateRating: data.aggregateRating,
          audience: data.audience,
          award: data.award,
          copyrightHolder: data.copyrightHolder,
          copyrightYear: data.copyrightYear,
          creator: data.creator,
          discussionUrl: data.discussionUrl,
          editor: data.editor,
          encoding: data.encoding,
          funder: data.funder,
          genre: data.genre,
          hasPart: data.hasPart,
          headline: data.headline,
          interactionStatistic: data.interactionStatistic,
          isAccessibleForFree: data.isAccessibleForFree,
          isBasedOn: data.isBasedOn,
          isFamilyFriendly: data.isFamilyFriendly,
          isPartOf: data.isPartOf,
          issn: data.issn,
          license: data.license,
          mainEntity: data.mainEntity,
          mainEntityOfPage: data.mainEntityOfPage,
          mentions: data.mentions,
          offers: data.offers,
          position: data.position,
          potentialAction: data.potentialAction,
          provider: data.provider,
          publication: data.publication,
          review: data.review,
          schemaVersion: data.schemaVersion,
          sourceOrganization: data.sourceOrganization,
          sponsor: data.sponsor,
          thumbnailUrl: data.thumbnailUrl,
          timeRequired: data.timeRequired,
          translator: data.translator,
          typicalAgeRange: data.typicalAgeRange,
          version: data.version,
          video: data.video,
          workExample: data.workExample,
          additionalProperties: data.additionalProperties,
        );

  /// Custom constructor with individual parameters
  BlogSchema.custom({
    String? name,
    String? description,
    String? url,
    Map<String, dynamic>? publisher,
    String? inLanguage,
    List<Map<String, dynamic>>? blogPost,
    Map<String, dynamic>? author,
    String? dateCreated,
    String? dateModified,
    List<String>? keywords,
    String? image,
    Map<String, dynamic>? about,
    Map<String, dynamic>? accountablePerson,
    Map<String, dynamic>? aggregateRating,
    Map<String, dynamic>? audience,
    String? award,
    String? copyrightHolder,
    String? copyrightYear,
    Map<String, dynamic>? creator,
    String? discussionUrl,
    Map<String, dynamic>? editor,
    Map<String, dynamic>? encoding,
    Map<String, dynamic>? funder,
    String? genre,
    Map<String, dynamic>? hasPart,
    String? headline,
    Map<String, dynamic>? interactionStatistic,
    bool? isAccessibleForFree,
    Map<String, dynamic>? isBasedOn,
    bool? isFamilyFriendly,
    Map<String, dynamic>? isPartOf,
    String? issn,
    String? license,
    Map<String, dynamic>? mainEntity,
    Map<String, dynamic>? mainEntityOfPage,
    Map<String, dynamic>? mentions,
    Map<String, dynamic>? offers,
    dynamic position,
    Map<String, dynamic>? potentialAction,
    Map<String, dynamic>? provider,
    Map<String, dynamic>? publication,
    Map<String, dynamic>? review,
    String? schemaVersion,
    Map<String, dynamic>? sourceOrganization,
    Map<String, dynamic>? sponsor,
    String? thumbnailUrl,
    String? timeRequired,
    Map<String, dynamic>? translator,
    String? typicalAgeRange,
    String? version,
    Map<String, dynamic>? video,
    Map<String, dynamic>? workExample,
    Map<String, dynamic>? additionalProperties,
  }) : super(
          schemaData: {
            '@context': 'https://schema.org',
            '@type': 'Blog',
            if (name != null) 'name': name,
            if (description != null) 'description': description,
            if (url != null) 'url': url,
            if (publisher != null) 'publisher': publisher,
            if (inLanguage != null) 'inLanguage': inLanguage,
            if (blogPost != null && blogPost.isNotEmpty)
              'blogPost': blogPost,
            if (author != null) 'author': author,
            if (dateCreated != null) 'dateCreated': dateCreated,
            if (dateModified != null) 'dateModified': dateModified,
            if (keywords != null && keywords.isNotEmpty)
              'keywords': keywords.join(', '),
            if (image != null)
              'image': Schema.createImageObject(image),
            if (about != null) 'about': about,
            if (accountablePerson != null)
              'accountablePerson': accountablePerson,
            if (aggregateRating != null)
              'aggregateRating': aggregateRating,
            if (audience != null) 'audience': audience,
            if (award != null) 'award': award,
            if (copyrightHolder != null)
              'copyrightHolder': copyrightHolder,
            if (copyrightYear != null) 'copyrightYear': copyrightYear,
            if (creator != null) 'creator': creator,
            if (discussionUrl != null) 'discussionUrl': discussionUrl,
            if (editor != null) 'editor': editor,
            if (encoding != null) 'encoding': encoding,
            if (funder != null) 'funder': funder,
            if (genre != null) 'genre': genre,
            if (hasPart != null) 'hasPart': hasPart,
            if (headline != null) 'headline': headline,
            if (interactionStatistic != null)
              'interactionStatistic': interactionStatistic,
            if (isAccessibleForFree != null)
              'isAccessibleForFree': isAccessibleForFree,
            if (isBasedOn != null) 'isBasedOn': isBasedOn,
            if (isFamilyFriendly != null)
              'isFamilyFriendly': isFamilyFriendly,
            if (isPartOf != null) 'isPartOf': isPartOf,
            if (issn != null) 'issn': issn,
            if (license != null) 'license': license,
            if (mainEntity != null) 'mainEntity': mainEntity,
            if (mainEntityOfPage != null)
              'mainEntityOfPage': mainEntityOfPage,
            if (mentions != null) 'mentions': mentions,
            if (offers != null) 'offers': offers,
            if (position != null) 'position': position,
            if (potentialAction != null)
              'potentialAction': potentialAction,
            if (provider != null) 'provider': provider,
            if (publication != null) 'publication': publication,
            if (review != null) 'review': review,
            if (schemaVersion != null) 'schemaVersion': schemaVersion,
            if (sourceOrganization != null)
              'sourceOrganization': sourceOrganization,
            if (sponsor != null) 'sponsor': sponsor,
            if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
            if (timeRequired != null) 'timeRequired': timeRequired,
            if (translator != null) 'translator': translator,
            if (typicalAgeRange != null)
              'typicalAgeRange': typicalAgeRange,
            if (version != null) 'version': version,
            if (video != null) 'video': video,
            if (workExample != null) 'workExample': workExample,
            if (additionalProperties != null) ...additionalProperties,
          },
        );

  /// Factory constructor for personal blogs
  factory BlogSchema.personal({
    required String name,
    required String url,
    required Map<String, dynamic> author,
    String? description,
    List<Map<String, dynamic>>? blogPost,
    List<String>? keywords,
    String? image,
  }) {
    return BlogSchema.custom(
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
    required Map<String, dynamic> publisher,
    String? description,
    List<Map<String, dynamic>>? blogPost,
    List<String>? keywords,
    String? image,
    Map<String, dynamic>? sponsor,
  }) {
    return BlogSchema.custom(
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
      if (datePublished != null) 'datePublished': datePublished,
      if (author != null) 'author': author,
      if (description != null) 'description': description,
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
      if (bestRating != null) 'bestRating': bestRating,
      if (worstRating != null) 'worstRating': worstRating,
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
      if (datePublished != null) 'datePublished': datePublished,
    };
  }
}

// Backward compatibility alias
typedef SeoBlogSchema = BlogSchema;
