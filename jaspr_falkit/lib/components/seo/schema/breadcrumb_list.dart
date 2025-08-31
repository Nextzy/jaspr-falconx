import 'package:jaspr_falkit/components/seo/schema/base_schema.dart';
import 'package:jaspr_falkit/lib.dart';

/// BreadcrumbList schema component for navigation breadcrumbs
class BreadcrumbListSchema extends Schema {
  BreadcrumbListSchema({
    required this.items,
    this.additionalProperties,
  }) : super(
         schemaData: {
           '@context': 'https://schema.org',
           '@type': 'BreadcrumbList',
           'itemListElement': _processItems(items),
           if (additionalProperties != null) ...additionalProperties,
         },
       );

  /// Factory constructor for simple breadcrumbs from strings
  factory BreadcrumbListSchema.fromStrings(List<String> breadcrumbs) {
    final items = breadcrumbs
        .map((name) => BreadcrumbItem(name: name))
        .toList();
    return BreadcrumbListSchema(items: items);
  }

  /// Factory constructor for breadcrumbs with URLs
  factory BreadcrumbListSchema.withUrls(List<Map<String, String>> breadcrumbs) {
    final items = breadcrumbs
        .map(
          (item) => BreadcrumbItem(
            name: item['name']!,
            url: item['url'],
          ),
        )
        .toList();
    return BreadcrumbListSchema(items: items);
  }

  final List<BreadcrumbItem> items;
  final Map<String, dynamic>? additionalProperties;

  static List<Map<String, dynamic>> _processItems(List<BreadcrumbItem> items) {
    return items
        .asMap()
        .entries
        .map(
          (entry) => {
            '@type': 'ListItem',
            'position': entry.key + 1,
            if (entry.value.url != null)
              'item': {
                '@id': entry.value.url,
                'name': entry.value.name,
              }
            else
              'name': entry.value.name,
          },
        )
        .toList();
  }
}

/// Individual breadcrumb item
class BreadcrumbItem {
  const BreadcrumbItem({
    required this.name,
    this.url,
  });

  final String name;
  final String? url;
}
