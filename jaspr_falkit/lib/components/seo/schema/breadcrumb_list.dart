import 'package:jaspr_falkit/components/seo/schema/base_schema.dart';
import 'package:jaspr_falkit/lib.dart';

/// BreadcrumbList schema component for navigation breadcrumbs
class BreadcrumbListSchema extends Schema {
  new({required this.items, this.additionalProperties})
    : super(
        schemaData: {
          '@context': 'https://schema.org',
          '@type': 'BreadcrumbList',
          'itemListElement': _processItems(items),
          ...?additionalProperties,
        },
      );

  /// Factory constructor for simple breadcrumbs from strings
  factory fromStrings(List<String> breadcrumbs) {
    final items = breadcrumbs
        .map((name) => BreadcrumbItem(name: name))
        .toList();
    return BreadcrumbListSchema(items: items);
  }

  /// Factory constructor for breadcrumbs with URLs
  factory withUrls(List<Map<String, String>> breadcrumbs) {
    final items = breadcrumbs
        .map((item) => BreadcrumbItem(name: item['name']!, url: item['url']))
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
            // Per schema.org BreadcrumbList, every ListItem must expose the
            // crumb as a Thing (with @type/@id/name). Using a Thing object
            // — instead of a bare URL — keeps the door open for richer
            // metadata (image, additional ids) without breaking consumers.
            if (entry.value.url != null)
              'item': {
                '@type': 'Thing',
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
  const new({required this.name, this.url});

  final String name;
  final String? url;
}
