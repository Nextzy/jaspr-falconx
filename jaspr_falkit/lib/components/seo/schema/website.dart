import 'package:jaspr_falkit/lib.dart';
import 'package:jaspr_falkit/components/seo/schema/base_schema.dart';

/// Data class for WebSite schema
class WebSiteSchemaData {
  const WebSiteSchemaData({
    this.name,
    this.url,
    this.description,
    this.alternateName,
    this.publisher,
    this.inLanguage,
    this.dateCreated,
    this.dateModified,
    this.datePublished,
    this.issn,
    this.sameAs,
    this.potentialAction,
    this.copyrightYear,
    this.copyrightHolder,
    this.license,
    this.accessibilityFeature,
    this.accessibilityHazard,
    this.accessibilityAPI,
    this.accessibilitySummary,
    this.keywords,
    this.hasPart,
    this.isPartOf,
    this.mainEntity,
    this.about,
    this.accountablePerson,
    this.aggregateRating,
    this.audience,
    this.award,
    this.author,
    this.citation,
    this.comment,
    this.contributor,
    this.creator,
    this.discussionUrl,
    this.editor,
    this.encoding,
    this.funder,
    this.genre,
    this.headline,
    this.image,
    this.interactionStatistic,
    this.isAccessibleForFree,
    this.isBasedOn,
    this.isFamilyFriendly,
    this.maintainer,
    this.mentions,
    this.offers,
    this.position,
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
  final String? url;
  final String? description;
  final String? alternateName;
  final Map<String, String>? publisher;
  final String? inLanguage;
  final DateTime? dateCreated;
  final DateTime? dateModified;
  final DateTime? datePublished;
  final String? issn;
  final List<String>? sameAs;
  final Map<String, dynamic>? potentialAction;
  final String? copyrightYear;
  final String? copyrightHolder;
  final String? license;
  final List<String>? accessibilityFeature;
  final List<String>? accessibilityHazard;
  final String? accessibilityAPI;
  final String? accessibilitySummary;
  final List<String>? keywords;
  final Map<String, dynamic>? hasPart;
  final Map<String, dynamic>? isPartOf;
  final Map<String, dynamic>? mainEntity;
  final Map<String, dynamic>? about;
  final Map<String, dynamic>? accountablePerson;
  final Map<String, dynamic>? aggregateRating;
  final Map<String, dynamic>? audience;
  final String? award;
  final Map<String, dynamic>? author;
  final dynamic citation;
  final Map<String, dynamic>? comment;
  final Map<String, dynamic>? contributor;
  final Map<String, dynamic>? creator;
  final String? discussionUrl;
  final Map<String, dynamic>? editor;
  final Map<String, dynamic>? encoding;
  final Map<String, dynamic>? funder;
  final String? genre;
  final String? headline;
  final String? image;
  final Map<String, dynamic>? interactionStatistic;
  final bool? isAccessibleForFree;
  final Map<String, dynamic>? isBasedOn;
  final bool? isFamilyFriendly;
  final Map<String, dynamic>? maintainer;
  final Map<String, dynamic>? mentions;
  final Map<String, dynamic>? offers;
  final dynamic position;
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

/// WebSite schema for representing entire websites
class WebSiteSchema extends Schema {
  /// Constructor with data class
  WebSiteSchema(WebSiteSchemaData data)
      : this.custom(
          name: data.name,
          url: data.url,
          description: data.description,
          alternateName: data.alternateName,
          publisher: data.publisher,
          inLanguage: data.inLanguage,
          dateCreated: data.dateCreated?.toIso8601String(),
          dateModified: data.dateModified?.toIso8601String(),
          datePublished: data.datePublished?.toIso8601String(),
          issn: data.issn,
          sameAs: data.sameAs,
          potentialAction: data.potentialAction,
          copyrightYear: data.copyrightYear,
          copyrightHolder: data.copyrightHolder,
          license: data.license,
          accessibilityFeature: data.accessibilityFeature,
          accessibilityHazard: data.accessibilityHazard,
          accessibilityAPI: data.accessibilityAPI,
          accessibilitySummary: data.accessibilitySummary,
          keywords: data.keywords,
          hasPart: data.hasPart,
          isPartOf: data.isPartOf,
          mainEntity: data.mainEntity,
          about: data.about,
          accountablePerson: data.accountablePerson,
          aggregateRating: data.aggregateRating,
          audience: data.audience,
          award: data.award,
          author: data.author,
          citation: data.citation,
          comment: data.comment,
          contributor: data.contributor,
          creator: data.creator,
          discussionUrl: data.discussionUrl,
          editor: data.editor,
          encoding: data.encoding,
          funder: data.funder,
          genre: data.genre,
          headline: data.headline,
          image: data.image,
          interactionStatistic: data.interactionStatistic,
          isAccessibleForFree: data.isAccessibleForFree,
          isBasedOn: data.isBasedOn,
          isFamilyFriendly: data.isFamilyFriendly,
          maintainer: data.maintainer,
          mentions: data.mentions,
          offers: data.offers,
          position: data.position,
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
  WebSiteSchema.custom({
    String? name,
    String? url,
    String? description,
    String? alternateName,
    Map<String, String>? publisher,
    String? inLanguage,
    String? dateCreated,
    String? dateModified,
    String? datePublished,
    String? issn,
    List<String>? sameAs,
    Map<String, dynamic>? potentialAction,
    String? copyrightYear,
    String? copyrightHolder,
    String? license,
    List<String>? accessibilityFeature,
    List<String>? accessibilityHazard,
    String? accessibilityAPI,
    String? accessibilitySummary,
    List<String>? keywords,
    Map<String, dynamic>? hasPart,
    Map<String, dynamic>? isPartOf,
    Map<String, dynamic>? mainEntity,
    Map<String, dynamic>? about,
    Map<String, dynamic>? accountablePerson,
    Map<String, dynamic>? aggregateRating,
    Map<String, dynamic>? audience,
    String? award,
    Map<String, dynamic>? author,
    dynamic citation,
    Map<String, dynamic>? comment,
    Map<String, dynamic>? contributor,
    Map<String, dynamic>? creator,
    String? discussionUrl,
    Map<String, dynamic>? editor,
    Map<String, dynamic>? encoding,
    Map<String, dynamic>? funder,
    String? genre,
    String? headline,
    String? image,
    Map<String, dynamic>? interactionStatistic,
    bool? isAccessibleForFree,
    Map<String, dynamic>? isBasedOn,
    bool? isFamilyFriendly,
    Map<String, dynamic>? maintainer,
    Map<String, dynamic>? mentions,
    Map<String, dynamic>? offers,
    dynamic position,
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
           '@type': 'WebSite',
                 if (name != null) 'name': name,
                 if (url != null) 'url': url,
                 if (description != null) 'description': description,
                 if (alternateName != null) 'alternateName': alternateName,
                 if (publisher != null)
                   'publisher': {
                     '@type': 'Organization',
                     ...publisher,
                   },
                 if (inLanguage != null) 'inLanguage': inLanguage,
                 if (dateCreated != null) 'dateCreated': dateCreated,
                 if (dateModified != null) 'dateModified': dateModified,
                 if (datePublished != null) 'datePublished': datePublished,
                 if (issn != null) 'issn': issn,
                 if (sameAs != null && sameAs.isNotEmpty) 'sameAs': sameAs,
                 if (potentialAction != null) 'potentialAction': potentialAction,
                 if (copyrightYear != null) 'copyrightYear': copyrightYear,
                 if (copyrightHolder != null) 'copyrightHolder': copyrightHolder,
                 if (license != null) 'license': license,
                 if (accessibilityFeature != null && accessibilityFeature.isNotEmpty)
                   'accessibilityFeature': accessibilityFeature,
                 if (accessibilityHazard != null && accessibilityHazard.isNotEmpty)
                   'accessibilityHazard': accessibilityHazard,
                 if (accessibilityAPI != null) 'accessibilityAPI': accessibilityAPI,
                 if (accessibilitySummary != null) 'accessibilitySummary': accessibilitySummary,
                 if (keywords != null && keywords.isNotEmpty) 'keywords': keywords.join(', '),
                 if (hasPart != null) 'hasPart': hasPart,
                 if (isPartOf != null) 'isPartOf': isPartOf,
                 if (mainEntity != null) 'mainEntity': mainEntity,
                 if (about != null) 'about': about,
                 if (accountablePerson != null) 'accountablePerson': accountablePerson,
                 if (aggregateRating != null) 'aggregateRating': aggregateRating,
                 if (audience != null) 'audience': audience,
                 if (award != null) 'award': award,
                 if (author != null) 'author': author,
                 if (citation != null) 'citation': citation,
                 if (comment != null) 'comment': comment,
                 if (contributor != null) 'contributor': contributor,
                 if (creator != null) 'creator': creator,
                 if (discussionUrl != null) 'discussionUrl': discussionUrl,
                 if (editor != null) 'editor': editor,
                 if (encoding != null) 'encoding': encoding,
                 if (funder != null) 'funder': funder,
                 if (genre != null) 'genre': genre,
                 if (headline != null) 'headline': headline,
                 if (image != null)
                   'image': image is String
                       ? {'@type': 'ImageObject', 'url': image}
                       : image,
                 if (interactionStatistic != null) 'interactionStatistic': interactionStatistic,
                 if (isAccessibleForFree != null) 'isAccessibleForFree': isAccessibleForFree,
                 if (isBasedOn != null) 'isBasedOn': isBasedOn,
                 if (isFamilyFriendly != null) 'isFamilyFriendly': isFamilyFriendly,
                 if (maintainer != null) 'maintainer': maintainer,
                 if (mentions != null) 'mentions': mentions,
                 if (offers != null) 'offers': offers,
                 if (position != null) 'position': position,
                 if (provider != null) 'provider': provider,
                 if (publication != null) 'publication': publication,
                 if (review != null) 'review': review,
                 if (schemaVersion != null) 'schemaVersion': schemaVersion,
                 if (sourceOrganization != null) 'sourceOrganization': sourceOrganization,
                 if (sponsor != null) 'sponsor': sponsor,
                 if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
                 if (timeRequired != null) 'timeRequired': timeRequired,
                 if (translator != null) 'translator': translator,
                 if (typicalAgeRange != null) 'typicalAgeRange': typicalAgeRange,
                 if (version != null) 'version': version,
                 if (video != null) 'video': video,
                 if (workExample != null) 'workExample': workExample,
                 if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Creates a WebSite schema with search action for site search functionality
  factory WebSiteSchema.withSearch({
    required String name,
    required String url,
    required String searchUrlTemplate,
    String? description,
    String? inLanguage,
    Map<String, String>? publisher,
    List<String>? sameAs,
    Map<String, dynamic>? additionalProperties,
  }) {
    return WebSiteSchema.custom(
      name: name,
      url: url,
      description: description,
      inLanguage: inLanguage,
      publisher: publisher,
      sameAs: sameAs,
      potentialAction: {
        '@type': 'SearchAction',
        'target': {
          '@type': 'EntryPoint',
          'urlTemplate': searchUrlTemplate,
        },
        'query-input': 'required name=search_term_string',
      },
      additionalProperties: additionalProperties,
    );
  }

  /// Creates a basic website schema
  factory WebSiteSchema.basic({
    required String name,
    required String url,
    String? description,
    Map<String, String>? publisher,
    String? inLanguage,
  }) {
    return WebSiteSchema.custom(
      name: name,
      url: url,
      description: description,
      publisher: publisher,
      inLanguage: inLanguage,
    );
  }

  /// Creates a blog website schema
  factory WebSiteSchema.blog({
    required String name,
    required String url,
    String? description,
    Map<String, String>? publisher,
    List<String>? keywords,
    String? dateCreated,
    String? dateModified,
  }) {
    return WebSiteSchema.custom(
      name: name,
      url: url,
      description: description,
      publisher: publisher,
      keywords: keywords,
      dateCreated: dateCreated,
      dateModified: dateModified,
    );
  }

  /// Factory constructor for e-commerce websites
  factory WebSiteSchema.ecommerce({
    required String name,
    required String url,
    String? description,
    Map<String, String>? publisher,
    Map<String, dynamic>? offers,
    List<String>? sameAs,
    Map<String, dynamic>? aggregateRating,
  }) {
    return WebSiteSchema.custom(
      name: name,
      url: url,
      description: description,
      publisher: publisher,
      offers: offers,
      sameAs: sameAs,
      aggregateRating: aggregateRating,
    );
  }

  /// Factory constructor for educational websites
  factory WebSiteSchema.educational({
    required String name,
    required String url,
    String? description,
    Map<String, String>? publisher,
    Map<String, dynamic>? provider,
    Map<String, dynamic>? audience,
    bool? isAccessibleForFree,
    String? inLanguage,
  }) {
    return WebSiteSchema.custom(
      name: name,
      url: url,
      description: description,
      publisher: publisher,
      provider: provider,
      audience: audience,
      isAccessibleForFree: isAccessibleForFree,
      inLanguage: inLanguage,
    );
  }

  /// Helper method to create a search action for site search
  static Map<String, dynamic> createSearchAction({
    required String searchUrlTemplate,
    String inputName = 'search_term_string',
  }) {
    return {
      '@type': 'SearchAction',
      'target': {
        '@type': 'EntryPoint',
        'urlTemplate': searchUrlTemplate,
      },
      'query-input': 'required name=$inputName',
    };
  }

  /// Helper method to create a publisher organization
  static Map<String, dynamic> createPublisher({
    required String name,
    String? url,
    String? logo,
    String? description,
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
      if (description != null) 'description': description,
    }..removeWhere((key, value) => value == null);
  }

  /// Helper method to create breadcrumb navigation
  static Map<String, dynamic> createBreadcrumbList({
    required List<BreadcrumbItem> items,
  }) {
    return {
      '@type': 'BreadcrumbList',
      'itemListElement': items
          .asMap()
          .entries
          .map(
            (entry) => {
              '@type': 'ListItem',
              'position': entry.key + 1,
              'name': entry.value.name,
              if (entry.value.url != null)
                'item': {
                  '@id': entry.value.url,
                  'name': entry.value.name,
                },
            },
          )
          .toList(),
    };
  }

  /// Helper method to create accessibility information
  static Map<String, dynamic> createAccessibilityInfo({
    List<String>? features,
    List<String>? hazards,
    String? api,
    String? summary,
  }) {
    return {
      if (features != null && features.isNotEmpty) 'accessibilityFeature': features,
      if (hazards != null && hazards.isNotEmpty) 'accessibilityHazard': hazards,
      if (api != null) 'accessibilityAPI': api,
      if (summary != null) 'accessibilitySummary': summary,
    }..removeWhere((key, value) => value == null);
  }

  /// Helper method to create audience specification
  static Map<String, dynamic> createAudience({
    required String audienceType,
    String? geographicArea,
    String? suggestedMinAge,
    String? suggestedMaxAge,
    String? suggestedGender,
    List<String>? requiredGender,
    List<String>? requiredMinAge,
    List<String>? requiredMaxAge,
  }) {
    return {
      '@type': 'Audience',
      'audienceType': audienceType,
      if (geographicArea != null) 'geographicArea': geographicArea,
      if (suggestedMinAge != null) 'suggestedMinAge': suggestedMinAge,
      if (suggestedMaxAge != null) 'suggestedMaxAge': suggestedMaxAge,
      if (suggestedGender != null) 'suggestedGender': suggestedGender,
      if (requiredGender != null && requiredGender.isNotEmpty) 'requiredGender': requiredGender,
      if (requiredMinAge != null && requiredMinAge.isNotEmpty) 'requiredMinAge': requiredMinAge,
      if (requiredMaxAge != null && requiredMaxAge.isNotEmpty) 'requiredMaxAge': requiredMaxAge,
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
}

/// Helper class for breadcrumb items

// Backward compatibility alias
typedef WebsiteSchema = WebSiteSchema;
typedef WebsiteSchemaOrg = WebSiteSchema;