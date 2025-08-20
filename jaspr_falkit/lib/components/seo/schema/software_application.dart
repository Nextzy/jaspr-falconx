import 'package:jaspr_falkit/lib.dart';

class SoftwareApplicationSchema extends DomComponent {
  SoftwareApplicationSchema({
    required String name,
    String? url,
    String? description,
    String? applicationCategory,
    String? applicationSubCategory,
    List<String>? operatingSystem,
    String? softwareVersion,
    Map<String, dynamic>? offers,
    Map<String, dynamic>? aggregateRating,
    String? screenshot,
    List<String>? featureList,
    String? datePublished,
    String? dateModified,
    String? downloadUrl,
    String? installUrl,
    String? releaseNotes,
    Map<String, String>? author,
    Map<String, String>? publisher,
    String? license,
    List<String>? availableLanguage,
    Map<String, String>? softwareRequirements,
    String? fileSize,
    List<Map<String, dynamic>>? review,
    Map<String, dynamic>? additionalProperties,
  }) : super(
          tag: 'script',
          attributes: const {'type': 'application/ld+json'},
          children: [
            raw(
              jsonEncode(
                {
                  '@context': 'https://schema.org',
                  '@type': 'SoftwareApplication',
                  'name': name,
                  if (url != null) 'url': url,
                  if (description != null) 'description': description,
                  if (applicationCategory != null)
                    'applicationCategory': applicationCategory,
                  if (applicationSubCategory != null)
                    'applicationSubCategory': applicationSubCategory,
                  if (operatingSystem != null && operatingSystem.isNotEmpty)
                    'operatingSystem': operatingSystem,
                  if (softwareVersion != null)
                    'softwareVersion': softwareVersion,
                  if (offers != null)
                    'offers': {
                      '@type': 'Offer',
                      ...offers,
                    },
                  if (aggregateRating != null)
                    'aggregateRating': {
                      '@type': 'AggregateRating',
                      ...aggregateRating,
                    },
                  if (screenshot != null)
                    'screenshot': {
                      '@type': 'ImageObject',
                      'url': screenshot,
                    },
                  if (featureList != null && featureList.isNotEmpty)
                    'featureList': featureList,
                  if (datePublished != null) 'datePublished': datePublished,
                  if (dateModified != null) 'dateModified': dateModified,
                  if (downloadUrl != null) 'downloadUrl': downloadUrl,
                  if (installUrl != null) 'installUrl': installUrl,
                  if (releaseNotes != null) 'releaseNotes': releaseNotes,
                  if (author != null)
                    'author': {
                      '@type': author['type'] ?? 'Person',
                      'name': author['name'],
                      if (author['url'] != null) 'url': author['url'],
                    },
                  if (publisher != null)
                    'publisher': {
                      '@type': publisher['type'] ?? 'Organization',
                      'name': publisher['name'],
                      if (publisher['url'] != null) 'url': publisher['url'],
                    },
                  if (license != null) 'license': license,
                  if (availableLanguage != null &&
                      availableLanguage.isNotEmpty)
                    'availableLanguage': availableLanguage,
                  if (softwareRequirements != null)
                    'softwareRequirements': softwareRequirements,
                  if (fileSize != null) 'fileSize': fileSize,
                  if (review != null && review.isNotEmpty)
                    'review': review
                        .map((r) => {
                              '@type': 'Review',
                              ...r,
                            })
                        .toList(),
                  if (additionalProperties != null) ...additionalProperties,
                }..removeWhere((key, value) => value == null),
              ),
            ),
          ],
        );
}

// WebApplication extends SoftwareApplication for web-specific applications
class WebApplicationSchema extends DomComponent {
  WebApplicationSchema({
    required String name,
    String? url,
    String? description,
    String? applicationCategory,
    List<String>? browserRequirements,
    List<String>? permissions,
    String? softwareVersion,
    Map<String, dynamic>? offers,
    Map<String, dynamic>? aggregateRating,
    String? screenshot,
    List<String>? featureList,
    String? datePublished,
    String? dateModified,
    Map<String, String>? author,
    Map<String, String>? publisher,
    List<String>? availableLanguage,
    Map<String, dynamic>? additionalProperties,
  }) : super(
          tag: 'script',
          attributes: const {'type': 'application/ld+json'},
          children: [
            raw(
              jsonEncode(
                {
                  '@context': 'https://schema.org',
                  '@type': 'WebApplication',
                  'name': name,
                  if (url != null) 'url': url,
                  if (description != null) 'description': description,
                  if (applicationCategory != null)
                    'applicationCategory': applicationCategory,
                  if (browserRequirements != null &&
                      browserRequirements.isNotEmpty)
                    'browserRequirements': browserRequirements.join(', '),
                  if (permissions != null && permissions.isNotEmpty)
                    'permissions': permissions.join(', '),
                  if (softwareVersion != null)
                    'softwareVersion': softwareVersion,
                  if (offers != null)
                    'offers': {
                      '@type': 'Offer',
                      ...offers,
                    },
                  if (aggregateRating != null)
                    'aggregateRating': {
                      '@type': 'AggregateRating',
                      ...aggregateRating,
                    },
                  if (screenshot != null)
                    'screenshot': {
                      '@type': 'ImageObject',
                      'url': screenshot,
                    },
                  if (featureList != null && featureList.isNotEmpty)
                    'featureList': featureList,
                  if (datePublished != null) 'datePublished': datePublished,
                  if (dateModified != null) 'dateModified': dateModified,
                  if (author != null)
                    'author': {
                      '@type': author['type'] ?? 'Person',
                      'name': author['name'],
                      if (author['url'] != null) 'url': author['url'],
                    },
                  if (publisher != null)
                    'publisher': {
                      '@type': publisher['type'] ?? 'Organization',
                      'name': publisher['name'],
                      if (publisher['url'] != null) 'url': publisher['url'],
                    },
                  if (availableLanguage != null &&
                      availableLanguage.isNotEmpty)
                    'availableLanguage': availableLanguage,
                  if (additionalProperties != null) ...additionalProperties,
                }..removeWhere((key, value) => value == null),
              ),
            ),
          ],
        );
}