import 'package:jaspr/server.dart';

/// Returns the request header [name] (case-insensitive), or null if absent.
String? requestHeader(BuildContext context, String name) {
  return context.headers[name.toLowerCase()];
}
