import 'package:jaspr_falmodel/jaspr_falmodel.dart';

extension CommonExceptionFeedbackX on CommonException {
  Failure toFailure({FeedbackLevel level = FeedbackLevel.medium}) => Failure(
        message: userMessage ?? developerMessage,
        level: level,
      );
}
