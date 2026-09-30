import 'package:jaspr_falkit/lib.dart';

/// EducationalOrganization schema for schools, universities,
/// and educational institutions
class EducationalOrganizationSchema extends Schema {
  new({
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
           'url': ?url,
           if (logo != null) 'logo': {'@type': 'ImageObject', 'url': logo},
           'description': ?description,
           'email': ?email,
           'telephone': ?telephone,
           'address': ?address,
           if (sameAs != null && sameAs.isNotEmpty) 'sameAs': sameAs,
           'foundingDate': ?foundingDate,
           if (alumni != null && alumni.isNotEmpty) 'alumni': alumni,
           'legalName': ?legalName,
           'accreditation': ?accreditation,
           if (educationalCredentialAwarded != null &&
               educationalCredentialAwarded.isNotEmpty)
             'educationalCredentialAwarded': educationalCredentialAwarded,
           if (hasOfferCatalog != null && hasOfferCatalog.isNotEmpty)
             'hasOfferCatalog': hasOfferCatalog,
           'contactPoint': ?contactPoint,
           'areaServed': ?areaServed,
           'numberOfEmployees': ?numberOfEmployees,
           'parentOrganization': ?parentOrganization,
           if (subOrganization != null && subOrganization.isNotEmpty)
             'subOrganization': subOrganization,
           'department': ?department,
           'slogan': ?slogan,
           'taxID': ?taxID,
           'vatID': ?vatID,
           if (review != null && review.isNotEmpty) 'review': review,
           'aggregateRating': ?aggregateRating,
           ...?additionalProperties,
         },
       );

  /// Creates a basic educational organization schema
  factory basic({
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
  factory university({
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
  factory school({
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
      'url': ?url,
      'description': ?description,
      if (logo != null) 'logo': {'@type': 'ImageObject', 'url': logo},
      'address': ?address,
      'legalName': ?legalName,
      'accreditation': ?accreditation,
    }..removeWhere((key, value) => value == null);
  }

  /// Helper method to create an alumni person.
  ///
  /// Note: schema.org `Person` has no `graduationYear` property. The closest
  /// valid representation is an `alumniOf` reference to an
  /// `EducationalOrganization` with `startDate`/`endDate`, optionally combined
  /// with `hasCredential` for the awarded degree.
  static Map<String, dynamic> createAlumni({
    required String name,
    String? url,
    String? alumniOfName,
    String? alumniOfUrl,
    String? startDate,
    String? endDate,
    String? degree,
  }) {
    return {
      '@type': 'Person',
      'name': name,
      'url': ?url,
      if (alumniOfName != null)
        'alumniOf': {
          '@type': 'EducationalOrganization',
          'name': alumniOfName,
          'url': ?alumniOfUrl,
          'startDate': ?startDate,
          'endDate': ?endDate,
        },
      'hasCredential': ?degree,
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
      'description': ?description,
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
      'url': ?url,
      'description': ?description,
      'telephone': ?telephone,
      'email': ?email,
    };
  }
}
