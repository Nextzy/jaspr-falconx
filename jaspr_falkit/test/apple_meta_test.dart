import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falkit/jaspr_falkit.dart';
import 'package:jaspr_test/server_test.dart';

void main() {
  testServer('AppleMeta loads no splash script by default', (tester) async {
    tester.pumpComponent(
      const Document.head(children: [AppleMeta(iconUrl: 'https://x/i.png')]),
    );
    final response = await tester.request('/');

    expect(response.body, isNot(contains('iosPWASplash')));
    expect(response.body, isNot(contains('unpkg.com')));
  });

  testServer('SeoMetaTags loads no third-party script by default', (
    tester,
  ) async {
    tester.pumpComponent(
      const Document.head(children: [SeoMetaTags(title: 'T')]),
    );
    final response = await tester.request('/');

    expect(response.body, isNot(contains('unpkg.com')));
  });

  testServer('SeoMetaTags passes apple.pwaScript to AppleMeta', (tester) async {
    tester.pumpComponent(
      const Document.head(
        children: [
          SeoMetaTags(
            title: 'T',
            apple: AppleMeta(pwaScript: 'https://cdn/s.js'),
          ),
        ],
      ),
    );
    final response = await tester.request('/');

    expect(response.body, contains('iosPWASplash('));
  });

  testServer('SeoDefaults.apple.pwaScript reaches SeoMetaTags', (tester) async {
    tester.pumpComponent(
      const SeoDefaults(
        apple: AppleMeta(pwaScript: 'https://cdn/s.js'),
        child: Document.head(children: [SeoMetaTags(title: 'T')]),
      ),
    );
    final response = await tester.request('/');

    expect(response.body, contains('iosPWASplash('));
  });

  testServer('AppleMeta renders no script for a blank pwaScript', (
    tester,
  ) async {
    tester.pumpComponent(
      const Document.head(
        children: [AppleMeta(pwaScript: '  ', iconUrl: 'https://x/i.png')],
      ),
    );
    final response = await tester.request('/');

    expect(response.body, isNot(contains('iosPWASplash')));
  });

  const breakout = "x'</script><script>alert(1)//";
  const cases = <String, AppleMeta>{
    'pwaScript': AppleMeta(pwaScript: breakout, iconUrl: 'i', color: '#000'),
    'iconUrl': AppleMeta(pwaScript: 'https://cdn/s.js', iconUrl: breakout),
    'color': AppleMeta(
      pwaScript: 'https://cdn/s.js',
      iconUrl: 'i',
      color: breakout,
    ),
  };
  for (final MapEntry(key: field, value: meta) in cases.entries) {
    testServer('AppleMeta escapes $field in its inline script', (tester) async {
      tester.pumpComponent(Document.head(children: [meta]));
      final response = await tester.request('/');

      expect(response.body, contains('iosPWASplash('));
      expect(response.body, contains(r'\u003c/script\u003e'));
      expect(response.body, isNot(contains('</script><script>alert(1)')));
    });
  }
}
