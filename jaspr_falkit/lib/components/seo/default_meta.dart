import 'package:jaspr_falkit/lib.dart';

class DefaultTag {
  const DefaultTag({
    this.title,
    this.description,
    this.keywords,
    this.author,
    this.robots,
    this.publisher,
    this.canonical,
    this.favicon,
    this.faviconSvg,
    this.themeColor,
    this.manifest,
    this.imageSrc,
  });

  final String? title;
  final String? description;
  final List<String>? keywords;
  final String? author;
  final String? robots;
  final String? publisher;
  final String? canonical;
  final String? favicon;
  final String? faviconSvg;
  final String? themeColor;
  final String? manifest;
  final String? imageSrc;
}

class DefaultMeta extends Fragment {
  DefaultMeta(DefaultTag tag)
      : super(
          children: [
            if (tag.title.isNotNullOrBlank)
              DomComponent(tag: 'title', child: raw(tag.title!)),
            if (tag.description.isNotNullOrBlank)
              Meta(name: 'description', content: tag.description),
            if (tag.keywords != null && tag.keywords!.isNotEmpty)
              Meta(
                  name: 'keywords',
                  content: tag.keywords!.map((str) => str.trim()).join(', ')),
            if (tag.publisher.isNotNullOrBlank)
              Meta(name: 'publisher', content: tag.publisher),
            if (tag.author.isNotNullOrBlank)
              Meta(name: 'author', content: tag.author),
            if (tag.robots.isNotNullOrBlank)
              Meta(name: 'robots', content: tag.robots),
            if (tag.canonical.isNotNullOrBlank)
              link(rel: 'canonical', href: tag.canonical!),
            if (tag.favicon.isNotNullOrBlank)
              link(rel: 'icon', href: tag.favicon!, attributes: {
                'sizes': 'any',
              }),
            if (tag.faviconSvg.isNotNullOrBlank)
              link(rel: 'icon', href: tag.faviconSvg!, attributes: {
                'type': 'image/svg+xml',
              }),
            if (tag.themeColor.isNotNullOrBlank)
              Meta(name: 'theme-color', content: tag.themeColor),
            if (tag.manifest.isNotNullOrBlank)
              link(id: 'manifest', rel: 'manifest', href: tag.manifest!),
            if (tag.imageSrc.isNotNullOrBlank)
              link(id: 'image_src', rel: 'image_src', href: tag.imageSrc!),
          ],
        );
}
