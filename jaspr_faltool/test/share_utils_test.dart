import 'package:jaspr_faltool/src/utils/share_utils.dart';
import 'package:test/test.dart';

void main() {
  group('ShareUtils on the server', () {
    test('copyToClipboard returns false', () async {
      expect(await ShareUtils.copyToClipboard('x'), isFalse);
    });

    final shares = <String, Future<void> Function()>{
      'shareToFacebook': () => ShareUtils.shareToFacebook('/p'),
      'shareToTwitter': () => ShareUtils.shareToTwitter('/p', message: 'm'),
      'shareToLinkedIn': () => ShareUtils.shareToLinkedIn('/p', message: 'm'),
      'shareToLine': () => ShareUtils.shareToLine('/p', message: 'm'),
    };
    for (final MapEntry(:key, :value) in shares.entries) {
      test('$key completes without throwing', () async {
        await expectLater(value(), completes);
      });
    }
  });
}
