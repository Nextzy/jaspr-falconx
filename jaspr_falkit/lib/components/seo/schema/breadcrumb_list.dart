import 'package:jaspr_falkit/lib.dart';
import 'package:jaspr_falkit/components/seo/schema/base_schema.dart';

class BreadcrumbSchemaItem {
  const BreadcrumbSchemaItem({
    required this.name,
    this.url,
  });

  final String name;
  final String? url;
}

class BreadcrumbListSchema extends Schema {
  BreadcrumbListSchema(List<BreadcrumbSchemaItem> items)
      : super(
          schemaData: {
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
        );
}
