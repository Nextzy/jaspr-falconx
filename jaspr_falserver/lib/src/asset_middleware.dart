import 'package:jaspr_falserver/src/asset_version.dart';
import 'package:jaspr_falserver/src/cache_header_policy.dart';
import 'package:jaspr_falserver/src/file_extension.dart';
import 'package:shelf/shelf.dart';

/// Context key [assetMiddleware] sets on a request it rewrote from a
/// versioned URL, so dynamic middleware can refuse to serve it.
const versionedContextKey = 'jaspr_falserver.versioned';

/// Serves `_v/<id>/<rest>` from `<rest>` and sets `Cache-Control` through
/// [policy]. A header the inner handler already set is kept.
///
/// Only a file is versioned: when the last segment of `<rest>` has no file
/// extension (a page route such as `_v/<id>/en/profile`), the middleware
/// answers 404 with `no-store` and never calls the inner handler. Otherwise a
/// page would be served under a versioned URL and marked `immutable`.
Middleware assetMiddleware({
  required String? buildId,
  CacheHeaderPolicy policy = const CacheHeaderPolicy(),
}) {
  return (inner) {
    return (request) async {
      final path = request.url.path;
      final split = splitVersion(path);
      if (split != null && fileExtensionOf(split.rest).isEmpty) {
        return Response.notFound(
          'Not Found',
          headers: {'cache-control': 'no-store'},
        );
      }
      final forwarded = split == null
          ? request
          : Request(
              request.method,
              request.requestedUri.replace(path: '/${split.rest}'),
              body: request.read(),
              headers: request.headers,
              context: {...request.context, versionedContextKey: true},
              protocolVersion: request.protocolVersion,
            );

      final response = await inner(forwarded);
      final header = policy.headerFor(
        path: path,
        method: request.method,
        statusCode: response.statusCode,
        hasSetCookie: response.headers.containsKey('set-cookie'),
        existing: response.headers['cache-control'],
        buildId: buildId,
      );
      return header == null
          ? response
          : response.change(headers: {'cache-control': header});
    };
  };
}
