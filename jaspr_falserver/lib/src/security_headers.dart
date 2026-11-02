import 'package:shelf/shelf.dart';

/// Default `Referrer-Policy`: full URL same-origin, origin only cross-origin.
const defaultReferrerPolicy = 'strict-origin-when-cross-origin';

/// Default `Permissions-Policy`: denies features a site rarely uses.
const defaultPermissionsPolicy =
    'camera=(), microphone=(), geolocation=(), payment=(), usb=()';

/// Default `Content-Security-Policy`; it has no `script-src` because that
/// needs hashes for inline and Cloudflare-injected scripts, so apps add it.
const defaultContentSecurityPolicy =
    "frame-ancestors 'self'; base-uri 'self'; object-src 'none'";

/// Adds `referrer-policy`, `permissions-policy`, and
/// `content-security-policy` to every response.
///
/// A header the inner handler already set is kept; `null` turns a header off.
///
/// Throws [ArgumentError] when a value contains `\r` or `\n`.
Middleware securityHeadersMiddleware({
  String? referrerPolicy = defaultReferrerPolicy,
  String? permissionsPolicy = defaultPermissionsPolicy,
  String? contentSecurityPolicy = defaultContentSecurityPolicy,
}) {
  final headers = <String, String>{
    'referrer-policy': ?referrerPolicy,
    'permissions-policy': ?permissionsPolicy,
    'content-security-policy': ?contentSecurityPolicy,
  }..forEach(_requireSingleLine);

  return (inner) {
    return (request) async {
      final response = await inner(request);
      final missing = {
        for (final entry in headers.entries)
          if (!response.headers.containsKey(entry.key)) entry.key: entry.value,
      };
      return missing.isEmpty ? response : response.change(headers: missing);
    };
  };
}

void _requireSingleLine(String name, String value) {
  if (value.contains('\r') || value.contains('\n')) {
    throw ArgumentError.value(value, name, 'must not contain a line break');
  }
}
