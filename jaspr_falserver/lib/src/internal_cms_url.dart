import 'dart:async';
import 'dart:io';

/// The normalized [value], or null when it is empty or not an absolute
/// `http`/`https` URL with a host.
///
/// Trims whitespace and removes one trailing `/`.
String? validInternalCmsUrl(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) return null;
  final uri = Uri.tryParse(trimmed);
  if (uri == null ||
      !uri.hasAuthority ||
      uri.host.isEmpty ||
      (uri.scheme != 'http' && uri.scheme != 'https')) {
    return null;
  }
  return trimmed.endsWith('/')
      ? trimmed.substring(0, trimmed.length - 1)
      : trimmed;
}

/// Chooses the CMS base URL for the server's own calls, checking first that
/// the private URL answers.
///
/// Uses a valid internal URL only when [probe] reports it reachable. When
/// [internalUrl] is unset or malformed, [probe] is not called. When the
/// probe fails, says no, or throws, [log] gets one line naming the reason and
/// the result is [publicUrl], so an unreachable private network never turns
/// every page into a 503.
Future<String> resolveServerCmsBaseUrl({
  required String publicUrl,
  String? internalUrl,
  required Future<bool> Function(String baseUrl) probe,
  void Function(String message)? log,
}) async {
  final internal = validInternalCmsUrl(internalUrl);
  if (internal == null) {
    if (internalUrl != null && internalUrl.trim().isNotEmpty) {
      log?.call(
        'CMS_INTERNAL_API_BASE_URL is not an absolute http(s) URL; '
        'using the public CMS URL',
      );
    }
    return publicUrl;
  }
  try {
    if (await probe(internal)) return internal;
    log?.call(
      'CMS_INTERNAL_API_BASE_URL did not answer the health probe; '
      'using the public CMS URL',
    );
  } on Object catch (error) {
    log?.call(
      'CMS_INTERNAL_API_BASE_URL probe failed '
      '(${error.toString().replaceAll(RegExp(r'\s+'), ' ')}); '
      'using the public CMS URL',
    );
  }
  return publicUrl;
}

/// Whether `GET <baseUrl><path>` answers 200 within [timeout] in total
/// (connect, request, response and body).
///
/// Throws `StateError('HTTP <code>')` on another status, and throws on a
/// network error or a timeout; the caller logs the reason.
Future<bool> pingOk(
  String baseUrl, {
  String path = '/server/ping',
  Duration timeout = const Duration(seconds: 2),
}) async {
  final client = HttpClient();
  try {
    return await _ping(client, baseUrl, path).timeout(timeout);
  } finally {
    // Aborts any work a timeout left running.
    client.close(force: true);
  }
}

Future<bool> _ping(HttpClient client, String baseUrl, String path) async {
  final request = await client.getUrl(Uri.parse('$baseUrl$path'));
  final response = await request.close();
  await response.drain<void>();
  if (response.statusCode == 200) return true;
  throw StateError('HTTP ${response.statusCode}');
}
