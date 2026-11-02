import 'package:jaspr_falconx/jaspr_falconx.dart';
import 'package:test/test.dart';

void main() {
  const codes = ['th', 'en'];

  group('switchLocalePath', () {
    test('replaces the leading locale segment', () {
      expect(switchLocalePath('/th/blogs/abc', 'en', codes), '/en/blogs/abc');
      expect(switchLocalePath('/en', 'th', codes), '/th');
    });

    test('prefixes the locale when the path has none', () {
      expect(switchLocalePath('/', 'en', codes), '/en');
      expect(switchLocalePath('/fr/x', 'en', codes), '/en/fr/x');
      expect(switchLocalePath('blogs', 'th', codes), '/th/blogs');
      expect(switchLocalePath('/th/', 'en', codes), '/en');
    });

    test('keeps the query string and the fragment', () {
      expect(
        switchLocalePath('/blogs?page=2', 'th', codes),
        '/th/blogs?page=2',
      );
      expect(
        switchLocalePath('/th/policy#terms', 'en', codes),
        '/en/policy#terms',
      );
      expect(switchLocalePath('/th/a?x=1#top', 'en', codes), '/en/a?x=1#top');
    });
  });
}
