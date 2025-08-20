import 'package:jaspr_falkit/lib.dart';

class BlogSchema {
  const BlogSchema({
    this.name,
    this.description,
    this.url,
    this.publisher,
    this.publisherType,
    this.publisherLogo,
    this.inLanguage,
    this.blogPost,
    this.author,
    this.authorType,
    this.dateCreated,
    this.dateModified,
    this.keywords,
    this.imageUrl,
    this.additionalProperties,
  });

  final String? name;
  final String? description;
  final String? url;
  final String? publisher;
  final String? publisherType;
  final String? publisherLogo;
  final String? inLanguage;
  final List<BlogPostingSchema>? blogPost;
  final String? author;
  final String? authorType;
  final DateTime? dateCreated;
  final DateTime? dateModified;
  final List<String>? keywords;
  final String? imageUrl;
  final Map<String, dynamic>? additionalProperties;
}

class SeoBlogSchema extends DomComponent {
  SeoBlogSchema(BlogSchema tag)
      : super(
          tag: 'script',
          attributes: const {'type': 'application/ld+json'},
          children: [
            raw(
              jsonEncode(
                {
                  '@context': 'https://schema.org',
                  '@type': 'Blog',
                  if (tag.name.isNotNullOrBlank) 'name': tag.name,
                  if (tag.description.isNotNullOrBlank)
                    'description': tag.description,
                  if (tag.url.isNotNullOrBlank) 'url': tag.url,
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
                  if (tag.inLanguage.isNotNullOrBlank)
                    'inLanguage': tag.inLanguage,
                  if (tag.blogPost != null &&
                      (tag.blogPost?.isNotEmpty ?? false))
                    'blogPost': tag.blogPost!
                        .map((post) => post.toJsonForEmbedding())
                        .toList(),
                  if (tag.author.isNotNullOrBlank)
                    'author': {
                      '@type': tag.authorType ?? 'Person',
                      'name': tag.author,
                    },
                  if (tag.dateCreated != null)
                    'dateCreated': tag.dateCreated!.toIso8601String(),
                  if (tag.dateModified != null)
                    'dateModified': tag.dateModified!.toIso8601String(),
                  if (tag.keywords != null &&
                      (tag.keywords?.isNotEmpty ?? false))
                    'keywords': tag.keywords!.join(', '),
                  if (tag.imageUrl.isNotNullOrBlank)
                    'image': {
                      '@type': 'ImageObject',
                      'url': tag.imageUrl,
                    },
                  if (tag.additionalProperties != null)
                    ...tag.additionalProperties!,
                }..removeWhere((k, v) => v == null),
              ),
            ),
          ],
        );
}
