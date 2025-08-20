import 'package:jaspr_falkit/lib.dart';

class MicrosoftTag {
  const MicrosoftTag({
    this.msValidate = 'verification_token',
    this.tileColor,
    this.tileImageUrl,
  });

  final String msValidate;
  final String? tileColor;
  final String? tileImageUrl;
}

class MicrosoftMeta extends Fragment {
  MicrosoftMeta(MicrosoftTag tag)
      : super(
          children: [
            Meta(name: 'msvalidate.01', content: tag.msValidate),
            if (tag.tileColor.isNotNullOrBlank)
              Meta(name: 'msapplication-TileColor', content: tag.tileColor),
            if (tag.tileImageUrl.isNotNullOrBlank)
              Meta(name: 'msapplication-TileImage', content: tag.tileImageUrl),
          ],
        );
}