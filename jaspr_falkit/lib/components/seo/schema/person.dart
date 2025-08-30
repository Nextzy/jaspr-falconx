import 'package:jaspr_falkit/lib.dart';
import 'package:jaspr_falkit/components/seo/schema/base_schema.dart';

/// Person schema for representing individuals
class PersonSchema extends Schema {
  PersonSchema({
    String? name,
    String? givenName,
    String? familyName,
    String? additionalName,
    String? alternateName,
    String? description,
    String? url,
    String? image,
    String? email,
    String? telephone,
    String? birthDate,
    String? deathDate,
    String? gender,
    String? jobTitle,
    String? honorificPrefix,
    String? honorificSuffix,
    Map<String, String>? address,
    Map<String, String>? birthPlace,
    Map<String, String>? deathPlace,
    String? nationality,
    Map<String, String>? worksFor,
    Map<String, String>? affiliation,
    Map<String, String>? alumniOf,
    Map<String, String>? memberOf,
    Map<String, String>? sponsor,
    List<Map<String, String>>? knows,
    List<Map<String, String>>? follows,
    List<Map<String, String>>? colleague,
    Map<String, String>? spouse,
    List<Map<String, String>>? children,
    List<Map<String, String>>? parent,
    List<Map<String, String>>? sibling,
    List<String>? sameAs,
    String? award,
    String? brand,
    Map<String, String>? contactPoint,
    String? duns,
    String? faxNumber,
    String? globalLocationNumber,
    String? height,
    String? weight,
    String? homeLocation,
    String? isicV4,
    String? naics,
    String? netWorth,
    Map<String, String>? owns,
    String? performerIn,
    String? publishingPrinciples,
    String? seeks,
    String? taxID,
    String? vatID,
    String? workLocation,
    Map<String, dynamic>? additionalProperties,
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'Person',
                 if (name != null) 'name': name,
                 if (givenName != null) 'givenName': givenName,
                 if (familyName != null) 'familyName': familyName,
                 if (additionalName != null) 'additionalName': additionalName,
                 if (alternateName != null) 'alternateName': alternateName,
                 if (description != null) 'description': description,
                 if (url != null) 'url': url,
                 if (image != null)
                   'image': {
                     '@type': 'ImageObject',
                     'url': image,
                   },
                 if (email != null) 'email': email,
                 if (telephone != null) 'telephone': telephone,
                 if (birthDate != null) 'birthDate': birthDate,
                 if (deathDate != null) 'deathDate': deathDate,
                 if (gender != null) 'gender': gender,
                 if (jobTitle != null) 'jobTitle': jobTitle,
                 if (honorificPrefix != null) 'honorificPrefix': honorificPrefix,
                 if (honorificSuffix != null) 'honorificSuffix': honorificSuffix,
                 if (address != null)
                   'address': {
                     '@type': 'PostalAddress',
                     ...address,
                   },
                 if (birthPlace != null)
                   'birthPlace': {
                     '@type': 'Place',
                     ...birthPlace,
                   },
                 if (deathPlace != null)
                   'deathPlace': {
                     '@type': 'Place',
                     ...deathPlace,
                   },
                 if (nationality != null) 'nationality': nationality,
                 if (worksFor != null)
                   'worksFor': {
                     '@type': 'Organization',
                     ...worksFor,
                   },
                 if (affiliation != null)
                   'affiliation': {
                     '@type': 'Organization',
                     ...affiliation,
                   },
                 if (alumniOf != null)
                   'alumniOf': {
                     '@type': 'EducationalOrganization',
                     ...alumniOf,
                   },
                 if (memberOf != null)
                   'memberOf': {
                     '@type': 'Organization',
                     ...memberOf,
                   },
                 if (sponsor != null)
                   'sponsor': {
                     '@type': 'Organization',
                     ...sponsor,
                   },
                 if (knows != null && knows.isNotEmpty)
                   'knows': knows
                       .map(
                         (person) => {
                           '@type': 'Person',
                           ...person,
                         },
                       )
                       .toList(),
                 if (follows != null && follows.isNotEmpty)
                   'follows': follows
                       .map(
                         (person) => {
                           '@type': 'Person',
                           ...person,
                         },
                       )
                       .toList(),
                 if (colleague != null && colleague.isNotEmpty)
                   'colleague': colleague
                       .map(
                         (person) => {
                           '@type': 'Person',
                           ...person,
                         },
                       )
                       .toList(),
                 if (spouse != null)
                   'spouse': {
                     '@type': 'Person',
                     ...spouse,
                   },
                 if (children != null && children.isNotEmpty)
                   'children': children
                       .map(
                         (child) => {
                           '@type': 'Person',
                           ...child,
                         },
                       )
                       .toList(),
                 if (parent != null && parent.isNotEmpty)
                   'parent': parent
                       .map(
                         (parentPerson) => {
                           '@type': 'Person',
                           ...parentPerson,
                         },
                       )
                       .toList(),
                 if (sibling != null && sibling.isNotEmpty)
                   'sibling': sibling
                       .map(
                         (siblingPerson) => {
                           '@type': 'Person',
                           ...siblingPerson,
                         },
                       )
                       .toList(),
                 if (sameAs != null && sameAs.isNotEmpty) 'sameAs': sameAs,
                 if (award != null) 'award': award,
                 if (brand != null) 'brand': brand,
                 if (contactPoint != null)
                   'contactPoint': {
                     '@type': 'ContactPoint',
                     ...contactPoint,
                   },
                 if (duns != null) 'duns': duns,
                 if (faxNumber != null) 'faxNumber': faxNumber,
                 if (globalLocationNumber != null) 'globalLocationNumber': globalLocationNumber,
                 if (height != null) 'height': height,
                 if (weight != null) 'weight': weight,
                 if (homeLocation != null) 'homeLocation': homeLocation,
                 if (isicV4 != null) 'isicV4': isicV4,
                 if (naics != null) 'naics': naics,
                 if (netWorth != null) 'netWorth': netWorth,
                 if (owns != null)
                   'owns': {
                     '@type': 'OwnershipInfo',
                     ...owns,
                   },
                 if (performerIn != null) 'performerIn': performerIn,
                 if (publishingPrinciples != null) 'publishingPrinciples': publishingPrinciples,
                 if (seeks != null) 'seeks': seeks,
                 if (taxID != null) 'taxID': taxID,
                 if (vatID != null) 'vatID': vatID,
                 if (workLocation != null) 'workLocation': workLocation,
                 if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Creates a basic person schema
  factory PersonSchema.basic({
    required String name,
    String? url,
    String? description,
    String? image,
    String? jobTitle,
  }) {
    return PersonSchema(
      name: name,
      url: url,
      description: description,
      image: image,
      jobTitle: jobTitle,
    );
  }

  /// Creates an author schema
  factory PersonSchema.author({
    required String name,
    String? url,
    String? email,
    String? image,
    String? description,
    List<String>? sameAs,
  }) {
    return PersonSchema(
      name: name,
      url: url,
      email: email,
      image: image,
      description: description,
      sameAs: sameAs,
    );
  }

  /// Creates a professional/employee schema
  factory PersonSchema.professional({
    required String name,
    required String jobTitle,
    Map<String, String>? worksFor,
    String? email,
    String? telephone,
    String? url,
    String? image,
    Map<String, String>? address,
  }) {
    return PersonSchema(
      name: name,
      jobTitle: jobTitle,
      worksFor: worksFor,
      email: email,
      telephone: telephone,
      url: url,
      image: image,
      address: address,
    );
  }

  /// Helper method to create a person as Map for use in other schemas
  static Map<String, dynamic> toMap({
    required String name,
    String? givenName,
    String? familyName,
    String? url,
    String? email,
    String? image,
    String? jobTitle,
    Map<String, dynamic>? worksFor,
    List<String>? sameAs,
  }) {
    return {
      '@type': 'Person',
      'name': name,
      if (givenName != null) 'givenName': givenName,
      if (familyName != null) 'familyName': familyName,
      if (url != null) 'url': url,
      if (email != null) 'email': email,
      if (image != null)
        'image': {
          '@type': 'ImageObject',
          'url': image,
        },
      if (jobTitle != null) 'jobTitle': jobTitle,
      if (worksFor != null) 'worksFor': worksFor,
      if (sameAs != null && sameAs.isNotEmpty) 'sameAs': sameAs,
    }..removeWhere((key, value) => value == null);
  }

  /// Helper method to create social media profiles
  static List<String> createSocialProfiles({
    String? facebook,
    String? twitter,
    String? linkedin,
    String? instagram,
    String? github,
    String? youtube,
  }) {
    final profiles = <String>[];
    if (facebook != null) profiles.add(facebook);
    if (twitter != null) profiles.add(twitter);
    if (linkedin != null) profiles.add(linkedin);
    if (instagram != null) profiles.add(instagram);
    if (github != null) profiles.add(github);
    if (youtube != null) profiles.add(youtube);
    return profiles;
  }

  /// Helper method to create a simple person reference
  static Map<String, String> createSimpleReference({
    required String name,
    String? url,
  }) {
    final map = <String, String>{
      'name': name,
    };
    if (url != null) map['url'] = url;
    return map;
  }
}