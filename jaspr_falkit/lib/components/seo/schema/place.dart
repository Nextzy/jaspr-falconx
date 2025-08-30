import 'package:jaspr_falkit/lib.dart';
import 'package:jaspr_falkit/components/seo/schema/base_schema.dart';

/// Place schema for representing physical locations
class PlaceSchema extends Schema {
  PlaceSchema({
    String? name,
    String? description,
    Map<String, String>? address,
    Map<String, String>? geo,
    String? telephone,
    String? url,
    String? image,
    String? openingHours,
    String? publicAccess,
    String? smokingAllowed,
    String? maximumAttendeeCapacity,
    Map<String, String>? containedInPlace,
    Map<String, String>? containsPlace,
    List<Map<String, String>>? events,
    String? isAccessibleForFree,
    Map<String, dynamic>? additionalProperties,
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'Place',
           if (name != null) 'name': name,
           if (description != null) 'description': description,
           if (address != null)
             'address': {
               '@type': 'PostalAddress',
               ...address,
             },
           if (geo != null)
             'geo': {
               '@type': 'GeoCoordinates',
               ...geo,
             },
           if (telephone != null) 'telephone': telephone,
           if (url != null) 'url': url,
           if (image != null)
             'image': {
               '@type': 'ImageObject',
               'url': image,
             },
           if (openingHours != null) 'openingHours': openingHours,
           if (publicAccess != null) 'publicAccess': publicAccess,
           if (smokingAllowed != null) 'smokingAllowed': smokingAllowed,
           if (maximumAttendeeCapacity != null)
             'maximumAttendeeCapacity': maximumAttendeeCapacity,
           if (containedInPlace != null)
             'containedInPlace': {
               '@type': 'Place',
               ...containedInPlace,
             },
           if (containsPlace != null)
             'containsPlace': {
               '@type': 'Place',
               ...containsPlace,
             },
           if (events != null && events.isNotEmpty)
             'event': events
                 .map(
                   (event) => {
                     '@type': 'Event',
                     ...event,
                   },
                 )
                 .toList(),
           if (isAccessibleForFree != null) 'isAccessibleForFree': isAccessibleForFree,
           if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Creates a basic place schema
  factory PlaceSchema.basic({
    required String name,
    String? description,
    Map<String, String>? address,
    String? telephone,
    String? url,
  }) {
    return PlaceSchema(
      name: name,
      description: description,
      address: address,
      telephone: telephone,
      url: url,
    );
  }

  /// Creates a business location schema
  factory PlaceSchema.businessLocation({
    required String name,
    required Map<String, String> address,
    String? description,
    String? telephone,
    String? url,
    String? image,
    String? openingHours,
    Map<String, String>? geo,
  }) {
    return PlaceSchema(
      name: name,
      description: description,
      address: address,
      telephone: telephone,
      url: url,
      image: image,
      openingHours: openingHours,
      geo: geo,
    );
  }

  /// Creates an event venue schema
  factory PlaceSchema.eventVenue({
    required String name,
    required Map<String, String> address,
    String? description,
    String? maximumAttendeeCapacity,
    String? publicAccess,
    String? isAccessibleForFree,
    List<Map<String, String>>? events,
  }) {
    return PlaceSchema(
      name: name,
      description: description,
      address: address,
      maximumAttendeeCapacity: maximumAttendeeCapacity,
      publicAccess: publicAccess,
      isAccessibleForFree: isAccessibleForFree,
      events: events,
    );
  }

  /// Helper method to create a place as Map for use in other schemas
  static Map<String, dynamic> toMap({
    String? name,
    String? description,
    String? telephone,
    String? url,
    Map<String, dynamic>? address,
    Map<String, dynamic>? geo,
    String? image,
  }) {
    return {
      '@type': 'Place',
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (telephone != null) 'telephone': telephone,
      if (url != null) 'url': url,
      if (address != null) 'address': address,
      if (geo != null) 'geo': geo,
      if (image != null)
        'image': {
          '@type': 'ImageObject',
          'url': image,
        },
    }..removeWhere((key, value) => value == null);
  }

  /// Helper method to create geo coordinates
  static Map<String, String> createGeoCoordinates({
    required String latitude,
    required String longitude,
    String? elevation,
  }) {
    final map = <String, String>{
      'latitude': latitude,
      'longitude': longitude,
    };
    if (elevation != null) map['elevation'] = elevation;
    return map;
  }

  /// Helper method to create opening hours specification
  static List<Map<String, dynamic>> createOpeningHoursSpecification({
    required List<OpeningHours> hours,
  }) {
    return hours
        .map(
          (h) => {
            '@type': 'OpeningHoursSpecification',
            'dayOfWeek': h.dayOfWeek,
            'opens': h.opens,
            'closes': h.closes,
            if (h.validFrom != null) 'validFrom': h.validFrom,
            if (h.validThrough != null) 'validThrough': h.validThrough,
          },
        )
        .toList();
  }
}

/// Helper class for opening hours
class OpeningHours {
  final List<String> dayOfWeek;
  final String opens;
  final String closes;
  final String? validFrom;
  final String? validThrough;

  const OpeningHours({
    required this.dayOfWeek,
    required this.opens,
    required this.closes,
    this.validFrom,
    this.validThrough,
  });
}