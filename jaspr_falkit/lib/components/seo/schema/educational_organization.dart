import 'package:jaspr_falkit/lib.dart';

/// EducationalOrganization schema for schools, universities,
/// and educational institutions
class EducationalOrganizationSchema extends Schema {
  EducationalOrganizationSchema({
    required String name,
    String? url,
    String? logo,
    String? description,
    String? email,
    String? telephone,
    Map<String, dynamic>? address,
    List<String>? sameAs,
    String? foundingDate,
    List<Map<String, dynamic>>? alumni,
    String? legalName,
    String? accreditation,
    List<String>? educationalCredentialAwarded,
    List<Map<String, dynamic>>? hasOfferCatalog,
    Map<String, dynamic>? contactPoint,
    Map<String, dynamic>? areaServed,
    String? numberOfEmployees,
    Map<String, dynamic>? parentOrganization,
    List<Map<String, dynamic>>? subOrganization,
    Map<String, dynamic>? department,
    String? slogan,
    String? taxID,
    String? vatID,
    List<Map<String, dynamic>>? review,
    Map<String, dynamic>? aggregateRating,
    Map<String, dynamic>? additionalProperties,
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'EducationalOrganization',
           'name': name,
           if (url != null) 'url': url,
           if (logo != null)
             'logo': {
               '@type': 'ImageObject',
               'url': logo,
             },
           if (description != null) 'description': description,
           if (email != null) 'email': email,
           if (telephone != null) 'telephone': telephone,
           if (address != null) 'address': address,
           if (sameAs != null && sameAs.isNotEmpty) 'sameAs': sameAs,
           if (foundingDate != null) 'foundingDate': foundingDate,
           if (alumni != null && alumni.isNotEmpty) 'alumni': alumni,
           if (legalName != null) 'legalName': legalName,
           if (accreditation != null) 'accreditation': accreditation,
           if (educationalCredentialAwarded != null &&
               educationalCredentialAwarded.isNotEmpty)
             'educationalCredentialAwarded': educationalCredentialAwarded,
           if (hasOfferCatalog != null && hasOfferCatalog.isNotEmpty)
             'hasOfferCatalog': hasOfferCatalog,
           if (contactPoint != null) 'contactPoint': contactPoint,
           if (areaServed != null) 'areaServed': areaServed,
           if (numberOfEmployees != null)
             'numberOfEmployees': numberOfEmployees,
           if (parentOrganization != null)
             'parentOrganization': parentOrganization,
           if (subOrganization != null && subOrganization.isNotEmpty)
             'subOrganization': subOrganization,
           if (department != null) 'department': department,
           if (slogan != null) 'slogan': slogan,
           if (taxID != null) 'taxID': taxID,
           if (vatID != null) 'vatID': vatID,
           if (review != null && review.isNotEmpty) 'review': review,
           if (aggregateRating != null) 'aggregateRating': aggregateRating,
           if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Creates a basic educational organization schema
  factory EducationalOrganizationSchema.basic({
    required String name,
    required String url,
    String? description,
    String? logo,
    Map<String, dynamic>? address,
  }) {
    return EducationalOrganizationSchema(
      name: name,
      url: url,
      description: description,
      logo: logo,
      address: address,
    );
  }

  /// Creates a university schema
  factory EducationalOrganizationSchema.university({
    required String name,
    required String url,
    String? description,
    String? logo,
    Map<String, dynamic>? address,
    String? foundingDate,
    List<String>? educationalCredentialAwarded,
    String? accreditation,
    List<Map<String, dynamic>>? department,
  }) {
    return EducationalOrganizationSchema(
      name: name,
      url: url,
      description: description,
      logo: logo,
      address: address,
      foundingDate: foundingDate,
      educationalCredentialAwarded: educationalCredentialAwarded,
      accreditation: accreditation,
      subOrganization: department,
    );
  }

  /// Creates a school schema
  factory EducationalOrganizationSchema.school({
    required String name,
    required String url,
    String? description,
    String? logo,
    Map<String, dynamic>? address,
    String? telephone,
    String? email,
    Map<String, dynamic>? areaServed,
  }) {
    return EducationalOrganizationSchema(
      name: name,
      url: url,
      description: description,
      logo: logo,
      address: address,
      telephone: telephone,
      email: email,
      areaServed: areaServed,
    );
  }

  /// Helper method to create an educational organization as Map
  static Map<String, dynamic> toMap({
    required String name,
    String? url,
    String? description,
    String? logo,
    Map<String, dynamic>? address,
    String? legalName,
    String? accreditation,
  }) {
    return {
      '@type': 'EducationalOrganization',
      'name': name,
      if (url != null) 'url': url,
      if (description != null) 'description': description,
      if (logo != null)
        'logo': {
          '@type': 'ImageObject',
          'url': logo,
        },
      if (address != null) 'address': address,
      if (legalName != null) 'legalName': legalName,
      if (accreditation != null) 'accreditation': accreditation,
    }..removeWhere((key, value) => value == null);
  }

  /// Helper method to create an alumni person
  static Map<String, dynamic> createAlumni({
    required String name,
    String? url,
    String? graduationYear,
    String? degree,
  }) {
    return {
      '@type': 'Person',
      'name': name,
      if (url != null) 'url': url,
      if (graduationYear != null) 'graduationYear': graduationYear,
      if (degree != null) 'hasCredential': degree,
    };
  }

  /// Helper method to create an offer catalog for courses
  static Map<String, dynamic> createOfferCatalog({
    required String name,
    String? description,
    List<Map<String, dynamic>>? itemListElement,
  }) {
    return {
      '@type': 'OfferCatalog',
      'name': name,
      if (description != null) 'description': description,
      if (itemListElement != null && itemListElement.isNotEmpty)
        'itemListElement': itemListElement,
    };
  }

  /// Helper method to create a department
  static Map<String, dynamic> createDepartment({
    required String name,
    String? url,
    String? description,
    String? telephone,
    String? email,
  }) {
    return {
      '@type': 'Organization',
      'name': name,
      if (url != null) 'url': url,
      if (description != null) 'description': description,
      if (telephone != null) 'telephone': telephone,
      if (email != null) 'email': email,
    };
  }
}
