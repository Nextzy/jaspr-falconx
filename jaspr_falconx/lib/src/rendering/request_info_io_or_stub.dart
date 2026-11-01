import 'package:jaspr/server.dart';

/// Returns the request header [name] (case-insensitive), or null if absent.
String? requestHeader(BuildContext context, String name) {
  return context.headers[name.toLowerCase()];
}

/// Sets the HTTP status code of the response being rendered.
void setResponseStatus(BuildContext context, int statusCode) {
  context.setStatusCode(statusCode);
}

/// Sets the response header [name] to [value] on the response being
/// rendered.
void setResponseHeader(BuildContext context, String name, String value) {
  context.setHeader(name, value);
}

/// Marks the response being rendered as never cacheable
/// (`cache-control: no-store`).
///
/// Call it when a page renders with incomplete data, so neither a browser nor
/// a CDN keeps the degraded page. The asset middleware keeps a header the
/// render already set.
void markNotCacheable(BuildContext context) {
  context.setHeader('cache-control', 'no-store');
}
