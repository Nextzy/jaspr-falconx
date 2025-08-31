import 'package:jaspr_falkit/lib.dart';

class PinterestMeta extends Fragment {
  PinterestMeta({
    this.pinterestRichPin,
    this.author,
  }) : super(
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

  final String? pinterestRichPin;
  final String? author;
}
