import 'package:jaspr_falkit/lib.dart';

class AlternateLanguageTag {
  const AlternateLanguageTag({
    this.locale,
    this.url,
  });

  final String? locale;
  final String? url;
}

class AlternateLanguageMeta extends Fragment {
  AlternateLanguageMeta(List<AlternateLanguageTag> tags)
    : super(
        children: tags
            .map(
              (tag) => LinkHeader(
                rel: 'alternate',
                href: tag.url ?? '',
                attributes: {if (tag.locale != null) 'hreflang': tag.locale!},
                unique: true,
              ),
            )
            .toList(),
      );
}
