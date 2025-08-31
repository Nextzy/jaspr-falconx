import 'package:jaspr_falkit/lib.dart';

class DefaultMeta extends Fragment {
  DefaultMeta({
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
  }) : super(
         children: [
           if (title.isNotNullOrBlank)
             DomComponent(
               id: title?.hashStr(length: 5),
               tag: 'title',
               child: raw(title!),
             ),
           if (description.isNotNullOrBlank)
             Meta(
               name: 'description',
               content: description,
               unique: true,
             ),
           if (keywords != null && keywords.isNotEmpty)
             Meta(
               name: 'keywords',
               content: keywords.map((str) => str.trim()).join(', '),
               unique: true,
             ),
           if (publisher.isNotNullOrBlank)
             Meta(
               name: 'publisher',
               content: publisher,
               unique: true,
             ),
           if (author.isNotNullOrBlank)
             Meta(
               name: 'author',
               content: author,
               unique: true,
             ),
           if (robots.isNotNullOrBlank)
             Meta(
               name: 'robots',
               content: robots,
               unique: true,
             ),
           if (canonical.isNotNullOrBlank)
             LinkHeader(
               rel: 'canonical',
               href: canonical!,
               unique: true,
             ),
           if (favicon.isNotNullOrBlank)
             LinkHeader(
               rel: 'icon',
               href: favicon!,
               attributes: {
                 'sizes': 'any',
               },
               unique: true,
             ),
           if (faviconSvg.isNotNullOrBlank)
             LinkHeader(
               rel: 'icon',
               href: faviconSvg!,
               attributes: {
                 'type': 'image/svg+xml',
               },
               unique: true,
             ),
           if (themeColor.isNotNullOrBlank)
             Meta(
               name: 'theme-color',
               content: themeColor,
               unique: true,
             ),
           if (manifest.isNotNullOrBlank)
             LinkHeader(
               rel: 'manifest',
               href: manifest!,
               unique: true,
             ),
           if (imageSrc.isNotNullOrBlank)
             LinkHeader(
               rel: 'image_src',
               href: imageSrc!,
               unique: true,
             ),
         ],
       );

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
