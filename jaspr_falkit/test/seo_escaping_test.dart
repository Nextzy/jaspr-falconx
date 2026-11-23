import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falkit/jaspr_falkit.dart';
import 'package:jaspr_test/server_test.dart';

const escapedTail = '&lt;/title&gt;&lt;script&gt;x&lt;/script&gt;';

void main() {
  testServer('DefaultMeta escapes the title', (tester) async {
    tester.pumpComponent(
      const Document.head(
        children: [
          DefaultMeta(title: 'Tom & Jerry </title><script>x</script>'),
        ],
      ),
    );
    final response = await tester.request('/');

    expect(
      response.body,
      contains('<title>Tom &amp; Jerry $escapedTail</title>'),
    );
    expect(response.body, isNot(contains('<script>x</script>')));
  });

  testServer('GenericSchema cannot close its script tag', (tester) async {
    tester.pumpComponent(
      const Document.head(
        children: [
          GenericSchema(
            data: {
              '@type': 'Thing',
              'name': '</script><script>alert(1)</script>',
            },
          ),
        ],
      ),
    );
    final response = await tester.request('/');

    expect(
      response.body,
      contains(
        r'"name":"\u003c/script\u003e\u003cscript\u003ealert(1)\u003c/script\u003e"',
      ),
    );
    expect(response.body, isNot(contains('</script><script>alert(1)')));
  });

  testServer('SchemaGroup cannot close its script tag via @graph', (
    tester,
  ) async {
    tester.pumpComponent(
      Document.head(
        children: [
          SchemaGroup(
            schemas: const [
              GenericSchema(
                data: {
                  '@type': 'Thing',
                  'list': ['</script>'],
                },
              ),
            ],
          ),
        ],
      ),
    );
    final response = await tester.request('/');

    expect(response.body, contains(r'"list":["\u003c/script\u003e"]'));
    expect(response.body, isNot(contains('"list":["</script>"]')));
  });
}
