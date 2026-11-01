import 'package:jaspr_falconx/jaspr_falconx.dart';
import 'package:test/test.dart';

void main() {
  const s = ['th', 'en'];

  group('pickLocale', () {
    test('picks by header order and q-value', () {
      expect(pickLocale('th-TH,th;q=0.9,en;q=0.8', s, fallback: 'en'), 'th');
      expect(pickLocale('en-US', s, fallback: 'en'), 'en');
      expect(pickLocale('fr;q=1, th;q=0.5', s, fallback: 'en'), 'th');
    });
    test('falls back', () {
      expect(pickLocale(null, s, fallback: 'en'), 'en');
      expect(pickLocale('*', s, fallback: 'en'), 'en');
      expect(pickLocale('fr-FR,fr;q=0.9', s, fallback: 'en'), 'en');
    });
    test('refuses q=0', () {
      expect(pickLocale('en;q=0.1,th;q=0', s, fallback: 'en'), 'en');
      expect(pickLocale('th;q=0', s, fallback: 'en'), 'en');
    });
  });

  group('localeFromPath', () {
    test('reads the first segment', () {
      expect(localeFromPath('/th/projects/42', s), 'th');
      expect(localeFromPath('en', s), 'en');
    });
    test('ignores query and fragment', () {
      expect(localeFromPath('/th?view=contact', s), 'th');
      expect(localeFromPath('/en/profile?view=contact', s), 'en');
      expect(localeFromPath('/en#top', s), 'en');
      expect(localeFromPath('?th', s), isNull);
    });
    test('returns null otherwise', () {
      expect(localeFromPath('/policies/x', s), isNull);
      expect(localeFromPath('', s), isNull);
      expect(localeFromPath('/projects/th', s), isNull);
    });
  });
}
