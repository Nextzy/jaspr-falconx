import 'package:jaspr_falkit/lib.dart';

/// Speculation Rules document: prefetch same-origin document links, skipping
/// every path that starts with one of [excludePrefixes].
Map<String, Object> speculationRulesJson({
  required String eagerness,
  required List<String> excludePrefixes,
}) => {
  'prefetch': [
    {
      'source': 'document',
      'eagerness': eagerness,
      'where': {
        'and': [
          {'href_matches': '/*'},
          for (final prefix in excludePrefixes)
            {
              'not': {'href_matches': '$prefix*'},
            },
        ],
      },
    },
  ],
};

/// Emits `<script type="speculationrules">` so the browser prefetches links
/// before the visitor clicks them.
class SpeculationRules extends StatelessComponent {
  const SpeculationRules({
    this.eagerness = 'moderate',
    this.excludePrefixes = const ['/_v/'],
    super.key,
  });

  final String eagerness;
  final List<String> excludePrefixes;

  @override
  Component build(BuildContext context) {
    final json = jsonEncode(
      speculationRulesJson(
        eagerness: eagerness,
        excludePrefixes: excludePrefixes,
      ),
    ).replaceAll('<', r'\u003c');
    return Component.element(
      tag: 'script',
      attributes: const {'type': 'speculationrules'},
      children: [RawText(json)],
    );
  }
}
