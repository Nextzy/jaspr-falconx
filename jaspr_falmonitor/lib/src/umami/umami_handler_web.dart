import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:jaspr_falmonitor/lib.dart';
import 'package:jaspr_falmonitor/src/umami/umami_script.dart';
import 'package:universal_web/web.dart' as web;

const _trackerLoadTimeout = Duration(seconds: 10);

class UmamiHandler extends MonitorHandler<UmamiAnalyticOption> {
  UmamiHandler._();

  static final UmamiHandler instance = UmamiHandler._();

  static Future<void>? _trackerLoad;

  /// Forgets the loaded tracker so the next `initial` loads it again.
  @visibleForTesting
  static void resetTrackerLoad() => _trackerLoad = null;

  /// Returns `window.umami`, or logs and returns null while it is missing.
  ///
  /// It is missing until the tracker loads, and for good when a blocker
  /// stops the script.
  JSObject? get _umami {
    final umami = web.window.getProperty<JSAny?>('umami'.toJS);
    if (umami != null && umami.isA<JSObject>()) return umami as JSObject;
    Log.w('window.umami is not defined; skipping the Umami call');
    return null;
  }

  @override
  Future<void> initial(UmamiAnalyticOption option) async {
    this.option = option;
    if (!enabled || option.scriptUrl == null || option.websiteId == null) {
      return;
    }
    await (_trackerLoad ??= _loadTracker(option));
  }

  Future<void> _loadTracker(UmamiAnalyticOption option) {
    final script = web.HTMLScriptElement()..defer = true;
    for (final MapEntry(:key, :value) in umamiScriptAttributes(
      option,
    ).entries) {
      script.setAttribute(key, value);
    }
    final done = Completer<void>();
    void complete(web.Event _) {
      if (!done.isCompleted) done.complete();
    }

    script
      ..addEventListener('load', complete.toJS)
      ..addEventListener('error', complete.toJS);
    web.document.head!.append(script);
    return done.future.timeout(
      _trackerLoadTimeout,
      onTimeout: () => Log.w('Umami tracker did not load in time; continuing'),
    );
  }

  @override
  Future<void> setupUserIdentifier({
    required String userId,
    Map<String, Object>? attributes,
  }) async {
    if (!enabled) return;
    final jsData = attributes.jsify();
    _umami?.callMethod('identify'.toJS, jsData);
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
        final data = <String, Object>{'name': ?name, 'screen_name': ?screenName}
          ..addAll(eventAttributes ?? {});

        // Convert to JS types
        final jsEventType = type.toJS;
        final jsData = data.jsify();

        _umami?.callMethod('track'.toJS, jsEventType, jsData);
      }
    } on Object catch (e) {
      Log.w('Failed to track event with umami.js: $e');
    }
  }

  @override
  Future<void> captureScreenView(String path, {String? referrer}) async {
    try {
      if (enabled) {
        _umami?.callMethod('track'.toJS);
      }
    } on Object catch (error, stackTrace) {
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
