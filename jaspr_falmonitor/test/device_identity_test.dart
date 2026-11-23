import 'dart:math';

import 'package:jaspr_falmonitor/src/device_identity.dart';
import 'package:test/test.dart';

void main() {
  group('deviceAttributes', () {
    test('returns only the five allowlisted keys', () {
      final attributes = deviceAttributes(
        userAgent: 'Mozilla/5.0 Chrome/120',
        language: 'th',
        screenWidth: 390,
        screenHeight: 844,
      );

      expect(attributes.keys.toSet(), {
        'platform',
        'browser_name',
        'language',
        'screen_width',
        'screen_height',
      });
      expect(attributes['platform'], 'web');
      expect(attributes['browser_name'], 'Chrome');
      expect(attributes['language'], 'th');
      expect(attributes['screen_width'], 390);
      expect(attributes['screen_height'], 844);
    });
  });

  group('generateDeviceId', () {
    test('returns 32 lowercase hex characters', () {
      expect(generateDeviceId(Random(1)), matches(RegExp(r'^[0-9a-f]{32}$')));
    });

    test('differs between calls on one Random', () {
      final random = Random(1);

      expect(generateDeviceId(random), isNot(generateDeviceId(random)));
    });
  });

  group('isDeviceId', () {
    test('rejects the old timestamp format', () {
      expect(isDeviceId('1700000000000-123456-1a2b3c'), isFalse);
    });

    test('accepts a generated id', () {
      expect(isDeviceId(generateDeviceId(Random(2))), isTrue);
    });
  });
}
