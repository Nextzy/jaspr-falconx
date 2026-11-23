import 'dart:async';
import 'dart:math';

import 'package:jaspr_falmonitor/src/device_identity.dart';
import 'package:jaspr_falmonitor/src/src.dart';
import 'package:universal_web/web.dart' as web;

class Monitoring {
  const Monitoring._();

  static String? _userDeviceId; //
  static String get userDeviceId => _userDeviceId!; //

  static Map<String, Object>? _deviceInfo; //
  static Map<String, Object> get deviceInfo => _deviceInfo!; //

  static FutureOr<void> init<PRELOAD>({
    SentryAnalyticOption? sentry,
    UmamiAnalyticOption? umami,
  }) async {
    _userDeviceId = await getDeviceId();
    _deviceInfo = await _getDeviceInfo();
    await _initial(sentry: sentry, umami: umami);
    await _setupUserIdentifier(userId: userDeviceId, attributes: deviceInfo);
  }

  static Future<void> _initial({
    SentryAnalyticOption? sentry,
    UmamiAnalyticOption? umami,
  }) async {
    await Future.wait([
      if (sentry != null) SentryHandler.instance.initial(sentry),
      if (umami != null) UmamiHandler.instance.initial(umami),
    ]);
  }

  static Future<void> _setupUserIdentifier({
    required String userId,
    Map<String, Object>? attributes,
  }) async {
    await Future.wait([
      SentryHandler.instance.setupUserIdentifier(
        userId: userDeviceId,
        attributes: deviceInfo,
      ),
      UmamiHandler.instance.setupUserIdentifier(
        userId: userDeviceId,
        attributes: deviceInfo,
      ),
    ]);
  }

  static Future<void> captureEvent({
    required String type,
    String? name,
    String? screenName,
    Map<String, Object>? eventAttributes,
  }) async {
    await Future.wait([
      SentryHandler.instance.captureEvent(
        type: type,
        name: name,
        screenName: screenName,
        eventAttributes: eventAttributes,
      ),
      UmamiHandler.instance.captureEvent(
        type: type,
        name: name,
        screenName: screenName,
        eventAttributes: eventAttributes,
      ),
    ]);
  }

  static Future<void> captureScreenView(String path, {String? referrer}) async {
    await Future.wait([
      SentryHandler.instance.captureScreenView(path, referrer: referrer),
      UmamiHandler.instance.captureScreenView(path, referrer: referrer),
    ]);
  }

  static Future<void> captureError(
    Object error, {
    StackTrace? stackTrace,
    Map<String, Object>? attributes,
  }) async {
    await Future.wait([
      SentryHandler.instance.captureError(
        error,
        stackTrace: stackTrace,
        attributes: attributes,
      ),
      UmamiHandler.instance.captureError(
        error,
        stackTrace: stackTrace,
        attributes: attributes,
      ),
    ]);
  }

  static Future<Map<String, Object>> _getDeviceInfo() async {
    if (_deviceInfo != null) return _deviceInfo!;

    final Map<String, Object> deviceData;
    try {
      final navigator = web.window.navigator;
      deviceData = deviceAttributes(
        userAgent: navigator.userAgent,
        language: navigator.language,
        screenWidth: web.window.screen.width,
        screenHeight: web.window.screen.height,
      );
    } on Object catch (e) {
      return _deviceInfo = {'error': 'Failed to get device info: $e'};
    }

    return _deviceInfo = deviceData;
  }

  static Future<String> getDeviceId() async {
    const storageKey = 'monitoring_device_id';
    final storage = web.window.localStorage;

    final deviceId = storage.getItem(storageKey);
    if (deviceId != null && isDeviceId(deviceId)) return deviceId;

    final newDeviceId = generateDeviceId(Random.secure());
    storage.setItem(storageKey, newDeviceId);
    return newDeviceId;
  }
}
