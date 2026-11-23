import 'package:jaspr_falmonitor/lib.dart';
import 'package:jaspr_falmonitor/src/umami/umami_script.dart';
import 'package:test/test.dart';

void main() {
  group('umamiScriptAttributes', () {
    test('maps every option to its tracker attribute', () {
      final attributes = umamiScriptAttributes(
        const UmamiAnalyticOption(
          enabled: true,
          websiteId: 'w',
          scriptUrl: 'https://u/s.js',
          hostUrl: 'https://h',
          autoTrack: false,
          domains: ['a.com', 'b.com'],
        ),
      );

      expect(attributes, {
        'src': 'https://u/s.js',
        'data-website-id': 'w',
        'data-host-url': 'https://h',
        'data-auto-track': 'false',
        'data-domains': 'a.com,b.com',
      });
    });

    test('leaves out unset optional attributes', () {
      final attributes = umamiScriptAttributes(
        const UmamiAnalyticOption(websiteId: 'w', scriptUrl: 'https://u/s.js'),
      );

      expect(attributes, {'src': 'https://u/s.js', 'data-website-id': 'w'});
    });
  });
}
