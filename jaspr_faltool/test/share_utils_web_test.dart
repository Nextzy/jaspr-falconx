@TestOn('browser')
library;

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:jaspr_faltool/src/utils/share_utils.dart';
import 'package:test/test.dart';
import 'package:universal_web/web.dart' as web;

void main() {
  test(
    'copyToClipboard returns false when the browser rejects writeText',
    () async {
      expect(await ShareUtils.copyToClipboard('x'), isFalse);
    },
  );

  group('with a clipboard that accepts writes', () {
    const writeText = 'writeText';
    final clipboard = web.window.navigator.clipboard as JSObject;

    setUp(() {
      clipboard[writeText] = ((JSAny? _) => Future<void>.value().toJS).toJS;
    });

    // Removes the own-property stub so the prototype's writeText is back.
    tearDown(() => clipboard.delete(writeText.toJS));

    test('copyToClipboard returns true when writeText resolves', () async {
      expect(await ShareUtils.copyToClipboard('x'), isTrue);
    });
  });
}
