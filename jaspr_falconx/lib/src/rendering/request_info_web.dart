import 'package:jaspr/jaspr.dart';

/// Returns the request header [name]; always null in the browser.
String? requestHeader(BuildContext context, String name) => null;

/// Does nothing in the browser; there is no response to set a status on.
void setResponseStatus(BuildContext context, int statusCode) {}

/// Does nothing in the browser; there is no response to set a header on.
void setResponseHeader(BuildContext context, String name, String value) {}

/// Does nothing in the browser; there is no response to mark.
void markNotCacheable(BuildContext context) {}
