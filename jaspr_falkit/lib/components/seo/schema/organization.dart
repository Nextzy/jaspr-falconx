import 'package:jaspr_falkit/lib.dart';

class OrganizationSchema extends DomComponent {
  OrganizationSchema({
    required String name,
    String? url,
    String? logo,
    String? description,
    String? email,
    String? telephone,
    Map<String, String>? address,
    List<String>? sameAs,
    String? foundingDate,
    List<Map<String, String>>? founders,
    String? legalName,
    String? taxID,
    String? vatID,
    Map<String, dynamic>? additionalProperties,
  }) : super(
          tag: 'script',
          attributes: const {'type': 'application/ld+json'},
          children: [
            raw(
              jsonEncode(
                {
                  '@context': 'https://schema.org',
                  '@type': 'Organization',
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
                  if (address != null)
                    'address': {
                      '@type': 'PostalAddress',
                      ...address,
                    },
                  if (sameAs != null && sameAs.isNotEmpty) 'sameAs': sameAs,
                  if (foundingDate != null) 'foundingDate': foundingDate,
                  if (founders != null && founders.isNotEmpty)
                    'founder': founders
                        .map((founder) => {
                              '@type': 'Person',
                              ...founder,
                            })
                        .toList(),
                  if (legalName != null) 'legalName': legalName,
                  if (taxID != null) 'taxID': taxID,
                  if (vatID != null) 'vatID': vatID,
                  if (additionalProperties != null) ...additionalProperties,
                }..removeWhere((key, value) => value == null),
              ),
            ),
          ],
        );
}