import 'package:jaspr_falkit/lib.dart';

class AlternateLanguageTag {
  const new({this.locale, this.url});

  final String? locale;
  final String? url;
}

class AlternateLanguageMeta extends StatelessComponent {
  const new(this.tags);

  final List<AlternateLanguageTag> tags;

  @override
  Component build(BuildContext context) => Document.head(
    children: tags
        .map(
          (tag) => LinkHeader(
            rel: 'alternate',
            href: tag.url ?? '',
            attributes: {if (tag.locale != null) 'hreflang': tag.locale!},
          ),
        )
        .toList(),
  );
}
