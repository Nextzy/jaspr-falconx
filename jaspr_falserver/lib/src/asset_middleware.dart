import 'package:jaspr_falserver/src/asset_version.dart';
import 'package:jaspr_falserver/src/cache_header_policy.dart';
import 'package:shelf/shelf.dart';

/// Serves `_v/<id>/<rest>` from `<rest>` and sets `Cache-Control` through
/// [policy]. A header the inner handler already set is kept.
Middleware assetMiddleware({
  required String? buildId,
  CacheHeaderPolicy policy = const CacheHeaderPolicy(),
}) {
  return (inner) {
    return (request) async {
      final path = request.url.path;
      final split = splitVersion(path);
      final forwarded = split == null
          ? request
          : Request(
              request.method,
              request.requestedUri.replace(path: '/${split.rest}'),
              body: request.read(),
              headers: request.headers,
              context: request.context,
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
