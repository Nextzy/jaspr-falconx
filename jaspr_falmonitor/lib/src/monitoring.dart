import 'dart:async';
import 'dart:math' as math;

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
    await _initial(
      sentry: sentry,
      umami: umami,
    );
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
    await Future.wait(
      [
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
      ],
    );
  }

  static Future<void> captureScreenView(
    String path, {
    String? referrer,
  }) async {
    await Future.wait(
      [
        SentryHandler.instance.captureScreenView(
          path,
          referrer: referrer,
        ),
        UmamiHandler.instance.captureScreenView(
          path,
          referrer: referrer,
        ),
      ],
    );
  }

  static Future<void> captureError(
    Object error, {
    StackTrace? stackTrace,
    Map<String, Object>? attributes,
  }) async {
    await Future.wait(
      [
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
      ],
    );
  }

  static Future<Map<String, Object>> _getDeviceInfo() async {
    if (_deviceInfo != null) return _deviceInfo!;

    final deviceData = <String, Object>{};

    try {
      // Get browser info from window.navigator
      final navigator = web.window.navigator;
      deviceData
        ..addAll({
          'platform': 'web',
          'browser_name': _getBrowserName(navigator.userAgent),
          'app_name': navigator.appName,
          'app_version': navigator.appVersion,
          'user_agent': navigator.userAgent,
          'vendor': navigator.vendor,
          'language': navigator.language,
          'languages': navigator.language,
          'browser_platform': navigator.platform,
          'product': navigator.product,
          'vendor_sub': navigator.vendorSub,
          'max_touch_points': navigator.maxTouchPoints,
          'hardware_concurrency': navigator.hardwareConcurrency,
          'app_code_name': navigator.appCodeName,
          'product_sub': navigator.productSub,
          'online': navigator.onLine,
          'cookie_enabled': navigator.cookieEnabled,
          'locale': navigator.language,
          'timestamp': DateTime.now().toIso8601String(),
        })
        // Add screen info
        ..addAll({
          'screen_width': web.window.screen.width,
          'screen_height': web.window.screen.height,
          'screen_available_width': web.window.screen.availWidth,
          'screen_available_height': web.window.screen.availHeight,
          'screen_color_depth': web.window.screen.colorDepth,
          'screen_pixel_depth': web.window.screen.pixelDepth,
          'device_pixel_ratio': web.window.devicePixelRatio,
        })
        // Add window info
        ..addAll({
          'window_inner_width': web.window.innerWidth,
          'window_inner_height': web.window.innerHeight,
          'window_outer_width': web.window.outerWidth,
          'window_outer_height': web.window.outerHeight,
        });
    } catch (e) {
      deviceData['error'] = 'Failed to get device info: $e';
    }

    _deviceInfo = deviceData;
    return deviceData;
  }

  static String _getBrowserName(String userAgent) {
    final ua = userAgent.toLowerCase();
    if (ua.contains('firefox')) return 'Firefox';
    if (ua.contains('samsungbrowser')) return 'Samsung Internet';
    if (ua.contains('opera') || ua.contains('opr')) return 'Opera';
    if (ua.contains('trident')) return 'Internet Explorer';
    if (ua.contains('edge')) return 'Edge';
    if (ua.contains('chrome')) return 'Chrome';
    if (ua.contains('safari')) return 'Safari';
    return 'Unknown';
  }

  static Future<String> getDeviceId() async {
    // Try to get from localStorage first
    const storageKey = 'monitoring_device_id';
    final storage = web.window.localStorage;

    final deviceId = storage.getItem(storageKey);

    if (deviceId == null || deviceId.isEmpty) {
      // Generate a new device ID
      final newDeviceId = _generateDeviceId();
      storage.setItem(storageKey, newDeviceId);
      return newDeviceId;
    }

    return deviceId;
  }

  static String _generateDeviceId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = math.Random();
    final randomValue = random.nextInt(999999);

    // Create a unique ID combining timestamp and random value
    final id = '$timestamp-${randomValue.toString().padLeft(6, '0')}';

    // Add browser fingerprint for more uniqueness
    final navigator = web.window.navigator;
    final fingerprint = [
      navigator.userAgent,
      navigator.language,
      navigator.platform,
      web.window.screen.colorDepth.toString(),
      web.window.screen.width.toString(),
      web.window.screen.height.toString(),
      DateTime.now().timeZoneOffset.inMinutes.toString(),
    ].join('|');

    // Create a simple hash of the fingerprint
    var hash = 0;
    for (var i = 0; i < fingerprint.length; i++) {
      final char = fingerprint.codeUnitAt(i);
      hash = ((hash << 5) - hash) + char;
      hash = hash & hash; // Convert to 32bit integer
    }

    return '$id-${hash.abs().toRadixString(16)}';
  }
}
