import 'package:jaspr_falkit/jaspr_falkit.dart';
import 'package:jaspr_test/server_test.dart';

void main() {
  test('speculationRulesJson prefetches same-origin links', () {
    expect(
      speculationRulesJson(eagerness: 'moderate', excludePrefixes: ['/_v/']),
      {
        'prefetch': [
          {
            'source': 'document',
            'eagerness': 'moderate',
            'where': {
              'and': [
                {'href_matches': '/*'},
                {
                  'not': {'href_matches': '/_v/*'},
                },
              ],
            },
          },
        ],
      },
    );
  });

  testServer('SpeculationRules renders the script', (tester) async {
    tester.pumpComponent(const SpeculationRules());
    final body = (await tester.request('/')).body;
    expect(body, contains('<script type="speculationrules">'));
    expect(body, contains('"eagerness":"moderate"'));
    expect(body, contains('/_v/*'));
  });
}
