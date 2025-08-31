import 'package:jaspr_falkit/lib.dart';

/// PostalAddress schema for representing physical addresses
class PostalAddressSchema extends Schema {
  PostalAddressSchema({
    String? streetAddress,
    String? addressLocality,
    String? addressRegion,
    String? postalCode,
    String? addressCountry,
    String? postOfficeBoxNumber,
    String? addressExtended,
    String? name,
    String? description,
    Map<String, dynamic>? additionalProperties,
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'PostalAddress',
           if (streetAddress != null) 'streetAddress': streetAddress,
           if (addressLocality != null) 'addressLocality': addressLocality,
           if (addressRegion != null) 'addressRegion': addressRegion,
           if (postalCode != null) 'postalCode': postalCode,
           if (addressCountry != null) 'addressCountry': addressCountry,
           if (postOfficeBoxNumber != null)
             'postOfficeBoxNumber': postOfficeBoxNumber,
           if (addressExtended != null) 'addressExtended': addressExtended,
           if (name != null) 'name': name,
           if (description != null) 'description': description,
           if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Creates a US address schema
  factory PostalAddressSchema.usAddress({
    required String streetAddress,
    required String addressLocality,
    required String addressRegion,
    required String postalCode,
    String? postOfficeBoxNumber,
    String? addressExtended,
  }) {
    return PostalAddressSchema(
      streetAddress: streetAddress,
      addressLocality: addressLocality,
      addressRegion: addressRegion,
      postalCode: postalCode,
      addressCountry: 'US',
      postOfficeBoxNumber: postOfficeBoxNumber,
      addressExtended: addressExtended,
    );
  }

  /// Creates an international address schema
  factory PostalAddressSchema.international({
    required String streetAddress,
    required String addressLocality,
    required String addressCountry,
    String? addressRegion,
    String? postalCode,
    String? addressExtended,
  }) {
    return PostalAddressSchema(
      streetAddress: streetAddress,
      addressLocality: addressLocality,
      addressRegion: addressRegion,
      postalCode: postalCode,
      addressCountry: addressCountry,
      addressExtended: addressExtended,
    );
  }

  /// Creates a simple address schema
  factory PostalAddressSchema.simple({
    required String streetAddress,
    required String city,
    required String country,
  }) {
    return PostalAddressSchema(
      streetAddress: streetAddress,
      addressLocality: city,
      addressCountry: country,
    );
  }

  /// Creates a European address schema
  factory PostalAddressSchema.european({
    required String streetAddress,
    required String city,
    required String postalCode,
    required String country,
    String? region,
  }) {
    return PostalAddressSchema(
      streetAddress: streetAddress,
      addressLocality: city,
      addressRegion: region,
      postalCode: postalCode,
      addressCountry: getCountryCode(country),
    );
  }

  /// Helper method to create a postal address as Map for use in other schemas
  static Map<String, dynamic> toMap({
    String? streetAddress,
    String? addressLocality,
    String? addressRegion,
    String? postalCode,
    String? addressCountry,
    String? postOfficeBoxNumber,
    String? addressExtended,
  }) {
    return {
      '@type': 'PostalAddress',
      if (streetAddress != null) 'streetAddress': streetAddress,
      if (addressLocality != null) 'addressLocality': addressLocality,
      if (addressRegion != null) 'addressRegion': addressRegion,
      if (postalCode != null) 'postalCode': postalCode,
      if (addressCountry != null) 'addressCountry': addressCountry,
      if (postOfficeBoxNumber != null)
        'postOfficeBoxNumber': postOfficeBoxNumber,
      if (addressExtended != null) 'addressExtended': addressExtended,
    };
  }

  /// Creates a formatted address string
  static String formatAddress({
    String? streetAddress,
    String? addressLocality,
    String? addressRegion,
    String? postalCode,
    String? addressCountry,
  }) {
    final parts = <String>[];
    if (streetAddress != null) parts.add(streetAddress);

    final cityStateZip = <String>[];
    if (addressLocality != null) cityStateZip.add(addressLocality);
    if (addressRegion != null) cityStateZip.add(addressRegion);
    if (postalCode != null) cityStateZip.add(postalCode);
    if (cityStateZip.isNotEmpty) parts.add(cityStateZip.join(', '));

    if (addressCountry != null) parts.add(addressCountry);

    return parts.join('\n');
  }

  /// Country code helper
  static String getCountryCode(String countryName) {
    const countryCodes = {
      'United States': 'US',
      'United Kingdom': 'GB',
      'Canada': 'CA',
      'Australia': 'AU',
      'Germany': 'DE',
      'France': 'FR',
      'Spain': 'ES',
      'Italy': 'IT',
      'Japan': 'JP',
      'China': 'CN',
      'India': 'IN',
      'Brazil': 'BR',
      'Mexico': 'MX',
      'Russia': 'RU',
      'South Korea': 'KR',
      'Netherlands': 'NL',
      'Belgium': 'BE',
      'Switzerland': 'CH',
      'Austria': 'AT',
      'Sweden': 'SE',
      'Norway': 'NO',
      'Denmark': 'DK',
      'Finland': 'FI',
      'Poland': 'PL',
      'Portugal': 'PT',
      'Greece': 'GR',
      'Turkey': 'TR',
      'Singapore': 'SG',
      'Thailand': 'TH',
      'Malaysia': 'MY',
      'Indonesia': 'ID',
      'Philippines': 'PH',
      'Vietnam': 'VN',
      'New Zealand': 'NZ',
      'South Africa': 'ZA',
      'Egypt': 'EG',
      'Israel': 'IL',
      'United Arab Emirates': 'AE',
      'Saudi Arabia': 'SA',
      'Argentina': 'AR',
      'Chile': 'CL',
      'Colombia': 'CO',
      'Peru': 'PE',
    };
    return countryCodes[countryName] ?? countryName;
  }
}

// Backward compatibility alias
typedef PostalAddressSchemaData = PostalAddressSchema;
