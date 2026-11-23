import 'package:jaspr_falkit/lib.dart';

class MicrosoftMeta extends StatelessComponent {
  const MicrosoftMeta({this.msValidate, this.tileColor, this.tileImageUrl});

  final String? msValidate;
  final String? tileColor;
  final String? tileImageUrl;

  @override
  Component build(BuildContext context) => Document.head(
    children: [
      if (msValidate.isNotNullOrBlank)
        Meta(name: 'msvalidate.01', content: msValidate, unique: true),
      if (tileColor.isNotNullOrBlank)
        Meta(name: 'msapplication-TileColor', content: tileColor, unique: true),
      if (tileImageUrl.isNotNullOrBlank)
        Meta(
          name: 'msapplication-TileImage',
          content: tileImageUrl,
          unique: true,
        ),
    ],
  );
}
