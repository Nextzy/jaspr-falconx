import 'package:jaspr_falkit/lib.dart';
import 'package:jaspr_falkit/components/seo/schema/base_schema.dart';

/// Data class for SoftwareApplication schema
class SoftwareApplicationSchemaData {
  const SoftwareApplicationSchemaData({
    this.name,
    this.url,
    this.description,
    this.applicationCategory,
    this.applicationSubCategory,
    this.operatingSystem,
    this.softwareVersion,
    this.offers,
    this.aggregateRating,
    this.screenshot,
    this.featureList,
    this.datePublished,
    this.dateModified,
    this.downloadUrl,
    this.installUrl,
    this.releaseNotes,
    this.author,
    this.publisher,
    this.license,
    this.availableLanguage,
    this.softwareRequirements,
    this.fileSize,
    this.review,
    this.applicationSuite,
    this.countriesNotSupported,
    this.countriesSupported,
    this.device,
    this.inLanguage,
    this.memoryRequirements,
    this.permissions,
    this.processorRequirements,
    this.softwareAddOn,
    this.softwareHelp,
    this.storageRequirements,
    this.supportingData,
    this.about,
    this.alternateName,
    this.award,
    this.citation,
    this.comment,
    this.copyrightHolder,
    this.copyrightYear,
    this.creator,
    this.discussionUrl,
    this.editor,
    this.funder,
    this.genre,
    this.hasPart,
    this.headline,
    this.image,
    this.interactionStatistic,
    this.isAccessibleForFree,
    this.isBasedOn,
    this.isFamilyFriendly,
    this.isPartOf,
    this.keywords,
    this.mainEntity,
    this.maintainer,
    this.mentions,
    this.position,
    this.potentialAction,
    this.provider,
    this.publication,
    this.sameAs,
    this.schemaVersion,
    this.sourceOrganization,
    this.sponsor,
    this.thumbnailUrl,
    this.timeRequired,
    this.version,
    this.video,
    this.additionalProperties,
  });

  final String? name;
  final String? url;
  final String? description;
  final String? applicationCategory;
  final String? applicationSubCategory;
  final List<String>? operatingSystem;
  final String? softwareVersion;
  final Map<String, dynamic>? offers;
  final Map<String, dynamic>? aggregateRating;
  final String? screenshot;
  final List<String>? featureList;
  final DateTime? datePublished;
  final DateTime? dateModified;
  final String? downloadUrl;
  final String? installUrl;
  final String? releaseNotes;
  final Map<String, String>? author;
  final Map<String, String>? publisher;
  final String? license;
  final List<String>? availableLanguage;
  final Map<String, String>? softwareRequirements;
  final String? fileSize;
  final List<Map<String, dynamic>>? review;
  final String? applicationSuite;
  final String? countriesNotSupported;
  final String? countriesSupported;
  final String? device;
  final String? inLanguage;
  final String? memoryRequirements;
  final String? permissions;
  final String? processorRequirements;
  final Map<String, dynamic>? softwareAddOn;
  final Map<String, dynamic>? softwareHelp;
  final String? storageRequirements;
  final Map<String, dynamic>? supportingData;
  final Map<String, dynamic>? about;
  final String? alternateName;
  final String? award;
  final dynamic citation;
  final Map<String, dynamic>? comment;
  final String? copyrightHolder;
  final String? copyrightYear;
  final Map<String, dynamic>? creator;
  final String? discussionUrl;
  final Map<String, dynamic>? editor;
  final Map<String, dynamic>? funder;
  final String? genre;
  final Map<String, dynamic>? hasPart;
  final String? headline;
  final String? image;
  final Map<String, dynamic>? interactionStatistic;
  final bool? isAccessibleForFree;
  final Map<String, dynamic>? isBasedOn;
  final bool? isFamilyFriendly;
  final Map<String, dynamic>? isPartOf;
  final List<String>? keywords;
  final Map<String, dynamic>? mainEntity;
  final Map<String, dynamic>? maintainer;
  final Map<String, dynamic>? mentions;
  final dynamic position;
  final Map<String, dynamic>? potentialAction;
  final Map<String, dynamic>? provider;
  final Map<String, dynamic>? publication;
  final List<String>? sameAs;
  final String? schemaVersion;
  final Map<String, dynamic>? sourceOrganization;
  final Map<String, dynamic>? sponsor;
  final String? thumbnailUrl;
  final String? timeRequired;
  final String? version;
  final Map<String, dynamic>? video;
  final Map<String, dynamic>? additionalProperties;
}

/// SoftwareApplication schema component with full schema.org support
class SoftwareApplicationSchema extends Schema {
  /// Constructor with data class
  SoftwareApplicationSchema(SoftwareApplicationSchemaData data)
      : this.custom(
          name: data.name!,
          url: data.url,
          description: data.description,
          applicationCategory: data.applicationCategory,
          applicationSubCategory: data.applicationSubCategory,
          operatingSystem: data.operatingSystem,
          softwareVersion: data.softwareVersion,
          offers: data.offers,
          aggregateRating: data.aggregateRating,
          screenshot: data.screenshot,
          featureList: data.featureList,
          datePublished: data.datePublished?.toIso8601String(),
          dateModified: data.dateModified?.toIso8601String(),
          downloadUrl: data.downloadUrl,
          installUrl: data.installUrl,
          releaseNotes: data.releaseNotes,
          author: data.author,
          publisher: data.publisher,
          license: data.license,
          availableLanguage: data.availableLanguage,
          softwareRequirements: data.softwareRequirements,
          fileSize: data.fileSize,
          review: data.review,
          applicationSuite: data.applicationSuite,
          countriesNotSupported: data.countriesNotSupported,
          countriesSupported: data.countriesSupported,
          device: data.device,
          inLanguage: data.inLanguage,
          memoryRequirements: data.memoryRequirements,
          permissions: data.permissions,
          processorRequirements: data.processorRequirements,
          softwareAddOn: data.softwareAddOn,
          softwareHelp: data.softwareHelp,
          storageRequirements: data.storageRequirements,
          supportingData: data.supportingData,
          about: data.about,
          alternateName: data.alternateName,
          award: data.award,
          citation: data.citation,
          comment: data.comment,
          copyrightHolder: data.copyrightHolder,
          copyrightYear: data.copyrightYear,
          creator: data.creator,
          discussionUrl: data.discussionUrl,
          editor: data.editor,
          funder: data.funder,
          genre: data.genre,
          hasPart: data.hasPart,
          headline: data.headline,
          image: data.image,
          interactionStatistic: data.interactionStatistic,
          isAccessibleForFree: data.isAccessibleForFree,
          isBasedOn: data.isBasedOn,
          isFamilyFriendly: data.isFamilyFriendly,
          isPartOf: data.isPartOf,
          keywords: data.keywords,
          mainEntity: data.mainEntity,
          maintainer: data.maintainer,
          mentions: data.mentions,
          position: data.position,
          potentialAction: data.potentialAction,
          provider: data.provider,
          publication: data.publication,
          sameAs: data.sameAs,
          schemaVersion: data.schemaVersion,
          sourceOrganization: data.sourceOrganization,
          sponsor: data.sponsor,
          thumbnailUrl: data.thumbnailUrl,
          timeRequired: data.timeRequired,
          version: data.version,
          video: data.video,
          additionalProperties: data.additionalProperties,
        );

  /// Custom constructor with individual parameters
  SoftwareApplicationSchema.custom({
    required String name,
    String? url,
    String? description,
    String? applicationCategory,
    String? applicationSubCategory,
    List<String>? operatingSystem,
    String? softwareVersion,
    Map<String, dynamic>? offers,
    Map<String, dynamic>? aggregateRating,
    String? screenshot,
    List<String>? featureList,
    String? datePublished,
    String? dateModified,
    String? downloadUrl,
    String? installUrl,
    String? releaseNotes,
    Map<String, String>? author,
    Map<String, String>? publisher,
    String? license,
    List<String>? availableLanguage,
    Map<String, String>? softwareRequirements,
    String? fileSize,
    List<Map<String, dynamic>>? review,
    String? applicationSuite,
    String? countriesNotSupported,
    String? countriesSupported,
    String? device,
    String? inLanguage,
    String? memoryRequirements,
    String? permissions,
    String? processorRequirements,
    Map<String, dynamic>? softwareAddOn,
    Map<String, dynamic>? softwareHelp,
    String? storageRequirements,
    Map<String, dynamic>? supportingData,
    Map<String, dynamic>? about,
    String? alternateName,
    String? award,
    dynamic citation,
    Map<String, dynamic>? comment,
    String? copyrightHolder,
    String? copyrightYear,
    Map<String, dynamic>? creator,
    String? discussionUrl,
    Map<String, dynamic>? editor,
    Map<String, dynamic>? funder,
    String? genre,
    Map<String, dynamic>? hasPart,
    String? headline,
    String? image,
    Map<String, dynamic>? interactionStatistic,
    bool? isAccessibleForFree,
    Map<String, dynamic>? isBasedOn,
    bool? isFamilyFriendly,
    Map<String, dynamic>? isPartOf,
    List<String>? keywords,
    Map<String, dynamic>? mainEntity,
    Map<String, dynamic>? maintainer,
    Map<String, dynamic>? mentions,
    dynamic position,
    Map<String, dynamic>? potentialAction,
    Map<String, dynamic>? provider,
    Map<String, dynamic>? publication,
    List<String>? sameAs,
    String? schemaVersion,
    Map<String, dynamic>? sourceOrganization,
    Map<String, dynamic>? sponsor,
    String? thumbnailUrl,
    String? timeRequired,
    String? version,
    Map<String, dynamic>? video,
    Map<String, dynamic>? additionalProperties,
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'SoftwareApplication',
                 'name': name,
                 if (url != null) 'url': url,
                 if (description != null) 'description': description,
                 if (applicationCategory != null)
                   'applicationCategory': applicationCategory,
                 if (applicationSubCategory != null)
                   'applicationSubCategory': applicationSubCategory,
                 if (operatingSystem != null && operatingSystem.isNotEmpty)
                   'operatingSystem': operatingSystem,
                 if (softwareVersion != null)
                   'softwareVersion': softwareVersion,
                 if (offers != null)
                   'offers': {
                     '@type': 'Offer',
                     ...offers,
                   },
                 if (aggregateRating != null)
                   'aggregateRating': {
                     '@type': 'AggregateRating',
                     ...aggregateRating,
                   },
                 if (screenshot != null)
                   'screenshot': {
                     '@type': 'ImageObject',
                     'url': screenshot,
                   },
                 if (featureList != null && featureList.isNotEmpty)
                   'featureList': featureList,
                 if (datePublished != null) 'datePublished': datePublished,
                 if (dateModified != null) 'dateModified': dateModified,
                 if (downloadUrl != null) 'downloadUrl': downloadUrl,
                 if (installUrl != null) 'installUrl': installUrl,
                 if (releaseNotes != null) 'releaseNotes': releaseNotes,
                 if (author != null)
                   'author': {
                     '@type': author['type'] ?? 'Person',
                     'name': author['name'],
                     if (author['url'] != null) 'url': author['url'],
                   },
                 if (publisher != null)
                   'publisher': {
                     '@type': publisher['type'] ?? 'Organization',
                     'name': publisher['name'],
                     if (publisher['url'] != null) 'url': publisher['url'],
                   },
                 if (license != null) 'license': license,
                 if (availableLanguage != null && availableLanguage.isNotEmpty)
                   'availableLanguage': availableLanguage,
                 if (softwareRequirements != null)
                   'softwareRequirements': softwareRequirements,
                 if (fileSize != null) 'fileSize': fileSize,
                 if (review != null && review.isNotEmpty)
                   'review': review
                       .map(
                         (r) => {
                           '@type': 'Review',
                           ...r,
                         },
                       )
                       .toList(),
                 if (applicationSuite != null) 'applicationSuite': applicationSuite,
                 if (countriesNotSupported != null) 'countriesNotSupported': countriesNotSupported,
                 if (countriesSupported != null) 'countriesSupported': countriesSupported,
                 if (device != null) 'device': device,
                 if (inLanguage != null) 'inLanguage': inLanguage,
                 if (memoryRequirements != null) 'memoryRequirements': memoryRequirements,
                 if (permissions != null) 'permissions': permissions,
                 if (processorRequirements != null) 'processorRequirements': processorRequirements,
                 if (softwareAddOn != null) 'softwareAddOn': softwareAddOn,
                 if (softwareHelp != null) 'softwareHelp': softwareHelp,
                 if (storageRequirements != null) 'storageRequirements': storageRequirements,
                 if (supportingData != null) 'supportingData': supportingData,
                 if (about != null) 'about': about,
                 if (alternateName != null) 'alternateName': alternateName,
                 if (award != null) 'award': award,
                 if (citation != null) 'citation': citation,
                 if (comment != null) 'comment': comment,
                 if (copyrightHolder != null) 'copyrightHolder': copyrightHolder,
                 if (copyrightYear != null) 'copyrightYear': copyrightYear,
                 if (creator != null) 'creator': creator,
                 if (discussionUrl != null) 'discussionUrl': discussionUrl,
                 if (editor != null) 'editor': editor,
                 if (funder != null) 'funder': funder,
                 if (genre != null) 'genre': genre,
                 if (hasPart != null) 'hasPart': hasPart,
                 if (headline != null) 'headline': headline,
                 if (image != null)
                   'image': {
                     '@type': 'ImageObject',
                     'url': image,
                   },
                 if (interactionStatistic != null) 'interactionStatistic': interactionStatistic,
                 if (isAccessibleForFree != null) 'isAccessibleForFree': isAccessibleForFree,
                 if (isBasedOn != null) 'isBasedOn': isBasedOn,
                 if (isFamilyFriendly != null) 'isFamilyFriendly': isFamilyFriendly,
                 if (isPartOf != null) 'isPartOf': isPartOf,
                 if (keywords != null && keywords.isNotEmpty) 'keywords': keywords.join(', '),
                 if (mainEntity != null) 'mainEntity': mainEntity,
                 if (maintainer != null) 'maintainer': maintainer,
                 if (mentions != null) 'mentions': mentions,
                 if (position != null) 'position': position,
                 if (potentialAction != null) 'potentialAction': potentialAction,
                 if (provider != null) 'provider': provider,
                 if (publication != null) 'publication': publication,
                 if (sameAs != null && sameAs.isNotEmpty) 'sameAs': sameAs,
                 if (schemaVersion != null) 'schemaVersion': schemaVersion,
                 if (sourceOrganization != null) 'sourceOrganization': sourceOrganization,
                 if (sponsor != null) 'sponsor': sponsor,
                 if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
                 if (timeRequired != null) 'timeRequired': timeRequired,
                 if (version != null) 'version': version,
                 if (video != null) 'video': video,
                 if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Factory constructor for mobile applications
  factory SoftwareApplicationSchema.mobileApp({
    required String name,
    required List<String> operatingSystem,
    String? url,
    String? description,
    String? applicationCategory,
    String? softwareVersion,
    Map<String, dynamic>? offers,
    Map<String, dynamic>? aggregateRating,
    String? screenshot,
    String? downloadUrl,
    String? fileSize,
    Map<String, String>? author,
    Map<String, String>? publisher,
  }) {
    return SoftwareApplicationSchema.custom(
      name: name,
      operatingSystem: operatingSystem,
      url: url,
      description: description,
      applicationCategory: applicationCategory,
      softwareVersion: softwareVersion,
      offers: offers,
      aggregateRating: aggregateRating,
      screenshot: screenshot,
      downloadUrl: downloadUrl,
      fileSize: fileSize,
      author: author,
      publisher: publisher,
    );
  }

  /// Factory constructor for desktop applications
  factory SoftwareApplicationSchema.desktopApp({
    required String name,
    required List<String> operatingSystem,
    String? url,
    String? description,
    String? applicationCategory,
    String? softwareVersion,
    String? downloadUrl,
    String? installUrl,
    String? fileSize,
    Map<String, String>? softwareRequirements,
    String? memoryRequirements,
    String? processorRequirements,
    String? storageRequirements,
    Map<String, String>? author,
    Map<String, String>? publisher,
    String? license,
  }) {
    return SoftwareApplicationSchema.custom(
      name: name,
      operatingSystem: operatingSystem,
      url: url,
      description: description,
      applicationCategory: applicationCategory,
      softwareVersion: softwareVersion,
      downloadUrl: downloadUrl,
      installUrl: installUrl,
      fileSize: fileSize,
      softwareRequirements: softwareRequirements,
      memoryRequirements: memoryRequirements,
      processorRequirements: processorRequirements,
      storageRequirements: storageRequirements,
      author: author,
      publisher: publisher,
      license: license,
    );
  }

  /// Helper method to create offer
  static Map<String, dynamic> createOffer({
    required String price,
    required String priceCurrency,
    String? availability,
    String? priceValidUntil,
    Map<String, dynamic>? seller,
  }) {
    return {
      'price': price,
      'priceCurrency': priceCurrency,
      if (availability != null) 'availability': availability,
      if (priceValidUntil != null) 'priceValidUntil': priceValidUntil,
      if (seller != null) 'seller': seller,
    };
  }

  /// Helper method to create aggregate rating
  static Map<String, dynamic> createAggregateRating({
    required double ratingValue,
    required int ratingCount,
    double? bestRating,
    double? worstRating,
  }) {
    return {
      'ratingValue': ratingValue,
      'ratingCount': ratingCount,
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

/// Data class for WebApplication schema
class WebApplicationSchemaData {
  const WebApplicationSchemaData({
    this.name,
    this.url,
    this.description,
    this.applicationCategory,
    this.browserRequirements,
    this.permissions,
    this.softwareVersion,
    this.offers,
    this.aggregateRating,
    this.sameAs,
    this.screenshot,
    this.featureList,
    this.datePublished,
    this.dateModified,
    this.author,
    this.publisher,
    this.availableLanguage,
    this.about,
    this.alternateName,
    this.applicationSubCategory,
    this.award,
    this.comment,
    this.copyrightHolder,
    this.copyrightYear,
    this.creator,
    this.discussionUrl,
    this.downloadUrl,
    this.editor,
    this.fileSize,
    this.funder,
    this.genre,
    this.hasPart,
    this.headline,
    this.image,
    this.inLanguage,
    this.installUrl,
    this.interactionStatistic,
    this.isAccessibleForFree,
    this.isBasedOn,
    this.isFamilyFriendly,
    this.isPartOf,
    this.keywords,
    this.license,
    this.mainEntity,
    this.maintainer,
    this.memoryRequirements,
    this.mentions,
    this.operatingSystem,
    this.position,
    this.potentialAction,
    this.processorRequirements,
    this.provider,
    this.publication,
    this.releaseNotes,
    this.review,
    this.schemaVersion,
    this.softwareAddOn,
    this.softwareHelp,
    this.softwareRequirements,
    this.sourceOrganization,
    this.sponsor,
    this.storageRequirements,
    this.supportingData,
    this.thumbnailUrl,
    this.timeRequired,
    this.version,
    this.video,
    this.additionalProperties,
  });

  final String? name;
  final String? url;
  final String? description;
  final String? applicationCategory;
  final List<String>? browserRequirements;
  final List<String>? permissions;
  final String? softwareVersion;
  final Map<String, dynamic>? offers;
  final Map<String, dynamic>? aggregateRating;
  final List<String>? sameAs;
  final String? screenshot;
  final List<String>? featureList;
  final DateTime? datePublished;
  final DateTime? dateModified;
  final Map<String, String>? author;
  final Map<String, String>? publisher;
  final List<String>? availableLanguage;
  final Map<String, dynamic>? about;
  final String? alternateName;
  final String? applicationSubCategory;
  final String? award;
  final Map<String, dynamic>? comment;
  final String? copyrightHolder;
  final String? copyrightYear;
  final Map<String, dynamic>? creator;
  final String? discussionUrl;
  final String? downloadUrl;
  final Map<String, dynamic>? editor;
  final String? fileSize;
  final Map<String, dynamic>? funder;
  final String? genre;
  final Map<String, dynamic>? hasPart;
  final String? headline;
  final String? image;
  final String? inLanguage;
  final String? installUrl;
  final Map<String, dynamic>? interactionStatistic;
  final bool? isAccessibleForFree;
  final Map<String, dynamic>? isBasedOn;
  final bool? isFamilyFriendly;
  final Map<String, dynamic>? isPartOf;
  final List<String>? keywords;
  final String? license;
  final Map<String, dynamic>? mainEntity;
  final Map<String, dynamic>? maintainer;
  final String? memoryRequirements;
  final Map<String, dynamic>? mentions;
  final List<String>? operatingSystem;
  final dynamic position;
  final Map<String, dynamic>? potentialAction;
  final String? processorRequirements;
  final Map<String, dynamic>? provider;
  final Map<String, dynamic>? publication;
  final String? releaseNotes;
  final List<Map<String, dynamic>>? review;
  final String? schemaVersion;
  final Map<String, dynamic>? softwareAddOn;
  final Map<String, dynamic>? softwareHelp;
  final Map<String, String>? softwareRequirements;
  final Map<String, dynamic>? sourceOrganization;
  final Map<String, dynamic>? sponsor;
  final String? storageRequirements;
  final Map<String, dynamic>? supportingData;
  final String? thumbnailUrl;
  final String? timeRequired;
  final String? version;
  final Map<String, dynamic>? video;
  final Map<String, dynamic>? additionalProperties;
}

// WebApplication extends SoftwareApplication for web-specific applications
class WebApplicationSchema extends Schema {
  /// Constructor with data class
  WebApplicationSchema(WebApplicationSchemaData data)
      : this.custom(
          name: data.name,
          url: data.url,
          description: data.description,
          applicationCategory: data.applicationCategory,
          browserRequirements: data.browserRequirements,
          permissions: data.permissions,
          softwareVersion: data.softwareVersion,
          offers: data.offers,
          aggregateRating: data.aggregateRating,
          sameAs: data.sameAs,
          screenshot: data.screenshot,
          featureList: data.featureList,
          datePublished: data.datePublished?.toIso8601String(),
          dateModified: data.dateModified?.toIso8601String(),
          author: data.author,
          publisher: data.publisher,
          availableLanguage: data.availableLanguage,
          additionalProperties: data.additionalProperties,
        );

  /// Custom constructor with individual parameters
  WebApplicationSchema.custom({
    String? name,
    String? url,
    String? description,
    String? applicationCategory,
    List<String>? browserRequirements,
    List<String>? permissions,
    String? softwareVersion,
    Map<String, dynamic>? offers,
    Map<String, dynamic>? aggregateRating,
    List<String>? sameAs,
    String? screenshot,
    List<String>? featureList,
    String? datePublished,
    String? dateModified,
    Map<String, String>? author,
    Map<String, String>? publisher,
    List<String>? availableLanguage,
    Map<String, dynamic>? additionalProperties,
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'WebApplication',
                 if (name != null) 'name': name,
                 if (url != null) 'url': url,
                 if (description != null) 'description': description,
                 if (sameAs != null && sameAs.isNotEmpty) 'sameAs': sameAs,
                 if (applicationCategory != null)
                   'applicationCategory': applicationCategory,
                 if (browserRequirements != null &&
                     browserRequirements.isNotEmpty)
                   'browserRequirements': browserRequirements.join(', '),
                 if (permissions != null && permissions.isNotEmpty)
                   'permissions': permissions.join(', '),
                 if (softwareVersion != null)
                   'softwareVersion': softwareVersion,
                 if (offers != null)
                   'offers': {
                     '@type': 'Offer',
                     ...offers,
                   },
                 if (aggregateRating != null)
                   'aggregateRating': {
                     '@type': 'AggregateRating',
                     ...aggregateRating,
                   },
                 if (screenshot != null)
                   'screenshot': {
                     '@type': 'ImageObject',
                     'url': screenshot,
                   },
                 if (featureList != null && featureList.isNotEmpty)
                   'featureList': featureList,
                 if (datePublished != null) 'datePublished': datePublished,
                 if (dateModified != null) 'dateModified': dateModified,
                 if (author != null)
                   'author': {
                     '@type': author['type'] ?? 'Person',
                     'name': author['name'],
                     if (author['url'] != null) 'url': author['url'],
                   },
                 if (publisher != null)
                   'publisher': {
                     '@type': publisher['type'] ?? 'Organization',
                     'name': publisher['name'],
                     if (publisher['url'] != null) 'url': publisher['url'],
                   },
                 if (availableLanguage != null && availableLanguage.isNotEmpty)
                   'availableLanguage': availableLanguage,
                 if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Factory constructor for SaaS applications
  factory WebApplicationSchema.saas({
    required String name,
    required String url,
    String? description,
    String? applicationCategory,
    Map<String, dynamic>? offers,
    Map<String, dynamic>? aggregateRating,
    List<String>? featureList,
    List<String>? browserRequirements,
    Map<String, String>? author,
    Map<String, String>? publisher,
  }) {
    return WebApplicationSchema.custom(
      name: name,
      url: url,
      description: description,
      applicationCategory: applicationCategory ?? 'BusinessApplication',
      offers: offers,
      aggregateRating: aggregateRating,
      featureList: featureList,
      browserRequirements: browserRequirements,
      author: author,
      publisher: publisher,
    );
  }

  /// Factory constructor for progressive web apps
  factory WebApplicationSchema.pwa({
    required String name,
    required String url,
    String? description,
    String? applicationCategory,
    List<String>? permissions,
    String? screenshot,
    List<String>? featureList,
    Map<String, String>? author,
    Map<String, String>? publisher,
  }) {
    return WebApplicationSchema.custom(
      name: name,
      url: url,
      description: description,
      applicationCategory: applicationCategory,
      permissions: permissions,
      screenshot: screenshot,
      featureList: featureList,
      author: author,
      publisher: publisher,
    );
  }
}

// Backward compatibility aliases
typedef SoftwareApplicationSchemaOrg = SoftwareApplicationSchema;
typedef WebApplicationSchemaOrg = WebApplicationSchema;
