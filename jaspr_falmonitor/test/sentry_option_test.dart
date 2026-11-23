import 'package:jaspr_falmonitor/src/sentry/option.dart';
import 'package:test/test.dart';

void main() {
  test('SentryAnalyticOption sends no PII by default', () {
    expect(const SentryAnalyticOption(dns: 'x').sendDefaultPii, isFalse);
  });
}
