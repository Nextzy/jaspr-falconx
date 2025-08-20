
import 'package:jaspr_falkit/lib.dart';

class ArticleSchema {
  const ArticleSchema({
    this.headline,
    this.alternativeHeadline,
    this.description,
    this.datePublished,
    this.dateModified,
    this.author,
    this.authorType,
    this.publisher,
    this.publisherType,
    this.publisherLogo,
    this.url,
    this.imageUrl,
    this.keywords,
    this.articleSection,
    this.wordCount,
    this.timeRequired,
    this.inLanguage,
    this.additionalProperties,
  });

  final String? headline;
  final String? alternativeHeadline;
  final String? description;
  final DateTime? datePublished;
  final DateTime? dateModified;
  final String? author;
  final String? authorType;
  final String? publisher;
  final String? publisherType;
  final String? publisherLogo;
  final String? url;
  final String? imageUrl;
  final List<String>? keywords;
  final String? articleSection;
  final int? wordCount;
  final String? timeRequired;
  final String? inLanguage;
  final Map<String, dynamic>? additionalProperties;
}

class SeoArticleSchemaOrg extends DomComponent {
  SeoArticleSchemaOrg(ArticleSchema tag)
      : super(
          tag: 'script',
          attributes: const {'type': 'application/ld+json'},
          children: [
            raw(
              jsonEncode(
                {
                  '@context': 'https://schema.org',
                  '@type': 'Article',
                  'headline': tag.headline,
                  if (tag.alternativeHeadline.isNotNullOrBlank)
                    'alternativeHeadline': tag.alternativeHeadline,
                  if (tag.description.isNotNullOrBlank)
                    'description': tag.description,
                  if (tag.datePublished != null)
                    'datePublished': tag.datePublished?.toIso8601String(),
                  if (tag.dateModified != null)
                    'dateModified': (tag.dateModified ?? tag.datePublished)
                        ?.toIso8601String(),
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
                  if (tag.url.isNotNullOrBlank) 'url': tag.url,
                  if (tag.imageUrl.isNotNullOrBlank)
                    'image': {
                      '@type': 'ImageObject',
                      'url': tag.imageUrl,
                    },
                  if (tag.keywords != null && tag.keywords!.isNotEmpty)
                    'keywords': tag.keywords!.join(', '),
                  if (tag.articleSection.isNotNullOrBlank)
                    'articleSection': tag.articleSection,
                  if (tag.wordCount != null) 'wordCount': tag.wordCount,
                  if (tag.timeRequired.isNotNullOrBlank)
                    'timeRequired': tag.timeRequired,
                  if (tag.inLanguage.isNotNullOrBlank)
                    'inLanguage': tag.inLanguage,
                  if (tag.additionalProperties != null)
                    ...tag.additionalProperties!,
                }..removeWhere((k, v) => v == null),
              ),
            ),
          ],
        );
}
