import 'package:jaspr_falkit/lib.dart';

class PinterestTag {
  const PinterestTag({
    this.pinterestRichPin,
    this.author,
  });

  final String? pinterestRichPin;
  final String? author;
}

class PinterestMeta extends Fragment {
  PinterestMeta(PinterestTag tag)
      : super(
          children: [
            Meta(
                name: 'pinterest-rich-pin',
                content: tag.pinterestRichPin ?? 'true'),
            if (tag.author.isNotNullOrBlank)
              Meta(property: 'article:author', content: tag.author),
          ],
        );
}
