import 'package:jaspr_falkit/lib.dart';

class TwitterTag {
  const TwitterTag({
    // *** Required *** //
    this.card = 'summary_large_image',
    // *** Recommend *** //
    this.site,
    this.creator,
    this.title,
    this.description,
    this.image,
    this.imageAlt,
  });

  final String? card;
  final String? site;
  final String? creator;
  final String? title;
  final String? description;
  final String? image;
  final String? imageAlt;
}

class TwitterMeta extends Fragment {
  TwitterMeta(TwitterTag tag)
      : super(
          children: [
            Meta(name: 'twitter:card', content: tag.card),
            if (tag.site.isNotNullOrBlank)
              Meta(name: 'twitter:site', content: tag.site),
            if (tag.creator.isNotNullOrBlank)
              Meta(name: 'twitter:creator', content: tag.creator),
            if (tag.title.isNotNullOrBlank)
              Meta(name: 'twitter:title', content: tag.title),
            if (tag.description.isNotNullOrBlank)
              Meta(
                  name: 'twitter:description',
                  content:
                      tag.description),
            if (tag.image.isNotNullOrBlank)
              Meta(name: 'twitter:image', content: tag.image),
            if (tag.imageAlt.isNotNullOrBlank)
              Meta(name: 'twitter:image:alt', content: tag.imageAlt),
          ],
        );
}
