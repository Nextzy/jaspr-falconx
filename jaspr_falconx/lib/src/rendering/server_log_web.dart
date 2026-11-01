import 'package:jaspr_faltool/jaspr_faltool.dart';

/// Forwards to `Log.e` in the browser, which prints only in debug builds.
void logServerError(Object? message, {Object? error, StackTrace? stackTrace}) {
  Log.e(message, error: error, stackTrace: stackTrace);
}

/// Calls `Log.i` in the browser, which prints only in debug builds.
void logServerInfo(Object? message) {
  Log.i(message);
}
