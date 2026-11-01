import 'dart:io';

/// Writes [message], and [error] and [stackTrace] when given, to the server's
/// standard error.
///
/// Unlike `Log.e`, which prints only in debug builds, this also writes in a
/// release build, so a production server's log shows the failure. Jaspr
/// reports its own render errors on the same stream.
void logServerError(Object? message, {Object? error, StackTrace? stackTrace}) {
  final buffer = StringBuffer('[ERROR] $message');
  if (error != null) buffer.write('\n$error');
  if (stackTrace != null) buffer.write('\n$stackTrace');
  stderr.writeln(buffer);
}
