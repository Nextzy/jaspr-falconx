import 'package:jaspr_falkit/lib.dart';

class TwitterMeta extends Fragment {
  TwitterMeta({
    // *** Required *** //
    this.card = 'summary_large_image',
    // *** Recommend *** //
    this.site,
    this.creator,
    this.title,
    this.description,
    this.image,
    this.imageAlt,
  }) : super(
         children: [
           Meta(
             name: 'twitter:card',
             content: card,
             unique: true,
           ),
           if (site.isNotNullOrBlank)
             Meta(
               name: 'twitter:site',
               content: site,
               unique: true,
             ),
           if (creator.isNotNullOrBlank)
             Meta(
               name: 'twitter:creator',
               content: creator,
               unique: true,
             ),
           if (title.isNotNullOrBlank)
             Meta(
               name: 'twitter:title',
               content: title,
               unique: true,
             ),
           if (description.isNotNullOrBlank)
             Meta(
               name: 'twitter:description',
               content: description,
               unique: true,
             ),
           if (image.isNotNullOrBlank)
             Meta(
               name: 'twitter:image',
               content: image,
               unique: true,
             ),
           if (imageAlt.isNotNullOrBlank)
             Meta(
               name: 'twitter:image:alt',
               content: imageAlt,
             ),
         ],
       );

  final String? card;
  final String? site;
  final String? creator;
  final String? title;
  final String? description;
  final String? image;
  final String? imageAlt;
}
