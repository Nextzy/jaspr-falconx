import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:jaspr_falmonitor/lib.dart';
import 'package:universal_web/web.dart' as web;

class UmamiHandler extends MonitorHandler<UmamiAnalyticOption> {
  UmamiHandler._();

  static final UmamiHandler instance = UmamiHandler._();

  JSObject get _umami => web.window['umami'];

  @override
  Future<void> initial(UmamiAnalyticOption option) async {
    this.option = option;
    if (enabled) {}
  }

  @override
  Future<void> setupUserIdentifier({
    required String userId,
    Map<String, Object>? attributes,
  }) async {
    if (enabled) {
      final jsData = attributes.jsify();
      _umami.callMethod('identify'.toJS, jsData);
    }
  }

  @override
  Future<void> captureEvent({
    required String type,
    String? name,
    String? screenName,
    Map<String, Object>? eventAttributes,
  }) async {
    try {
      if (enabled) {
        // Prepare the data object
        final data = <String, Object>{
          if (name != null) 'name': name,
          if (screenName != null) 'screen_name': screenName,
        }..addAll(eventAttributes ?? {});

        // Convert to JS types
        final jsEventType = type.toJS;
        final jsData = data.jsify();

        _umami.callMethod('track'.toJS, jsEventType, jsData);
      }
    } catch (e) {
      Log.w('Failed to track event with umami.js: $e');
    }
  }

  @override
  Future<void> captureScreenView(
    String path, {
    String? referrer,
  }) async {
    try {
      if (enabled) {
        _umami.callMethod('track'.toJS);
      }
    } catch (error, stackTrace) {
      Log.w(error, error: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> captureError(
    Object error, {
    StackTrace? stackTrace,
    Map<String, Object>? attributes,
  }) async {
    if (enabled) {
      // Umami no capture error feature
    }
  }
}
