import 'package:jaspr_falkit/lib.dart';

/// ContactPoint schema for representing contact information
class ContactPointSchema extends Schema {
  ContactPointSchema({
    this.contactType,
    this.telephone,
    this.email,
    this.url,
    this.faxNumber,
    this.areaServed,
    this.availableLanguage,
    this.contactOption,
    this.hoursAvailable,
    this.productSupported,
    this.name,
    this.description,
    this.alternateName,
    this.identifier,
    this.sameAs,
    this.address,
    this.additionalProperties,
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'ContactPoint',
           if (contactType != null) 'contactType': contactType,
           if (telephone != null) 'telephone': telephone,
           if (email != null) 'email': email,
           if (url != null) 'url': url,
           if (faxNumber != null) 'faxNumber': faxNumber,
           if (areaServed != null) 'areaServed': areaServed.value,
           if (availableLanguage != null)
             'availableLanguage': availableLanguage.value,
           if (contactOption != null) 'contactOption': contactOption.value,
           if (hoursAvailable != null) 'hoursAvailable': hoursAvailable.value,
           if (productSupported != null)
             'productSupported': productSupported.value,
           if (name != null) 'name': name,
           if (description != null) 'description': description,
           if (alternateName != null) 'alternateName': alternateName,
           if (identifier != null) 'identifier': identifier,
           if (sameAs != null && sameAs.isNotEmpty) 'sameAs': sameAs,
           if (address != null) 'address': address.value,
           if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Creates a sales contact point
  factory ContactPointSchema.sales({
    required String telephone,
    String? email,
    SchemaDataType<Schema>? areaServed,
    SchemaDataType<Schema>? availableLanguage,
    SchemaDataType<Schema>? hoursAvailable,
  }) {
    return ContactPointSchema(
      contactType: 'sales',
      telephone: telephone,
      email: email,
      areaServed: areaServed,
      availableLanguage: availableLanguage,
      hoursAvailable: hoursAvailable,
    );
  }

  /// Creates a customer service contact point
  factory ContactPointSchema.customerService({
    required String telephone,
    String? email,
    SchemaDataType<Schema>? areaServed,
    SchemaDataType<Schema>? availableLanguage,
    SchemaDataType<Schema>? hoursAvailable,
    SchemaDataType<Schema>? contactOption,
  }) {
    return ContactPointSchema(
      contactType: 'customer service',
      telephone: telephone,
      email: email,
      areaServed: areaServed,
      availableLanguage: availableLanguage,
      hoursAvailable: hoursAvailable,
      contactOption: contactOption,
    );
  }

  /// Creates a technical support contact point
  factory ContactPointSchema.technicalSupport({
    required String telephone,
    String? email,
    String? url,
    SchemaDataType<Schema>? availableLanguage,
    SchemaDataType<Schema>? hoursAvailable,
    SchemaDataType<Schema>? productSupported,
  }) {
    return ContactPointSchema(
      contactType: 'technical support',
      telephone: telephone,
      email: email,
      url: url,
      availableLanguage: availableLanguage,
      hoursAvailable: hoursAvailable,
      productSupported: productSupported,
    );
  }

  /// Creates a billing support contact point
  factory ContactPointSchema.billing({
    required String telephone,
    String? email,
    SchemaDataType<Schema>? availableLanguage,
    SchemaDataType<Schema>? hoursAvailable,
  }) {
    return ContactPointSchema(
      contactType: 'billing support',
      telephone: telephone,
      email: email,
      availableLanguage: availableLanguage,
      hoursAvailable: hoursAvailable,
    );
  }

  /// Creates a reservations contact point
  factory ContactPointSchema.reservations({
    required String telephone,
    String? email,
    String? url,
    SchemaDataType<Schema>? availableLanguage,
    SchemaDataType<Schema>? hoursAvailable,
  }) {
    return ContactPointSchema(
      contactType: 'reservations',
      telephone: telephone,
      email: email,
      url: url,
      availableLanguage: availableLanguage,
      hoursAvailable: hoursAvailable,
    );
  }

  /// Creates an emergency contact point
  factory ContactPointSchema.emergency({
    required String telephone,
    String? email,
    SchemaDataType<Schema>? areaServed,
    SchemaDataType<Schema>? availableLanguage,
  }) {
    return ContactPointSchema(
      contactType: 'emergency',
      telephone: telephone,
      email: email,
      areaServed: areaServed,
      availableLanguage: availableLanguage,
      contactOption: const SchemaDataType<Schema>(str: 'TollFree'),
      hoursAvailable: const SchemaDataType<Schema>(str: '24/7'),
    );
  }

  final String? contactType;
  final String? telephone;
  final String? email;
  final String? url;
  final String? faxNumber;
  final SchemaDataType<Schema>?
  areaServed; // Can be String, List<String>, or Map
  final SchemaDataType<Schema>?
  availableLanguage; // Can be String or List<String>
  final SchemaDataType<Schema>? contactOption; // Can be String or List<String>
  final SchemaDataType<Schema>?
  hoursAvailable; // OpeningHoursSpecification or String
  final SchemaDataType<Schema>?
  productSupported; // Can be String or List<String>
  final String? name;
  final String? description;
  final String? alternateName;
  final String? identifier;
  final List<String>? sameAs;
  final SchemaDataType<PostalAddressSchema>? address;
  final Map<String, dynamic>? additionalProperties;

  /// Helper method to create contact point as Map for organization
  static Map<String, dynamic> toMap({
    String? contactType,
    String? telephone,
    String? email,
    String? url,
    String? faxNumber,
    dynamic areaServed,
    dynamic availableLanguage,
    dynamic contactOption,
    dynamic hoursAvailable,
    dynamic productSupported,
  }) {
    return {
      '@type': 'ContactPoint',
      if (contactType != null) 'contactType': contactType,
      if (telephone != null) 'telephone': telephone,
      if (email != null) 'email': email,
      if (url != null) 'url': url,
      if (faxNumber != null) 'faxNumber': faxNumber,
      if (areaServed != null) 'areaServed': areaServed,
      if (availableLanguage != null) 'availableLanguage': availableLanguage,
      if (contactOption != null) 'contactOption': contactOption,
      if (hoursAvailable != null) 'hoursAvailable': hoursAvailable,
      if (productSupported != null) 'productSupported': productSupported,
    };
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

  /// Helper method to create 24/7 hours
  static Map<String, dynamic> create24x7Hours() {
    return createOpeningHours(
      dayOfWeek: [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ],
      opens: '00:00',
      closes: '23:59',
    );
  }

  /// Helper method to create business hours
  static Map<String, dynamic> createBusinessHours({
    String opens = '09:00',
    String closes = '17:00',
    bool includeWeekends = false,
  }) {
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
    ];
    if (includeWeekends) {
      days.addAll(['Saturday', 'Sunday']);
    }
    return createOpeningHours(
      dayOfWeek: days,
      opens: opens,
      closes: closes,
    );
  }

  /// Helper method to create contact point list for organizations
  static List<Map<String, dynamic>> createContactPointList({
    ContactPointSchema? customerService,
    ContactPointSchema? technicalSupport,
    ContactPointSchema? sales,
    ContactPointSchema? billing,
    ContactPointSchema? reservations,
    ContactPointSchema? emergency,
  }) {
    final list = <Map<String, dynamic>>[];
    if (customerService != null) {
      list.add(customerService.schemaData);
    }
    if (technicalSupport != null) {
      list.add(technicalSupport.schemaData);
    }
    if (sales != null) {
      list.add(sales.schemaData);
    }
    if (billing != null) {
      list.add(billing.schemaData);
    }
    if (reservations != null) {
      list.add(reservations.schemaData);
    }
    if (emergency != null) {
      list.add(emergency.schemaData);
    }
    return list;
  }

  /// Contact option constants
  static const String tollFree = 'TollFree';
  static const String hearingImpairedSupported = 'HearingImpairedSupported';

  /// Day of week constants
  static const List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  static const List<String> weekend = ['Saturday', 'Sunday'];

  static const List<String> allDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
}

// Backward compatibility typedef
typedef ContactPointSchemaData = ContactPointSchema;
