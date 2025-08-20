import 'package:jaspr_falmonitor/lib.dart';

class UmamiHandler extends MonitorHandler<UmamiAnalyticOption> {
  UmamiHandler._();

  static final UmamiHandler instance = UmamiHandler._();

  @override
  Future<void> initial(UmamiAnalyticOption option) async {
    // Stub: Do nothing on server.
  }

  @override
  Future<void> setupUserIdentifier({
    required String userId,
    Map<String, Object>? attributes,
  }) async {
    // Stub: Do nothing on server.
  }

  @override
  Future<void> captureError(
    Object error, {
    StackTrace? stackTrace,
    Map<String, Object>? attributes,
  }) async {
    // Stub: Do nothing on server.
  }

  @override
  Future<void> captureEvent({
    required String type,
    String? name,
    String? screenName,
    Map<String, Object>? eventAttributes,
  }) async {
    // Stub: Do nothing on server.
  }

  @override
  Future<void> captureScreenView(
    String path, {
    String? referrer,
  }) async {
    // Stub: Do nothing on server.
  }
}
