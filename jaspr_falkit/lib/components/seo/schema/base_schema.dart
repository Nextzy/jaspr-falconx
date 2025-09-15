import 'package:jaspr_falkit/lib.dart';

/// Base class for all Schema.org components
abstract class Schema extends StatelessComponent {
  const Schema({
    this.id,
    required this.schemaData,
    this.additionalAttributes,
  });

  final String? id;
  final Map<String, dynamic>? additionalAttributes;
  final Map<String, dynamic> schemaData;

  /// Helper method to create image object
  static Map<String, dynamic> createImageObject(String url) {
    return {
      '@type': 'ImageObject',
      'url': url,
    };
  }

  @override
  Component build(BuildContext context) => Component.element(
    tag: 'script',
    attributes: {
      'type': 'application/ld+json',
      if (additionalAttributes != null)
        ...additionalAttributes!.map(
          (key, value) => MapEntry(key, value.toString()),
        ),
    },
    children: [
      raw(
        jsonEncode(
          Map<String, dynamic>.from(
            schemaData,
          )..removeWhere((k, v) => v == null),
        ),
      ),
    ],
  );
}

/// Schema Group component for @graph support
class SchemaGroup extends Schema {
  SchemaGroup({
    super.id,
    required List<Schema> schemas,
    String context = 'https://schema.org',
  }) : super(
         schemaData: {
           '@context': context,
           '@graph': schemas
               .map((schema) => schema.schemaData..remove('@context'))
               .toList(),
         },
       );

  /// Factory for common website + organization combo
  factory SchemaGroup.websiteWithOrganization({
    required String websiteName,
    required String websiteUrl,
    required String organizationName,
    String? organizationUrl,
    String? organizationLogo,
    List<String>? socialProfiles,
    String? searchUrlTemplate,
  }) {
    // Add organization
    final schemas = <Schema>[
      GenericSchema(
        data: {
          '@type': 'Organization',
          '@id': '${organizationUrl ?? websiteUrl}#organization',
          'name': organizationName,
          'url': organizationUrl ?? websiteUrl,
          if (organizationLogo != null)
            'logo': Schema.createImageObject(organizationLogo),
          if (socialProfiles != null && socialProfiles.isNotEmpty)
            'sameAs': socialProfiles,
        },
      ),
      // Add website
      GenericSchema(
        data: {
          '@type': 'WebSite',
          '@id': '$websiteUrl#website',
          'url': websiteUrl,
          'name': websiteName,
          'publisher': {
            '@id': '${organizationUrl ?? websiteUrl}#organization',
          },
          if (searchUrlTemplate != null)
            'potentialAction': {
              '@type': 'SearchAction',
              'target': {
                '@type': 'EntryPoint',
                'urlTemplate': searchUrlTemplate,
              },
              'query-input': 'required name=search_term_string',
            },
        },
      ),
    ];

    return SchemaGroup(schemas: schemas);
  }

  /// Factory for article with breadcrumb
  factory SchemaGroup.articleWithBreadcrumb({
    required String headline,
    required String url,
    required String datePublished,
    required Map<String, dynamic> author,
    required List<BreadcrumbItem> breadcrumbItems,
    String? description,
    String? dateModified,
    Map<String, dynamic>? publisher,
    String? image,
    List<String>? keywords,
  }) {
    final schemas = <Schema>[
      // Add breadcrumb
      GenericSchema(
        data: {
          '@type': 'BreadcrumbList',
          'itemListElement': breadcrumbItems
              .asMap()
              .entries
              .map(
                (entry) => {
                  '@type': 'ListItem',
                  'position': entry.key + 1,
                  'name': entry.value.name,
                  'item': entry.value.url,
                },
              )
              .toList(),
        },
      ),
      // Add article
      GenericSchema(
        data: {
          '@type': 'Article',
          'headline': headline,
          'url': url,
          'datePublished': datePublished,
          'author': author,
          if (description != null) 'description': description,
          if (dateModified != null) 'dateModified': dateModified,
          if (publisher != null) 'publisher': publisher,
          if (image != null) 'image': Schema.createImageObject(image),
          if (keywords != null && keywords.isNotEmpty)
            'keywords': keywords.join(', '),
        },
      ),
    ];

    return SchemaGroup(schemas: schemas);
  }

  /// Factory for blog with recent posts
  factory SchemaGroup.blogWithPosts({
    required String blogName,
    required String blogUrl,
    required Map<String, dynamic> publisher,
    required List<Map<String, dynamic>> recentPosts,
    String? description,
    String? inLanguage,
  }) {
    final schemas = <Schema>[
      // Add blog
      GenericSchema(
        data: {
          '@type': 'Blog',
          '@id': '$blogUrl#blog',
          'url': blogUrl,
          'name': blogName,
          if (description != null) 'description': description,
          'publisher': publisher,
          if (inLanguage != null) 'inLanguage': inLanguage,
          'blogPost': recentPosts
              .map((post) => {'@id': '${post['url']}#article'})
              .toList(),
        },
      ),
    ];

    // Add each blog post
    for (final post in recentPosts) {
      schemas.add(
        GenericSchema(
          data: {
            '@type': 'BlogPosting',
            '@id': '${post['url']}#article',
            ...post,
            'isPartOf': {'@id': '$blogUrl#blog'},
          },
        ),
      );
    }

    return SchemaGroup(schemas: schemas);
  }
}

/// Generic schema wrapper for arbitrary schema data
class GenericSchema extends Schema {
  GenericSchema({
    required Map<String, dynamic> data,
  }) : super(schemaData: data);
}
