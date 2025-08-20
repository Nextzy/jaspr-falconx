import 'package:jaspr_falkit/lib.dart';

class WebPageSchema {
  const WebPageSchema({
    this.name,
    this.description,
    this.url,
    this.inLanguage,
    this.datePublished,
    this.dateModified,
    this.author,
    this.authorType,
    this.publisher,
    this.publisherType,
    this.publisherLogo,
    this.keywords,
    this.imageUrl,
    this.breadcrumb,
    this.mainEntity,
    this.additionalProperties,
  });

  final String? name;
  final String? description;
  final String? url;
  final String? inLanguage;
  final DateTime? datePublished;
  final DateTime? dateModified;
  final String? author;
  final String? authorType;
  final String? publisher;
  final String? publisherType;
  final String? publisherLogo;
  final List<String>? keywords;
  final String? imageUrl;
  final Map<String, dynamic>? breadcrumb;
  final Map<String, dynamic>? mainEntity;
  final Map<String, dynamic>? additionalProperties;
}

class SeoWebPageSchema extends DomComponent {
  SeoWebPageSchema(WebPageSchema tag)
      : super(
          tag: 'script',
          attributes: const {'type': 'application/ld+json'},
          children: [
            raw(
              jsonEncode(
                {
                  '@context': 'https://schema.org',
                  '@type': 'WebPage',
                  if (tag.name.isNotNullOrBlank) 'name': tag.name,
                  if (tag.description.isNotNullOrBlank)
                    'description': tag.description,
                  if (tag.url.isNotNullOrBlank) 'url': tag.url,
                  if (tag.inLanguage.isNotNullOrBlank)
                    'inLanguage': tag.inLanguage,
                  if (tag.datePublished != null)
                    'datePublished': tag.datePublished!.toIso8601String(),
                  if (tag.dateModified != null)
                    'dateModified': tag.dateModified!.toIso8601String(),
                  if (tag.author.isNotNullOrBlank)
                    'author': {
                      '@type': tag.authorType ?? 'Person',
                      'name': tag.author,
                    },
                  if (tag.publisher.isNotNullOrBlank)
                    'publisher': {
                      '@type': tag.publisherType ?? 'Organization',
                      'name': tag.publisher,
                      if (tag.publisherLogo.isNotNullOrBlank)
                        'logo': {
                          '@type': 'ImageObject',
                          'url': tag.publisherLogo,
                        },
                    },
                  if (tag.keywords != null && tag.keywords!.isNotEmpty)
                    'keywords':
                        tag.keywords!.map((str) => str.trim()).join(', '),
                  if (tag.imageUrl.isNotNullOrBlank)
                    'primaryImageOfPage': {
                      '@type': 'ImageObject',
                      'url': tag.imageUrl,
                    },
                  if (tag.breadcrumb != null) 'breadcrumb': tag.breadcrumb,
                  if (tag.mainEntity != null) 'mainEntity': tag.mainEntity,
                  if (tag.additionalProperties != null)
                    ...tag.additionalProperties!,
                }..removeWhere((k, v) => v == null),
              ),
            ),
          ],
        );
}
