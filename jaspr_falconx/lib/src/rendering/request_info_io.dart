import 'package:jaspr/server.dart';

/// Returns the request header [name] (case-insensitive), or null if absent.
String? requestHeader(BuildContext context, String name) {
  return context.headers[name.toLowerCase()];
}

/// Sets the HTTP status code of the response being rendered.
void setResponseStatus(BuildContext context, int statusCode) {
  context.setStatusCode(statusCode);
}
