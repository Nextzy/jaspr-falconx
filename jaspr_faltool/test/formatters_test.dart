import 'package:jaspr_faltool/jaspr_faltool.dart';
import 'package:test/test.dart';

void main() {
  group('String.truncate', () {
    test('cuts at maxLength and appends the custom suffix', () {
      expect('abc'.truncateText(maxLength: 2, truncate: '…'), 'ab…');
    });

    test('uses ... by default and keeps short text', () {
      expect('abcdef'.truncateText(maxLength: 3), 'abc...');
      expect('abc'.truncateText(maxLength: 3), 'abc');
    });

    test('null receiver returns an empty string', () {
      const String? value = null;
      expect(value.truncateText(), '');
    });
  });

  group('AppDateTime', () {
    test('round-trips an ISO string', () {
      const iso = '2026-11-01T00:00:00.000Z';
      expect(
        AppDateTime.dateTimeToString(AppDateTime.dateTimeFromString(iso)),
        iso,
      );
    });

    test('null stays null', () {
      expect(AppDateTime.dateTimeFromString(null), isNull);
      expect(AppDateTime.dateTimeToString(null), isNull);
    });
  });

  group('DateTime format extensions', () {
    test('format with default and custom pattern', () {
      final date = DateTime(2026, 11, 1);
      expect(date.toFormatString(), '1 Nov 2026');
      expect(date.toFormatString(format: 'yyyy-MM-dd'), '2026-11-01');
      const DateTime? none = null;
      expect(none.toFormatString(), isNull);
    });

    test('parse string back to DateTime', () {
      expect('1 Nov 2026'.toDateTime(), DateTime(2026, 11, 1));
      const String? none = null;
      expect(none.toDateTime(), isNull);
    });
  });
}
