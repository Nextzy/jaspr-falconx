import 'package:jaspr_falmonitor/lib.dart';

abstract class MonitorHandler<OPTION extends AnalyticOption> {
  OPTION? option;

  bool get enabled => option != null && (option?.enabled ?? false);

  FutureOr<void> initial(OPTION option);

  FutureOr<void> setupUserIdentifier({
    required String userId,
    Map<String, Object>? attributes,
  });

  FutureOr<void> captureEvent({
    required String type,
    String? name,
    String? screenName,
    Map<String, Object>? eventAttributes,
  });

  FutureOr<void> captureScreenView(
    String path, {
    String? referrer,
  });

  FutureOr<void> captureError(
    Object error, {
    StackTrace? stackTrace,
    Map<String, Object>? attributes,
  });
}
