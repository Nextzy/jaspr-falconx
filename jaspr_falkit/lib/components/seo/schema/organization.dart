import 'package:jaspr_falkit/lib.dart';

/// Organization schema component with full schema.org support
class OrganizationSchema extends Schema {
  OrganizationSchema({
    this.name,
    this.url,
    this.logo,
    this.description,
    this.email,
    this.telephone,
    this.address,
    this.sameAs,
    this.foundingDate,
    this.founders,
    this.legalName,
    this.taxID,
    this.vatID,
    this.alternateName,
    this.brand,
    this.contactPoint,
    this.department,
    this.dissolutionDate,
    this.duns,
    this.employee,
    this.faxNumber,
    this.globalLocationNumber,
    this.hasOfferCatalog,
    this.hasPOS,
    this.isicV4,
    this.iso6523Code,
    this.keywords,
    this.knowsAbout,
    this.knowsLanguage,
    this.leiCode,
    this.location,
    this.makesOffer,
    this.member,
    this.memberOf,
    this.naics,
    this.numberOfEmployees,
    this.owns,
    this.parentOrganization,
    this.publishingPrinciples,
    this.review,
    this.seeks,
    this.slogan,
    this.sponsor,
    this.subOrganization,
    this.aggregateRating,
    this.alumni,
    this.areaServed,
    this.award,
    this.actionableFeedbackPolicy,
    this.correctionsPolicy,
    this.diversityPolicy,
    this.diversityStaffingReport,
    this.ethicsPolicy,
    this.event,
    this.funder,
    this.interactionStatistic,
    this.nonprofitStatus,
    this.ownershipFundingInfo,
    this.unnamedSourcesPolicy,
    this.verificationFactCheckingPolicy,
    this.additionalProperties,
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'Organization',
           if (name != null) 'name': name,
           if (url != null) 'url': url,
           if (logo != null) 'logo': logo.value,
           if (description != null) 'description': description,
           if (email != null) 'email': email,
           if (telephone != null) 'telephone': telephone,
           if (address != null) 'address': address.value,
           if (sameAs != null && sameAs.isNotEmpty) 'sameAs': sameAs,
           if (foundingDate != null) 'foundingDate': foundingDate,
           if (founders != null && founders.isNotEmpty)
             'founder': founders
                 .map((founder) => founder?.value ?? founder)
                 .toList(),
           if (legalName != null) 'legalName': legalName,
           if (taxID != null) 'taxID': taxID,
           if (vatID != null) 'vatID': vatID,
           if (alternateName != null) 'alternateName': alternateName,
           if (brand != null) 'brand': brand,
           if (contactPoint != null) 'contactPoint': contactPoint.value,
           if (department != null) 'department': department,
           if (dissolutionDate != null) 'dissolutionDate': dissolutionDate,
           if (duns != null) 'duns': duns,
           if (employee != null) 'employee': employee,
           if (faxNumber != null) 'faxNumber': faxNumber,
           if (globalLocationNumber != null)
             'globalLocationNumber': globalLocationNumber,
           if (hasOfferCatalog != null) 'hasOfferCatalog': hasOfferCatalog,
           if (hasPOS != null) 'hasPOS': hasPOS,
           if (isicV4 != null) 'isicV4': isicV4,
           if (iso6523Code != null) 'iso6523Code': iso6523Code,
           if (keywords != null && keywords.isNotEmpty)
             'keywords': keywords.join(', '),
           if (knowsAbout != null) 'knowsAbout': knowsAbout,
           if (knowsLanguage != null) 'knowsLanguage': knowsLanguage,
           if (leiCode != null) 'leiCode': leiCode,
           if (location != null) 'location': location.value,
           if (makesOffer != null) 'makesOffer': makesOffer,
           if (member != null) 'member': member,
           if (memberOf != null) 'memberOf': memberOf,
           if (naics != null) 'naics': naics,
           if (numberOfEmployees != null)
             'numberOfEmployees': numberOfEmployees,
           if (owns != null) 'owns': owns,
           if (parentOrganization != null)
             'parentOrganization': parentOrganization,
           if (publishingPrinciples != null)
             'publishingPrinciples': publishingPrinciples,
           if (review != null) 'review': review,
           if (seeks != null) 'seeks': seeks,
           if (slogan != null) 'slogan': slogan,
           if (sponsor != null) 'sponsor': sponsor,
           if (subOrganization != null) 'subOrganization': subOrganization,
           if (aggregateRating != null) 'aggregateRating': aggregateRating,
           if (alumni != null) 'alumni': alumni,
           if (areaServed != null) 'areaServed': areaServed,
           if (award != null) 'award': award,
           if (actionableFeedbackPolicy != null)
             'actionableFeedbackPolicy': actionableFeedbackPolicy,
           if (correctionsPolicy != null)
             'correctionsPolicy': correctionsPolicy,
           if (diversityPolicy != null) 'diversityPolicy': diversityPolicy,
           if (diversityStaffingReport != null)
             'diversityStaffingReport': diversityStaffingReport,
           if (ethicsPolicy != null) 'ethicsPolicy': ethicsPolicy,
           if (event != null) 'event': event,
           if (funder != null) 'funder': funder,
           if (interactionStatistic != null)
             'interactionStatistic': interactionStatistic,
           if (nonprofitStatus != null) 'nonprofitStatus': nonprofitStatus,
           if (ownershipFundingInfo != null)
             'ownershipFundingInfo': ownershipFundingInfo,
           if (unnamedSourcesPolicy != null)
             'unnamedSourcesPolicy': unnamedSourcesPolicy,
           if (verificationFactCheckingPolicy != null)
             'verificationFactCheckingPolicy': verificationFactCheckingPolicy,
           if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Factory constructor for corporations
  factory OrganizationSchema.corporation({
    required String name,
    required String url,
    SchemaDataType<ImageSchema>? logo,
    String? legalName,
    SchemaDataType<PostalAddressSchema>? address,
    List<String>? sameAs,
    String? telephone,
    String? email,
    String? taxID,
    String? vatID,
  }) {
    return OrganizationSchema(
      name: name,
      url: url,
      logo: logo,
      legalName: legalName,
      address: address,
      sameAs: sameAs,
      telephone: telephone,
      email: email,
      taxID: taxID,
      vatID: vatID,
    );
  }

  /// Factory constructor for non-profit organizations
  factory OrganizationSchema.nonProfit({
    required String name,
    required String url,
    SchemaDataType<ImageSchema>? logo,
    String? description,
    SchemaDataType<PostalAddressSchema>? address,
    String? nonprofitStatus,
    String? foundingDate,
    Map<String, dynamic>? funder,
  }) {
    return OrganizationSchema(
      name: name,
      url: url,
      logo: logo,
      description: description,
      address: address,
      nonprofitStatus: nonprofitStatus,
      foundingDate: foundingDate,
      funder: funder,
    );
  }

  final String? name;
  final String? url;
  final SchemaDataType<ImageSchema>? logo;
  final String? description;
  final String? email;
  final String? telephone;
  final SchemaDataType<PostalAddressSchema>? address;
  final List<String>? sameAs;
  final String? foundingDate;
  final List<SchemaDataType<PersonSchema>?>? founders;
  final String? legalName;
  final String? taxID;
  final String? vatID;
  final String? alternateName;
  final Map<String, dynamic>? brand;
  final SchemaDataType<ContactPointSchema>? contactPoint;
  final Map<String, dynamic>? department;
  final String? dissolutionDate;
  final String? duns;
  final Map<String, dynamic>? employee;
  final String? faxNumber;
  final String? globalLocationNumber;
  final Map<String, dynamic>? hasOfferCatalog;
  final Map<String, dynamic>? hasPOS;
  final String? isicV4;
  final String? iso6523Code;
  final List<String>? keywords;
  final String? knowsAbout;
  final String? knowsLanguage;
  final String? leiCode;
  final SchemaDataType<PlaceSchema>? location;
  final Map<String, dynamic>? makesOffer;
  final Map<String, dynamic>? member;
  final Map<String, dynamic>? memberOf;
  final String? naics;
  final dynamic numberOfEmployees;
  final Map<String, dynamic>? owns;
  final Map<String, dynamic>? parentOrganization;
  final String? publishingPrinciples;
  final Map<String, dynamic>? review;
  final Map<String, dynamic>? seeks;
  final String? slogan;
  final Map<String, dynamic>? sponsor;
  final Map<String, dynamic>? subOrganization;
  final Map<String, dynamic>? aggregateRating;
  final Map<String, dynamic>? alumni;
  final String? areaServed;
  final String? award;
  final String? actionableFeedbackPolicy;
  final String? correctionsPolicy;
  final String? diversityPolicy;
  final String? diversityStaffingReport;
  final String? ethicsPolicy;
  final Map<String, dynamic>? event;
  final Map<String, dynamic>? funder;
  final Map<String, dynamic>? interactionStatistic;
  final String? nonprofitStatus;
  final String? ownershipFundingInfo;
  final String? unnamedSourcesPolicy;
  final String? verificationFactCheckingPolicy;
  final Map<String, dynamic>? additionalProperties;

  /// Helper method to create contact point
  static Map<String, dynamic> createContactPoint({
    required String telephone,
    required String contactType,
    String? email,
    String? contactOption,
    List<String>? areaServed,
    List<String>? availableLanguage,
  }) {
    return {
      '@type': 'ContactPoint',
      'telephone': telephone,
      'contactType': contactType,
      if (email != null) 'email': email,
      if (contactOption != null) 'contactOption': contactOption,
      if (areaServed != null && areaServed.isNotEmpty) 'areaServed': areaServed,
      if (availableLanguage != null && availableLanguage.isNotEmpty)
        'availableLanguage': availableLanguage,
    };
  }

  /// Helper method to create address
  static Map<String, String> createAddress({
    required String streetAddress,
    required String addressLocality,
    required String addressRegion,
    required String postalCode,
    required String addressCountry,
  }) {
    return {
      'streetAddress': streetAddress,
      'addressLocality': addressLocality,
      'addressRegion': addressRegion,
      'postalCode': postalCode,
      'addressCountry': addressCountry,
    };
  }

  /// Helper method to create organization as a Map
  static Map<String, dynamic> toMap({
    required String name,
    String? url,
    String? logo,
  }) {
    return {
      '@type': 'Organization',
      'name': name,
      if (url != null) 'url': url,
      if (logo != null) 'logo': logo,
    };
  }
}

// Backward compatibility alias
typedef OrganizationSchemaOrg = OrganizationSchema;
typedef OrganizationSchemaData = OrganizationSchema;
