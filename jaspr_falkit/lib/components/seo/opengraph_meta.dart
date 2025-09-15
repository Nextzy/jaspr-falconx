import 'package:jaspr_falkit/lib.dart';

class DefaultOpenGraphMeta extends StatelessComponent {
  const DefaultOpenGraphMeta({
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

  @override
  Component build(BuildContext context) => Document.head(
    children: [
      if (type != null)
        Meta(
          property: 'og:type',
          content: type!.name,
          unique: true,
        ),
      if (title.isNotNullOrBlank)
        Meta(
          property: 'og:title',
          content: title,
          unique: true,
        ),
      if (description.isNotNullOrBlank)
        Meta(
          property: 'og:description',
          content: description,
          unique: true,
        ),
      if (url.isNotNullOrBlank)
        Meta(
          property: 'og:url',
          content: url,
          unique: true,
        ),
      if (imageUrl.isNotNullOrBlank)
        Meta(
          property: 'og:image',
          content: imageUrl,
          unique: true,
        ),
      if (imageUrl.isNotNullOrBlank)
        LinkHeader(
          rel: 'preload',
          href: imageUrl!,
          as: 'image',
        ),
      if ((siteName ?? title).isNotNullOrBlank)
        Meta(
          property: 'og:site_name',
          content: siteName ?? title,
          unique: true,
        ),
      if (locale.isNotNullOrBlank)
        Meta(
          property: 'og:locale',
          content: locale,
          unique: true,
        ),
      Meta(
        property: 'og:image:width',
        content: imageWidth,
        unique: true,
      ),
      Meta(
        property: 'og:image:height',
        content: imageHeight,
        unique: true,
      ),
      if ((imageAlt ?? description).isNotNullOrBlank)
        Meta(
          property: 'og:image:alt',
          content: imageAlt ?? description,
          unique: true,
        ),
      if (video.isNotNullOrBlank)
        Meta(
          property: 'og:video',
          content: video,
          unique: true,
        ),
    ],
  );
}

class ArticleOpenGraphMeta extends StatelessComponent {
  const ArticleOpenGraphMeta({
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

  @override
  Component build(BuildContext context) => Document.head(
      children: [
        if (author.isNotNullOrBlank)
          Meta(property: 'article:author', content: author),
        if (section.isNotNullOrBlank)
          Meta(property: 'article:section', content: section),
        if (tags != null && tags.isNotNullOrEmpty)
          ...tags!.map((t) => Meta(property: 'article:tag', content: t)),
        if (publishedTime != null)
          Meta(
            property: 'article:published_time',
            content: publishedTime!.toIso8601String(),
          ),
        if (modifiedTime != null)
          Meta(
            property: 'article:modified_time',
            content: modifiedTime!.toIso8601String(),
          ),
      ],
    );
}
