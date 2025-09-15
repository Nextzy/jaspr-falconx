import 'package:jaspr_falkit/lib.dart';

class PinterestMeta extends StatelessComponent {
  const PinterestMeta({
    this.pinterestRichPin,
    this.author,
  });

  final String? pinterestRichPin;
  final String? author;

  @override
  Component build(BuildContext context) => Document.head(
    children: [
      Meta(
        name: 'pinterest-rich-pin',
        content: pinterestRichPin ?? 'true',
        unique: true,
      ),
      if (author.isNotNullOrBlank)
        Meta(
          property: 'article:author',
          content: author,
          unique: true,
        ),
    ],
  );
}
