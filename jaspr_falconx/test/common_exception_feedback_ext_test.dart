import 'package:jaspr_falmodel/jaspr_falmodel.dart';
import 'package:jaspr_falconx/src/extensions/common_exception_feedback_ext.dart';
import 'package:test/test.dart';

void main() {
  group('CommonExceptionFeedbackX.toFailure', () {
    test('uses userMessage when available, default level medium', () {
      final ex = CommonException(
        type: ErrorType.notFound,
        userMessage: 'not found',
        developerMessage: 'dev msg',
      );
      final f = ex.toFailure();
      expect(f.message, 'not found');
      expect(f.level, FeedbackLevel.medium);
    });

    test('falls back to developerMessage when userMessage is null', () {
      final ex = CommonException(
        type: ErrorType.unknown,
        developerMessage: 'dev only',
      );
      expect(ex.toFailure().message, 'dev only');
    });

    test('message is null when both messages are null', () {
      final ex = CommonException(type: ErrorType.unknown);
      expect(ex.toFailure().message, isNull);
    });

    test('accepts custom level', () {
      final ex = CommonException(
        type: ErrorType.permission,
        userMessage: 'denied',
      );
      final f = ex.toFailure(level: FeedbackLevel.high);
      expect(f.level, FeedbackLevel.high);
    });
  });
}
