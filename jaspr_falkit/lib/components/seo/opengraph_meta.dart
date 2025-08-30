import 'package:jaspr_falkit/lib.dart';

class DefaultOpenGraphTag {
  const DefaultOpenGraphTag({
    // *** Required *** //
    this.title,
    this.type,
    this.url,
    this.imageUrl,
    // *** Recommend *** //
    this.description,
    this.siteName,
    this.locale,
    // *** Optional *** //
    this.imageWidth = '1200',
    this.imageHeight = '630',
    this.imageAlt,
    this.video,
  });

  final String? title;
  final OgType? type;
  final String? url;
  final String? imageUrl;
  final String? description;
  final String? siteName;
  final String? locale;
  final String imageWidth;
  final String imageHeight;
  final String? imageAlt;
  final String? video;
}

class DefaultOpenGraphMeta extends Fragment {
  DefaultOpenGraphMeta(DefaultOpenGraphTag tag)
    : super(
        children: [
          if (tag.type != null)
            Meta(property: 'og:type', content: tag.type?.name),
          if (tag.title.isNotNullOrBlank)
            Meta(property: 'og:title', content: tag.title),
          if (tag.description.isNotNullOrBlank)
            Meta(property: 'og:description', content: tag.description!),
          if (tag.url.isNotNullOrBlank)
            Meta(property: 'og:url', content: tag.url),
          if (tag.imageUrl.isNotNullOrBlank)
            Meta(property: 'og:image', content: tag.imageUrl),
          if (tag.imageUrl.isNotNullOrBlank)
            link(rel: 'preload', href: tag.imageUrl!, as: 'image'),
          if ((tag.siteName ?? tag.title).isNotNullOrBlank)
            Meta(property: 'og:site_name', content: tag.siteName ?? tag.title),
          if (tag.locale.isNotNullOrBlank)
            Meta(property: 'og:locale', content: tag.locale),
          Meta(property: 'og:image:width', content: tag.imageWidth),
          Meta(property: 'og:image:height', content: tag.imageHeight),
          if ((tag.imageAlt ?? tag.description).isNotNullOrBlank)
            Meta(
              property: 'og:image:alt',
              content: tag.imageAlt ?? tag.description,
            ),
          if (tag.video.isNotNullOrBlank)
            Meta(property: 'og:video', content: tag.video),
        ],
      );
}

class ArticleOpenGraphTag {
  const ArticleOpenGraphTag({
    this.author,
    this.section,
    this.tags,
    this.publishedTime,
    this.modifiedTime,
  });

  final String? author;
  final String? section;
  final List<String>? tags;
  final DateTime? publishedTime;
  final DateTime? modifiedTime;
}

class ArticleOpenGraphMeta extends Fragment {
  ArticleOpenGraphMeta(ArticleOpenGraphTag tag)
    : super(
        children: [
          if (tag.author.isNotNullOrBlank)
            Meta(property: 'article:author', content: tag.author),
          if (tag.section.isNotNullOrBlank)
            Meta(property: 'article:section', content: tag.section),
          if (tag.tags != null && tag.tags!.isNotEmpty)
            ...tag.tags!.map((t) => Meta(property: 'article:tag', content: t)),
          if (tag.publishedTime != null)
            Meta(
              property: 'article:published_time',
              content: tag.publishedTime!.toIso8601String(),
            ),
          if (tag.modifiedTime != null)
            Meta(
              property: 'article:modified_time',
              content: tag.modifiedTime!.toIso8601String(),
            ),
        ],
      );
}
