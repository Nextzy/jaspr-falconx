import 'package:jaspr_falkit/lib.dart';
import 'package:jaspr_falkit/components/seo/schema/base_schema.dart';

/// ContactPoint schema for representing contact information
class ContactPointSchema extends Schema {
  ContactPointSchema({
    String? contactType,
    String? telephone,
    String? email,
    String? url,
    String? faxNumber,
    String? areaServed,
    List<String>? availableLanguage,
    String? contactOption,
    String? hoursAvailable,
    String? productSupported,
    Map<String, dynamic>? address,
    Map<String, dynamic>? additionalProperties,
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'ContactPoint',
           if (contactType != null) 'contactType': contactType,
           if (telephone != null) 'telephone': telephone,
           if (email != null) 'email': email,
           if (url != null) 'url': url,
           if (faxNumber != null) 'faxNumber': faxNumber,
           if (areaServed != null) 'areaServed': areaServed,
           if (availableLanguage != null && availableLanguage.isNotEmpty)
             'availableLanguage': availableLanguage,
           if (contactOption != null) 'contactOption': contactOption,
           if (hoursAvailable != null) 'hoursAvailable': hoursAvailable,
           if (productSupported != null) 'productSupported': productSupported,
           if (address != null) 'address': address,
           if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Creates a customer service contact point
  factory ContactPointSchema.customerService({
    required String telephone,
    String? email,
    String? areaServed,
    List<String>? availableLanguage,
    String? hoursAvailable,
  }) {
    return ContactPointSchema(
      contactType: 'Customer Service',
      telephone: telephone,
      email: email,
      areaServed: areaServed,
      availableLanguage: availableLanguage,
      hoursAvailable: hoursAvailable,
    );
  }

  /// Creates a technical support contact point
  factory ContactPointSchema.technicalSupport({
    required String telephone,
    String? email,
    String? url,
    List<String>? availableLanguage,
    String? hoursAvailable,
  }) {
    return ContactPointSchema(
      contactType: 'Technical Support',
      telephone: telephone,
      email: email,
      url: url,
      availableLanguage: availableLanguage,
      hoursAvailable: hoursAvailable,
    );
  }

  /// Creates a sales contact point
  factory ContactPointSchema.sales({
    required String telephone,
    String? email,
    String? areaServed,
    List<String>? availableLanguage,
    String? hoursAvailable,
  }) {
    return ContactPointSchema(
      contactType: 'Sales',
      telephone: telephone,
      email: email,
      areaServed: areaServed,
      availableLanguage: availableLanguage,
      hoursAvailable: hoursAvailable,
    );
  }

  /// Helper method to create contact point as Map for organization
  static Map<String, dynamic> toMap({
    String? contactType,
    String? telephone,
    String? email,
    String? url,
    String? faxNumber,
    String? areaServed,
    List<String>? availableLanguage,
    String? contactOption,
    String? hoursAvailable,
    String? productSupported,
  }) {
    return {
      '@type': 'ContactPoint',
      if (contactType != null) 'contactType': contactType,
      if (telephone != null) 'telephone': telephone,
      if (email != null) 'email': email,
      if (url != null) 'url': url,
      if (faxNumber != null) 'faxNumber': faxNumber,
      if (areaServed != null) 'areaServed': areaServed,
      if (availableLanguage != null && availableLanguage.isNotEmpty)
        'availableLanguage': availableLanguage,
      if (contactOption != null) 'contactOption': contactOption,
      if (hoursAvailable != null) 'hoursAvailable': hoursAvailable,
      if (productSupported != null) 'productSupported': productSupported,
    }..removeWhere((key, value) => value == null);
  }

  /// Helper method to create opening hours specification
  static Map<String, dynamic> createOpeningHours({
    required List<String> dayOfWeek,
    required String opens,
    required String closes,
    String? validFrom,
    String? validThrough,
  }) {
    return {
      '@type': 'OpeningHoursSpecification',
      'dayOfWeek': dayOfWeek,
      'opens': opens,
      'closes': closes,
      if (validFrom != null) 'validFrom': validFrom,
      if (validThrough != null) 'validThrough': validThrough,
    };
  }

  /// Helper method to create contact point list for organizations
  static List<Map<String, dynamic>> createContactPointList({
    Map<String, dynamic>? customerService,
    Map<String, dynamic>? technicalSupport,
    Map<String, dynamic>? sales,
    Map<String, dynamic>? billing,
    Map<String, dynamic>? reservations,
  }) {
    final list = <Map<String, dynamic>>[];
    if (customerService != null) list.add(customerService);
    if (technicalSupport != null) list.add(technicalSupport);
    if (sales != null) list.add(sales);
    if (billing != null) list.add(billing);
    if (reservations != null) list.add(reservations);
    return list;
  }
}