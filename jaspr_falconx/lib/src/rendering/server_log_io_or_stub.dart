import 'dart:io';

/// Writes [message], and [error] and [stackTrace] when given, to the server's
/// standard error. [stackTrace] is skipped when the text of [error] already
/// contains it, as `CommonException.toString` does.
///
/// Unlike `Log.e`, which prints only in debug builds, this also writes in a
/// release build, so a production server's log shows the failure. Jaspr
/// reports its own render errors on the same stream.
void logServerError(Object? message, {Object? error, StackTrace? stackTrace}) {
  final buffer = StringBuffer('[ERROR] $message');
  final errorText = error == null ? '' : '$error';
  if (errorText.isNotEmpty) buffer.write('\n$errorText');
  final trace = stackTrace == null ? '' : '$stackTrace';
  if (trace.isNotEmpty && !errorText.contains(trace)) buffer.write('\n$trace');
  stderr.writeln(buffer);
}
