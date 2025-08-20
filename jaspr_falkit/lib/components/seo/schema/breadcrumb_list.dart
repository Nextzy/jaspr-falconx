import 'package:jaspr_falkit/lib.dart';

class BreadcrumbSchemaItem {
  const BreadcrumbSchemaItem({
    required this.name,
    this.url,
  });

  final String name;
  final String? url;
}

class SeoBreadcrumbListSchema extends DomComponent {
  SeoBreadcrumbListSchema(List<BreadcrumbSchemaItem> items)
      : super(
          tag: 'script',
          attributes: const {'type': 'application/ld+json'},
          children: [
            raw(
              jsonEncode(
                {
                  '@context': 'https://schema.org',
                  '@type': 'BreadcrumbList',
                  'itemListElement': items
                      .asMap()
                      .entries
                      .map((entry) => {
                            '@type': 'ListItem',
                            'position': entry.key + 1,
                            if (entry.value.url != null)
                              'item': {
                                '@id': entry.value.url,
                                'name': entry.value.name,
                              }
                            else
                              'name': entry.value.name,
                          })
                      .toList(),
                },
              ),
            ),
          ],
        );
}
