import 'package:jaspr_falkit/lib.dart';

/// SoftwareApplication schema component with full schema.org support
class SoftwareApplicationSchema extends Schema {
  SoftwareApplicationSchema({
    required this.name,
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
           if (softwareVersion != null) 'softwareVersion': softwareVersion,
           if (offers != null) 'offers': offers.value,
           if (aggregateRating != null)
             'aggregateRating': aggregateRating.value,
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
           if (author != null) 'author': author.value,
           if (publisher != null) 'publisher': publisher.value,
           if (license != null) 'license': license,
           if (availableLanguage != null && availableLanguage.isNotEmpty)
             'availableLanguage': availableLanguage,
           if (softwareRequirements != null)
             'softwareRequirements': softwareRequirements,
           if (fileSize != null) 'fileSize': fileSize,
           if (review != null) 'review': review.value,
           if (applicationSuite != null) 'applicationSuite': applicationSuite,
           if (countriesNotSupported != null)
             'countriesNotSupported': countriesNotSupported,
           if (countriesSupported != null)
             'countriesSupported': countriesSupported,
           if (device != null) 'device': device,
           if (inLanguage != null) 'inLanguage': inLanguage,
           if (memoryRequirements != null)
             'memoryRequirements': memoryRequirements,
           if (permissions != null) 'permissions': permissions,
           if (processorRequirements != null)
             'processorRequirements': processorRequirements,
           if (softwareAddOn != null) 'softwareAddOn': softwareAddOn.value,
           if (softwareHelp != null) 'softwareHelp': softwareHelp.value,
           if (storageRequirements != null)
             'storageRequirements': storageRequirements,
           if (supportingData != null) 'supportingData': supportingData.value,
           if (about != null) 'about': about.value,
           if (alternateName != null) 'alternateName': alternateName,
           if (award != null) 'award': award,
           if (citation != null) 'citation': citation.value,
           if (comment != null) 'comment': comment.value,
           if (copyrightHolder != null) 'copyrightHolder': copyrightHolder,
           if (copyrightYear != null) 'copyrightYear': copyrightYear,
           if (creator != null) 'creator': creator.value,
           if (discussionUrl != null) 'discussionUrl': discussionUrl,
           if (editor != null) 'editor': editor.value,
           if (funder != null) 'funder': funder.value,
           if (genre != null) 'genre': genre,
           if (hasPart != null) 'hasPart': hasPart.value,
           if (headline != null) 'headline': headline,
           if (image != null)
             'image': {
               '@type': 'ImageObject',
               'url': image,
             },
           if (interactionStatistic != null)
             'interactionStatistic': interactionStatistic.value,
           if (isAccessibleForFree != null)
             'isAccessibleForFree': isAccessibleForFree,
           if (isBasedOn != null) 'isBasedOn': isBasedOn.value,
           if (isFamilyFriendly != null) 'isFamilyFriendly': isFamilyFriendly,
           if (isPartOf != null) 'isPartOf': isPartOf.value,
           if (keywords != null && keywords.isNotEmpty)
             'keywords': keywords.join(', '),
           if (mainEntity != null) 'mainEntity': mainEntity.value,
           if (maintainer != null) 'maintainer': maintainer.value,
           if (mentions != null) 'mentions': mentions.value,
           if (position != null) 'position': position.value,
           if (potentialAction != null)
             'potentialAction': potentialAction.value,
           if (provider != null) 'provider': provider.value,
           if (publication != null) 'publication': publication.value,
           if (sameAs != null && sameAs.isNotEmpty) 'sameAs': sameAs,
           if (schemaVersion != null) 'schemaVersion': schemaVersion,
           if (sourceOrganization != null)
             'sourceOrganization': sourceOrganization.value,
           if (sponsor != null) 'sponsor': sponsor.value,
           if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
           if (timeRequired != null) 'timeRequired': timeRequired,
           if (version != null) 'version': version,
           if (video != null) 'video': video.value,
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
    SchemaDataType<Schema>? offers,
    SchemaDataType<Schema>? aggregateRating,
    String? screenshot,
    String? downloadUrl,
    String? fileSize,
    SchemaDataType<PersonSchema>? author,
    SchemaDataType<OrganizationSchema>? publisher,
  }) {
    return SoftwareApplicationSchema(
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
    SchemaDataType<Schema>? softwareRequirements,
    String? memoryRequirements,
    String? processorRequirements,
    String? storageRequirements,
    SchemaDataType<PersonSchema>? author,
    SchemaDataType<OrganizationSchema>? publisher,
    String? license,
  }) {
    return SoftwareApplicationSchema(
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

  final String name;
  final String? url;
  final String? description;
  final String? applicationCategory;
  final String? applicationSubCategory;
  final List<String>? operatingSystem;
  final String? softwareVersion;
  final SchemaDataType<Schema>? offers;
  final SchemaDataType<Schema>? aggregateRating;
  final String? screenshot;
  final List<String>? featureList;
  final String? datePublished;
  final String? dateModified;
  final String? downloadUrl;
  final String? installUrl;
  final String? releaseNotes;
  final SchemaDataType<PersonSchema>? author;
  final SchemaDataType<OrganizationSchema>? publisher;
  final String? license;
  final List<String>? availableLanguage;
  final SchemaDataType<Schema>? softwareRequirements;
  final String? fileSize;
  final SchemaDataType<Schema>? review;
  final String? applicationSuite;
  final String? countriesNotSupported;
  final String? countriesSupported;
  final String? device;
  final String? inLanguage;
  final String? memoryRequirements;
  final String? permissions;
  final String? processorRequirements;
  final SchemaDataType<Schema>? softwareAddOn;
  final SchemaDataType<Schema>? softwareHelp;
  final String? storageRequirements;
  final SchemaDataType<Schema>? supportingData;
  final SchemaDataType<Schema>? about;
  final String? alternateName;
  final String? award;
  final SchemaDataType<Schema>? citation;
  final SchemaDataType<Schema>? comment;
  final String? copyrightHolder;
  final String? copyrightYear;
  final SchemaDataType<PersonSchema>? creator;
  final String? discussionUrl;
  final SchemaDataType<PersonSchema>? editor;
  final SchemaDataType<OrganizationSchema>? funder;
  final String? genre;
  final SchemaDataType<Schema>? hasPart;
  final String? headline;
  final String? image;
  final SchemaDataType<Schema>? interactionStatistic;
  final bool? isAccessibleForFree;
  final SchemaDataType<Schema>? isBasedOn;
  final bool? isFamilyFriendly;
  final SchemaDataType<Schema>? isPartOf;
  final List<String>? keywords;
  final SchemaDataType<Schema>? mainEntity;
  final SchemaDataType<PersonSchema>? maintainer;
  final SchemaDataType<Schema>? mentions;
  final SchemaDataType<Schema>? position;
  final SchemaDataType<Schema>? potentialAction;
  final SchemaDataType<OrganizationSchema>? provider;
  final SchemaDataType<Schema>? publication;
  final List<String>? sameAs;
  final String? schemaVersion;
  final SchemaDataType<OrganizationSchema>? sourceOrganization;
  final SchemaDataType<OrganizationSchema>? sponsor;
  final String? thumbnailUrl;
  final String? timeRequired;
  final String? version;
  final SchemaDataType<Schema>? video;
  final Map<String, dynamic>? additionalProperties;

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

/// Backward compatibility typedef
typedef SoftwareApplicationSchemaData = SoftwareApplicationSchema;

/// WebApplication extends SoftwareApplication for web-specific applications
class WebApplicationSchema extends Schema {
  WebApplicationSchema({
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
    this.additionalProperties,
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
           if (browserRequirements != null && browserRequirements.isNotEmpty)
             'browserRequirements': browserRequirements.join(', '),
           if (permissions != null && permissions.isNotEmpty)
             'permissions': permissions.join(', '),
           if (softwareVersion != null) 'softwareVersion': softwareVersion,
           if (offers != null) 'offers': offers.value,
           if (aggregateRating != null)
             'aggregateRating': aggregateRating.value,
           if (screenshot != null)
             'screenshot': {
               '@type': 'ImageObject',
               'url': screenshot,
             },
           if (featureList != null && featureList.isNotEmpty)
             'featureList': featureList,
           if (datePublished != null) 'datePublished': datePublished,
           if (dateModified != null) 'dateModified': dateModified,
           if (author != null) 'author': author.value,
           if (publisher != null) 'publisher': publisher.value,
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
    dynamic offers,
    dynamic aggregateRating,
    List<String>? featureList,
    List<String>? browserRequirements,
    SchemaDataType<PersonSchema>? author,
    SchemaDataType<OrganizationSchema>? publisher,
  }) {
    return WebApplicationSchema(
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
    SchemaDataType<PersonSchema>? author,
    SchemaDataType<OrganizationSchema>? publisher,
  }) {
    return WebApplicationSchema(
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

  final String? name;
  final String? url;
  final String? description;
  final String? applicationCategory;
  final List<String>? browserRequirements;
  final List<String>? permissions;
  final String? softwareVersion;
  final dynamic offers;
  final dynamic aggregateRating;
  final List<String>? sameAs;
  final String? screenshot;
  final List<String>? featureList;
  final String? datePublished;
  final String? dateModified;
  final SchemaDataType<PersonSchema>? author;
  final SchemaDataType<OrganizationSchema>? publisher;
  final List<String>? availableLanguage;
  final Map<String, dynamic>? additionalProperties;
}
