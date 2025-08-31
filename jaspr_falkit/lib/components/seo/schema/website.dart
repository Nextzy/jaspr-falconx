import 'package:jaspr_falkit/lib.dart';

/// WebSite schema for representing entire websites
class WebSiteSchema extends Schema {
  WebSiteSchema({
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
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'WebSite',
           if (name != null) 'name': name,
           if (url != null) 'url': url,
           if (description != null) 'description': description,
           if (alternateName != null) 'alternateName': alternateName,
           if (publisher != null) 'publisher': publisher.value,
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
           if (accessibilitySummary != null)
             'accessibilitySummary': accessibilitySummary,
           if (keywords != null && keywords.isNotEmpty)
             'keywords': keywords.join(', '),
           if (hasPart != null) 'hasPart': hasPart,
           if (isPartOf != null) 'isPartOf': isPartOf,
           if (mainEntity != null) 'mainEntity': mainEntity,
           if (about != null) 'about': about,
           if (accountablePerson != null)
             'accountablePerson': accountablePerson.value,
           if (aggregateRating != null) 'aggregateRating': aggregateRating,
           if (audience != null) 'audience': audience,
           if (award != null) 'award': award,
           if (author != null) 'author': author.value,
           if (citation != null) 'citation': citation.value,
           if (comment != null) 'comment': comment,
           if (contributor != null) 'contributor': contributor.value,
           if (creator != null) 'creator': creator.value,
           if (discussionUrl != null) 'discussionUrl': discussionUrl,
           if (editor != null) 'editor': editor.value,
           if (encoding != null) 'encoding': encoding,
           if (funder != null) 'funder': funder,
           if (genre != null) 'genre': genre,
           if (headline != null) 'headline': headline,
           if (image != null) 'image': image.value,
           if (interactionStatistic != null)
             'interactionStatistic': interactionStatistic,
           if (isAccessibleForFree != null)
             'isAccessibleForFree': isAccessibleForFree,
           if (isBasedOn != null) 'isBasedOn': isBasedOn,
           if (isFamilyFriendly != null) 'isFamilyFriendly': isFamilyFriendly,
           if (maintainer != null) 'maintainer': maintainer.value,
           if (mentions != null) 'mentions': mentions,
           if (offers != null) 'offers': offers,
           if (position != null) 'position': position.value,
           if (provider != null) 'provider': provider,
           if (publication != null) 'publication': publication,
           if (review != null) 'review': review,
           if (schemaVersion != null) 'schemaVersion': schemaVersion,
           if (sourceOrganization != null)
             'sourceOrganization': sourceOrganization,
           if (sponsor != null) 'sponsor': sponsor,
           if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
           if (timeRequired != null) 'timeRequired': timeRequired,
           if (translator != null) 'translator': translator.value,
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
    SchemaDataType<OrganizationSchema>? publisher,
    List<String>? sameAs,
    Map<String, dynamic>? additionalProperties,
  }) {
    return WebSiteSchema(
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
    SchemaDataType<OrganizationSchema>? publisher,
    String? inLanguage,
  }) {
    return WebSiteSchema(
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
    SchemaDataType<OrganizationSchema>? publisher,
    List<String>? keywords,
    String? dateCreated,
    String? dateModified,
  }) {
    return WebSiteSchema(
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
    SchemaDataType<OrganizationSchema>? publisher,
    Map<String, dynamic>? offers,
    List<String>? sameAs,
    Map<String, dynamic>? aggregateRating,
  }) {
    return WebSiteSchema(
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
    SchemaDataType<OrganizationSchema>? publisher,
    Map<String, dynamic>? provider,
    Map<String, dynamic>? audience,
    bool? isAccessibleForFree,
    String? inLanguage,
  }) {
    return WebSiteSchema(
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

  /// Class members with 'this.' syntax
  final String? name;
  final String? url;
  final String? description;
  final String? alternateName;
  final SchemaDataType<OrganizationSchema>? publisher;
  final String? inLanguage;
  final String? dateCreated;
  final String? dateModified;
  final String? datePublished;
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
  final SchemaDataType<PersonSchema>? accountablePerson;
  final Map<String, dynamic>? aggregateRating;
  final Map<String, dynamic>? audience;
  final String? award;
  final SchemaDataType<PersonSchema>? author;
  final SchemaDataType<Schema>? citation;
  final Map<String, dynamic>? comment;
  final SchemaDataType<PersonSchema>? contributor;
  final SchemaDataType<PersonSchema>? creator;
  final String? discussionUrl;
  final SchemaDataType<PersonSchema>? editor;
  final Map<String, dynamic>? encoding;
  final Map<String, dynamic>? funder;
  final String? genre;
  final String? headline;
  final SchemaDataType<ImageSchema>? image;
  final Map<String, dynamic>? interactionStatistic;
  final bool? isAccessibleForFree;
  final Map<String, dynamic>? isBasedOn;
  final bool? isFamilyFriendly;
  final SchemaDataType<PersonSchema>? maintainer;
  final Map<String, dynamic>? mentions;
  final Map<String, dynamic>? offers;
  final SchemaDataType<Schema>? position;
  final Map<String, dynamic>? provider;
  final Map<String, dynamic>? publication;
  final Map<String, dynamic>? review;
  final String? schemaVersion;
  final Map<String, dynamic>? sourceOrganization;
  final Map<String, dynamic>? sponsor;
  final String? thumbnailUrl;
  final String? timeRequired;
  final SchemaDataType<PersonSchema>? translator;
  final String? typicalAgeRange;
  final String? version;
  final Map<String, dynamic>? video;
  final Map<String, dynamic>? workExample;
  final Map<String, dynamic>? additionalProperties;

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
      if (features != null && features.isNotEmpty)
        'accessibilityFeature': features,
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
      if (requiredGender != null && requiredGender.isNotEmpty)
        'requiredGender': requiredGender,
      if (requiredMinAge != null && requiredMinAge.isNotEmpty)
        'requiredMinAge': requiredMinAge,
      if (requiredMaxAge != null && requiredMaxAge.isNotEmpty)
        'requiredMaxAge': requiredMaxAge,
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

// Backward compatibility aliases
typedef WebSiteSchemaData = WebSiteSchema;
typedef WebsiteSchema = WebSiteSchema;
typedef WebsiteSchemaOrg = WebSiteSchema;
