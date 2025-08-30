import 'package:jaspr_falkit/lib.dart';
import 'package:jaspr_falkit/components/seo/schema/base_schema.dart';

/// Data class for Organization schema
class OrganizationSchemaData {
  const OrganizationSchemaData({
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
  });

  final String? name;
  final String? url;
  final String? logo;
  final String? description;
  final String? email;
  final String? telephone;
  final Map<String, String>? address;
  final List<String>? sameAs;
  final DateTime? foundingDate;
  final List<Map<String, String>>? founders;
  final String? legalName;
  final String? taxID;
  final String? vatID;
  final String? alternateName;
  final Map<String, dynamic>? brand;
  final Map<String, dynamic>? contactPoint;
  final Map<String, dynamic>? department;
  final DateTime? dissolutionDate;
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
  final Map<String, dynamic>? location;
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
}

/// Organization schema component with full schema.org support
class OrganizationSchema extends Schema {
  /// Constructor with data class
  OrganizationSchema(OrganizationSchemaData data)
      : this.custom(
          name: data.name,
          url: data.url,
          logo: data.logo,
          description: data.description,
          email: data.email,
          telephone: data.telephone,
          address: data.address,
          sameAs: data.sameAs,
          foundingDate: data.foundingDate?.toIso8601String(),
          founders: data.founders,
          legalName: data.legalName,
          taxID: data.taxID,
          vatID: data.vatID,
          alternateName: data.alternateName,
          brand: data.brand,
          contactPoint: data.contactPoint,
          department: data.department,
          dissolutionDate: data.dissolutionDate?.toIso8601String(),
          duns: data.duns,
          employee: data.employee,
          faxNumber: data.faxNumber,
          globalLocationNumber: data.globalLocationNumber,
          hasOfferCatalog: data.hasOfferCatalog,
          hasPOS: data.hasPOS,
          isicV4: data.isicV4,
          iso6523Code: data.iso6523Code,
          keywords: data.keywords,
          knowsAbout: data.knowsAbout,
          knowsLanguage: data.knowsLanguage,
          leiCode: data.leiCode,
          location: data.location,
          makesOffer: data.makesOffer,
          member: data.member,
          memberOf: data.memberOf,
          naics: data.naics,
          numberOfEmployees: data.numberOfEmployees,
          owns: data.owns,
          parentOrganization: data.parentOrganization,
          publishingPrinciples: data.publishingPrinciples,
          review: data.review,
          seeks: data.seeks,
          slogan: data.slogan,
          sponsor: data.sponsor,
          subOrganization: data.subOrganization,
          aggregateRating: data.aggregateRating,
          alumni: data.alumni,
          areaServed: data.areaServed,
          award: data.award,
          actionableFeedbackPolicy: data.actionableFeedbackPolicy,
          correctionsPolicy: data.correctionsPolicy,
          diversityPolicy: data.diversityPolicy,
          diversityStaffingReport: data.diversityStaffingReport,
          ethicsPolicy: data.ethicsPolicy,
          event: data.event,
          funder: data.funder,
          interactionStatistic: data.interactionStatistic,
          nonprofitStatus: data.nonprofitStatus,
          ownershipFundingInfo: data.ownershipFundingInfo,
          unnamedSourcesPolicy: data.unnamedSourcesPolicy,
          verificationFactCheckingPolicy: data.verificationFactCheckingPolicy,
          additionalProperties: data.additionalProperties,
        );

  /// Custom constructor with individual parameters
  OrganizationSchema.custom({
    String? name,
    String? url,
    String? logo,
    String? description,
    String? email,
    String? telephone,
    Map<String, String>? address,
    List<String>? sameAs,
    String? foundingDate,
    List<Map<String, String>>? founders,
    String? legalName,
    String? taxID,
    String? vatID,
    String? alternateName,
    Map<String, dynamic>? brand,
    Map<String, dynamic>? contactPoint,
    Map<String, dynamic>? department,
    String? dissolutionDate,
    String? duns,
    Map<String, dynamic>? employee,
    String? faxNumber,
    String? globalLocationNumber,
    Map<String, dynamic>? hasOfferCatalog,
    Map<String, dynamic>? hasPOS,
    String? isicV4,
    String? iso6523Code,
    List<String>? keywords,
    String? knowsAbout,
    String? knowsLanguage,
    String? leiCode,
    Map<String, dynamic>? location,
    Map<String, dynamic>? makesOffer,
    Map<String, dynamic>? member,
    Map<String, dynamic>? memberOf,
    String? naics,
    dynamic numberOfEmployees,
    Map<String, dynamic>? owns,
    Map<String, dynamic>? parentOrganization,
    String? publishingPrinciples,
    Map<String, dynamic>? review,
    Map<String, dynamic>? seeks,
    String? slogan,
    Map<String, dynamic>? sponsor,
    Map<String, dynamic>? subOrganization,
    Map<String, dynamic>? aggregateRating,
    Map<String, dynamic>? alumni,
    String? areaServed,
    String? award,
    String? actionableFeedbackPolicy,
    String? correctionsPolicy,
    String? diversityPolicy,
    String? diversityStaffingReport,
    String? ethicsPolicy,
    Map<String, dynamic>? event,
    Map<String, dynamic>? funder,
    Map<String, dynamic>? interactionStatistic,
    String? nonprofitStatus,
    String? ownershipFundingInfo,
    String? unnamedSourcesPolicy,
    String? verificationFactCheckingPolicy,
    Map<String, dynamic>? additionalProperties,
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'Organization',
           if (name != null) 'name': name,
           if (url != null) 'url': url,
           if (logo != null)
             'logo': {
               '@type': 'ImageObject',
               'url': logo,
             },
           if (description != null) 'description': description,
           if (email != null) 'email': email,
           if (telephone != null) 'telephone': telephone,
           if (address != null)
             'address': {
               '@type': 'PostalAddress',
               ...address,
             },
           if (sameAs != null && sameAs.isNotEmpty) 'sameAs': sameAs,
           if (foundingDate != null) 'foundingDate': foundingDate,
           if (founders != null && founders.isNotEmpty)
             'founder': founders
                 .map(
                   (founder) => {
                     '@type': 'Person',
                     ...founder,
                   },
                 )
                 .toList(),
           if (legalName != null) 'legalName': legalName,
           if (taxID != null) 'taxID': taxID,
           if (vatID != null) 'vatID': vatID,
           if (alternateName != null) 'alternateName': alternateName,
           if (brand != null) 'brand': brand,
           if (contactPoint != null) 'contactPoint': contactPoint,
           if (department != null) 'department': department,
           if (dissolutionDate != null) 'dissolutionDate': dissolutionDate,
           if (duns != null) 'duns': duns,
           if (employee != null) 'employee': employee,
           if (faxNumber != null) 'faxNumber': faxNumber,
           if (globalLocationNumber != null) 'globalLocationNumber': globalLocationNumber,
           if (hasOfferCatalog != null) 'hasOfferCatalog': hasOfferCatalog,
           if (hasPOS != null) 'hasPOS': hasPOS,
           if (isicV4 != null) 'isicV4': isicV4,
           if (iso6523Code != null) 'iso6523Code': iso6523Code,
           if (keywords != null && keywords.isNotEmpty) 'keywords': keywords.join(', '),
           if (knowsAbout != null) 'knowsAbout': knowsAbout,
           if (knowsLanguage != null) 'knowsLanguage': knowsLanguage,
           if (leiCode != null) 'leiCode': leiCode,
           if (location != null) 'location': location,
           if (makesOffer != null) 'makesOffer': makesOffer,
           if (member != null) 'member': member,
           if (memberOf != null) 'memberOf': memberOf,
           if (naics != null) 'naics': naics,
           if (numberOfEmployees != null) 'numberOfEmployees': numberOfEmployees,
           if (owns != null) 'owns': owns,
           if (parentOrganization != null) 'parentOrganization': parentOrganization,
           if (publishingPrinciples != null) 'publishingPrinciples': publishingPrinciples,
           if (review != null) 'review': review,
           if (seeks != null) 'seeks': seeks,
           if (slogan != null) 'slogan': slogan,
           if (sponsor != null) 'sponsor': sponsor,
           if (subOrganization != null) 'subOrganization': subOrganization,
           if (aggregateRating != null) 'aggregateRating': aggregateRating,
           if (alumni != null) 'alumni': alumni,
           if (areaServed != null) 'areaServed': areaServed,
           if (award != null) 'award': award,
           if (actionableFeedbackPolicy != null) 'actionableFeedbackPolicy': actionableFeedbackPolicy,
           if (correctionsPolicy != null) 'correctionsPolicy': correctionsPolicy,
           if (diversityPolicy != null) 'diversityPolicy': diversityPolicy,
           if (diversityStaffingReport != null) 'diversityStaffingReport': diversityStaffingReport,
           if (ethicsPolicy != null) 'ethicsPolicy': ethicsPolicy,
           if (event != null) 'event': event,
           if (funder != null) 'funder': funder,
           if (interactionStatistic != null) 'interactionStatistic': interactionStatistic,
           if (nonprofitStatus != null) 'nonprofitStatus': nonprofitStatus,
           if (ownershipFundingInfo != null) 'ownershipFundingInfo': ownershipFundingInfo,
           if (unnamedSourcesPolicy != null) 'unnamedSourcesPolicy': unnamedSourcesPolicy,
           if (verificationFactCheckingPolicy != null) 'verificationFactCheckingPolicy': verificationFactCheckingPolicy,
           if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Factory constructor for corporations
  factory OrganizationSchema.corporation({
    required String name,
    required String url,
    String? logo,
    String? legalName,
    Map<String, String>? address,
    List<String>? sameAs,
    String? telephone,
    String? email,
    String? taxID,
    String? vatID,
  }) {
    return OrganizationSchema.custom(
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
    String? logo,
    String? description,
    Map<String, String>? address,
    String? nonprofitStatus,
    String? foundingDate,
    Map<String, dynamic>? funder,
  }) {
    return OrganizationSchema.custom(
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
      if (availableLanguage != null && availableLanguage.isNotEmpty) 'availableLanguage': availableLanguage,
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
}

// Backward compatibility alias
typedef OrganizationSchemaOrg = OrganizationSchema;