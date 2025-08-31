import 'package:jaspr_falkit/lib.dart';

/// Person schema for representing individuals
class PersonSchema extends Schema {
  PersonSchema({
    this.name,
    this.givenName,
    this.familyName,
    this.additionalName,
    this.alternateName,
    this.description,
    this.url,
    this.image,
    this.email,
    this.telephone,
    this.birthDate,
    this.deathDate,
    this.gender,
    this.jobTitle,
    this.honorificPrefix,
    this.honorificSuffix,
    this.address,
    this.birthPlace,
    this.deathPlace,
    this.nationality,
    this.worksFor,
    this.affiliation,
    this.alumniOf,
    this.memberOf,
    this.sponsor,
    this.knows,
    this.follows,
    this.colleague,
    this.spouse,
    this.personChildren,
    this.parent,
    this.sibling,
    this.sameAs,
    this.award,
    this.brand,
    this.contactPoint,
    this.duns,
    this.faxNumber,
    this.globalLocationNumber,
    this.height,
    this.weight,
    this.homeLocation,
    this.isicV4,
    this.naics,
    this.netWorth,
    this.owns,
    this.performerIn,
    this.publishingPrinciples,
    this.seeks,
    this.taxID,
    this.vatID,
    this.workLocation,
    this.additionalProperties,
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
           if (image != null) 'image': image.value,
           if (email != null) 'email': email,
           if (telephone != null) 'telephone': telephone,
           if (birthDate != null) 'birthDate': birthDate,
           if (deathDate != null) 'deathDate': deathDate,
           if (gender != null) 'gender': gender,
           if (jobTitle != null) 'jobTitle': jobTitle,
           if (honorificPrefix != null) 'honorificPrefix': honorificPrefix,
           if (honorificSuffix != null) 'honorificSuffix': honorificSuffix,
           if (address != null) 'address': address.value,
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
           if (worksFor != null) 'worksFor': worksFor.value,
           if (affiliation != null) 'affiliation': affiliation.value,
           if (alumniOf != null) 'alumniOf': alumniOf,
           if (memberOf != null) 'memberOf': memberOf.value,
           if (sponsor != null) 'sponsor': sponsor.value,
           if (knows != null && knows.value != null) 'knows': knows.value,
           if (follows != null && follows.value != null)
             'follows': follows.value,
           if (colleague != null && colleague.value != null)
             'colleague': colleague.value,
           if (spouse != null) 'spouse': spouse.value,
           if (personChildren != null && personChildren.value != null)
             'children': personChildren.value,
           if (parent != null && parent.value != null) 'parent': parent.value,
           if (sibling != null && sibling.value != null)
             'sibling': sibling.value,
           if (sameAs != null && sameAs.isNotEmpty) 'sameAs': sameAs,
           if (award != null) 'award': award,
           if (brand != null) 'brand': brand,
           if (contactPoint != null) 'contactPoint': contactPoint.value,
           if (duns != null) 'duns': duns,
           if (faxNumber != null) 'faxNumber': faxNumber,
           if (globalLocationNumber != null)
             'globalLocationNumber': globalLocationNumber,
           if (height != null) 'height': height,
           if (weight != null) 'weight': weight,
           if (homeLocation != null) 'homeLocation': homeLocation,
           if (isicV4 != null) 'isicV4': isicV4,
           if (naics != null) 'naics': naics,
           if (netWorth != null) 'netWorth': netWorth,
           if (owns != null) 'owns': owns,
           if (performerIn != null) 'performerIn': performerIn,
           if (publishingPrinciples != null)
             'publishingPrinciples': publishingPrinciples,
           if (seeks != null) 'seeks': seeks,
           if (taxID != null) 'taxID': taxID,
           if (vatID != null) 'vatID': vatID,
           if (workLocation != null) 'workLocation': workLocation,
           if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Factory constructor for basic person
  factory PersonSchema.basic({
    required String name,
    String? url,
    String? email,
    String? telephone,
    String? jobTitle,
    SchemaDataType<ImageSchema>? image,
  }) {
    return PersonSchema(
      name: name,
      url: url,
      email: email,
      telephone: telephone,
      jobTitle: jobTitle,
      image: image,
    );
  }

  /// Factory constructor for author
  factory PersonSchema.author({
    required String name,
    String? url,
    String? email,
    SchemaDataType<ImageSchema>? image,
    String? jobTitle,
    SchemaDataType<OrganizationSchema>? affiliation,
    List<String>? sameAs,
  }) {
    return PersonSchema(
      name: name,
      url: url,
      email: email,
      image: image,
      jobTitle: jobTitle ?? 'Author',
      affiliation: affiliation,
      sameAs: sameAs,
    );
  }

  /// Factory constructor for team member
  factory PersonSchema.teamMember({
    required String name,
    required String givenName,
    required String familyName,
    required String jobTitle,
    SchemaDataType<ImageSchema>? image,
    String? email,
    String? telephone,
    SchemaDataType<OrganizationSchema>? worksFor,
    List<String>? sameAs,
  }) {
    return PersonSchema(
      name: name,
      givenName: givenName,
      familyName: familyName,
      jobTitle: jobTitle,
      image: image,
      email: email,
      telephone: telephone,
      worksFor: worksFor,
      sameAs: sameAs,
    );
  }

  /// Factory constructor for professional profile
  factory PersonSchema.professional({
    required String name,
    required String givenName,
    required String familyName,
    required String jobTitle,
    required SchemaDataType<OrganizationSchema> worksFor,
    SchemaDataType<ImageSchema>? image,
    String? email,
    String? telephone,
    SchemaDataType<PostalAddressSchema>? address,
    String? honorificPrefix,
    String? honorificSuffix,
    List<String>? sameAs,
    String? description,
  }) {
    return PersonSchema(
      name: name,
      givenName: givenName,
      familyName: familyName,
      jobTitle: jobTitle,
      worksFor: worksFor,
      image: image,
      email: email,
      telephone: telephone,
      address: address,
      honorificPrefix: honorificPrefix,
      honorificSuffix: honorificSuffix,
      sameAs: sameAs,
      description: description,
    );
  }

  /// Factory constructor for creative person
  factory PersonSchema.creative({
    required String name,
    String? givenName,
    String? familyName,
    String? description,
    SchemaDataType<ImageSchema>? image,
    String? url,
    String? email,
    String? birthDate,
    String? nationality,
    String? award,
    List<String>? sameAs,
  }) {
    return PersonSchema(
      name: name,
      givenName: givenName,
      familyName: familyName,
      description: description,
      image: image,
      url: url,
      email: email,
      birthDate: birthDate,
      nationality: nationality,
      award: award,
      sameAs: sameAs,
    );
  }

  /// Factory constructor for executive
  factory PersonSchema.executive({
    required String name,
    required String givenName,
    required String familyName,
    required String jobTitle,
    required SchemaDataType<OrganizationSchema> worksFor,
    SchemaDataType<ImageSchema>? image,
    String? description,
    String? email,
    String? telephone,
    String? honorificPrefix,
    SchemaDataType<PostalAddressSchema>? address,
    List<String>? sameAs,
    Map<String, dynamic>? alumniOf,
  }) {
    return PersonSchema(
      name: name,
      givenName: givenName,
      familyName: familyName,
      jobTitle: jobTitle,
      worksFor: worksFor,
      image: image,
      description: description,
      email: email,
      telephone: telephone,
      honorificPrefix: honorificPrefix,
      address: address,
      sameAs: sameAs,
      alumniOf: alumniOf,
    );
  }

  final String? name;
  final String? givenName;
  final String? familyName;
  final String? additionalName;
  final String? alternateName;
  final String? description;
  final String? url;
  final SchemaDataType<ImageSchema>? image;
  final String? email;
  final String? telephone;
  final String? birthDate;
  final String? deathDate;
  final String? gender;
  final String? jobTitle;
  final String? honorificPrefix;
  final String? honorificSuffix;
  final SchemaDataType<PostalAddressSchema>? address;
  final Map<String, dynamic>? birthPlace;
  final Map<String, dynamic>? deathPlace;
  final String? nationality;
  final SchemaDataType<OrganizationSchema>? worksFor;
  final SchemaDataType<OrganizationSchema>? affiliation;
  final Map<String, dynamic>? alumniOf;
  final SchemaDataType<OrganizationSchema>? memberOf;
  final SchemaDataType<OrganizationSchema>? sponsor;
  final SchemaListDataType<PersonSchema>? knows;
  final SchemaListDataType<PersonSchema>? follows;
  final SchemaListDataType<PersonSchema>? colleague;
  final SchemaDataType<PersonSchema>? spouse;
  final SchemaListDataType<PersonSchema>? personChildren;
  final SchemaListDataType<PersonSchema>? parent;
  final SchemaListDataType<PersonSchema>? sibling;
  final List<String>? sameAs;
  final String? award;
  final String? brand;
  final SchemaDataType<ContactPointSchema>? contactPoint;
  final String? duns;
  final String? faxNumber;
  final String? globalLocationNumber;
  final String? height;
  final String? weight;
  final String? homeLocation;
  final String? isicV4;
  final String? naics;
  final String? netWorth;
  final Map<String, dynamic>? owns;
  final String? performerIn;
  final String? publishingPrinciples;
  final String? seeks;
  final String? taxID;
  final String? vatID;
  final String? workLocation;
  final Map<String, dynamic>? additionalProperties;

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
    };
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

  /// Helper method to create alumni of with degree
  static Map<String, dynamic> createAlumniOf({
    required String name,
    String? url,
    String? degree,
    String? startDate,
    String? endDate,
  }) {
    final map = <String, dynamic>{
      'name': name,
    };
    if (url != null) map['url'] = url;
    return map;
  }
}
