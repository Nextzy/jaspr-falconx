import 'package:jaspr_falkit/lib.dart';

/// Helper class for creating Person schema with common configurations
class PersonSchemaHelper {
  /// Creates a basic person schema with minimal required fields
  static PersonSchema basic({
    required String name,
    String? email,
    String? url,
    SchemaDataType<ImageSchema>? image,
    String? jobTitle,
  }) {
    return PersonSchema(
      name: name,
      email: email,
      url: url,
      image: image,
      jobTitle: jobTitle,
    );
  }

  /// Creates a professional person schema with work details
  static PersonSchema professional({
    required String givenName,
    required String familyName,
    String? additionalName,
    String? email,
    String? telephone,
    String? jobTitle,
    SchemaDataType<ImageSchema>? image,
    String? url,
    SchemaDataType<OrganizationSchema>? worksFor,
    SchemaDataType<OrganizationSchema>? affiliation,
    List<String>? sameAs,
    SchemaDataType<PostalAddressSchema>? address,
  }) {
    return PersonSchema(
      givenName: givenName,
      familyName: familyName,
      additionalName: additionalName,
      email: email,
      telephone: telephone,
      jobTitle: jobTitle,
      image: image,
      url: url,
      worksFor: worksFor,
      affiliation: affiliation,
      sameAs: sameAs,
      address: address,
    );
  }

  /// Creates a person schema for authors/creators
  static PersonSchema author({
    required String name,
    String? givenName,
    String? familyName,
    String? email,
    String? url,
    SchemaDataType<ImageSchema>? image,
    List<String>? sameAs,
    SchemaDataType<OrganizationSchema>? affiliation,
  }) {
    return PersonSchema(
      name: name,
      givenName: givenName,
      familyName: familyName,
      email: email,
      url: url,
      image: image,
      sameAs: sameAs,
      affiliation: affiliation,
    );
  }

  /// Creates a detailed person schema with personal information
  static PersonSchema detailed({
    required String givenName,
    required String familyName,
    String? additionalName,
    String? honorificPrefix,
    String? honorificSuffix,
    String? email,
    String? telephone,
    String? birthDate,
    String? gender,
    String? nationality,
    String? jobTitle,
    SchemaDataType<ImageSchema>? image,
    String? url,
    SchemaDataType<PostalAddressSchema>? address,
    Map<String, String>? birthPlace,
    SchemaDataType<OrganizationSchema>? worksFor,
    Map<String, String>? alumniOf,
    SchemaDataType<PersonSchema>? spouse,
    SchemaListDataType<PersonSchema>? children,
    SchemaListDataType<PersonSchema>? parent,
    List<String>? sameAs,
  }) {
    return PersonSchema(
      givenName: givenName,
      familyName: familyName,
      additionalName: additionalName,
      honorificPrefix: honorificPrefix,
      honorificSuffix: honorificSuffix,
      email: email,
      telephone: telephone,
      birthDate: birthDate,
      gender: gender,
      nationality: nationality,
      jobTitle: jobTitle,
      image: image,
      url: url,
      address: address,
      birthPlace: birthPlace,
      worksFor: worksFor,
      alumniOf: alumniOf,
      spouse: spouse,
      personChildren: children,
      parent: parent,
      sameAs: sameAs,
    );
  }

  /// Creates a person schema for team members
  static PersonSchema teamMember({
    required String name,
    required String jobTitle,
    String? email,
    SchemaDataType<ImageSchema>? image,
    String? url,
    List<String>? sameAs,
    SchemaDataType<OrganizationSchema>? worksFor,
  }) {
    return PersonSchema(
      name: name,
      jobTitle: jobTitle,
      email: email,
      image: image,
      url: url,
      sameAs: sameAs,
      worksFor: worksFor,
    );
  }

  /// Helper method to create an address map for Person schema
  static Map<String, dynamic> createAddress({
    String? streetAddress,
    String? addressLocality,
    String? addressRegion,
    String? postalCode,
    String? addressCountry,
  }) {
    return PostalAddressSchema.toMap(
      streetAddress: streetAddress,
      addressLocality: addressLocality,
      addressRegion: addressRegion,
      postalCode: postalCode,
      addressCountry: addressCountry,
    );
  }

  /// Helper method to create a contact point map for Person schema
  static Map<String, dynamic> createContactPoint({
    String? telephone,
    String? contactType,
    String? email,
    String? areaServed,
  }) {
    return ContactPointSchema.toMap(
      telephone: telephone,
      contactType: contactType,
      email: email,
      areaServed: areaServed,
    );
  }

  /// Helper method to create an organization map for worksFor/affiliation
  static Map<String, String> createOrganization({
    required String name,
    String? url,
    String? description,
  }) {
    final map = <String, String>{};
    map['name'] = name;
    if (url != null) map['url'] = url;
    if (description != null) map['description'] = description;
    return map;
  }

  /// Helper method to create a person reference (for relationships)
  static Map<String, String> createPersonReference({
    required String name,
    String? url,
  }) {
    final map = <String, String>{};
    map['name'] = name;
    if (url != null) map['url'] = url;
    return map;
  }

  /// Creates social media links array
  static List<String> createSocialLinks({
    String? twitter,
    String? facebook,
    String? linkedin,
    String? github,
    String? instagram,
    String? youtube,
    List<String>? others,
  }) {
    final links = <String>[];
    if (twitter != null) links.add(twitter);
    if (facebook != null) links.add(facebook);
    if (linkedin != null) links.add(linkedin);
    if (github != null) links.add(github);
    if (instagram != null) links.add(instagram);
    if (youtube != null) links.add(youtube);
    if (others != null) links.addAll(others);
    return links;
  }
}
