import 'package:jaspr_falserver/src/asset_version.dart';
import 'package:jaspr_falserver/src/file_extension.dart';

/// Chooses the `Cache-Control` value for a response.
///
/// Only a `GET` or `HEAD` response with a 2xx or 304 status and no
/// `set-cookie` header gets a public policy; every other response gets
/// `no-store`. A public response then gets, by path:
///
/// | Path | Header |
/// |---|---|
/// | `_v/<current build id>/...` | `public, max-age=31536000, immutable` |
/// | `_v/<other id>/...` | `no-store` |
/// | image extension | `public, max-age=<imageTtl>` |
/// | font extension | `public, max-age=<fontTtl>` |
/// | anything else (HTML) | `public, max-age=0, s-maxage=<htmlEdgeTtl>` |
class CacheHeaderPolicy {
  /// Creates a policy. The defaults give HTML one day at the edge, images one
  /// day in the browser, and fonts 30 days in the browser.
  const CacheHeaderPolicy({
    this.htmlEdgeTtl = const Duration(days: 1),
    this.imageTtl = const Duration(days: 1),
    this.fontTtl = const Duration(days: 30),
  });

  /// How long a shared cache (the CDN edge) keeps HTML and other unversioned
  /// files that are neither images nor fonts. Browsers always revalidate them.
  final Duration htmlEdgeTtl;

  /// How long a browser keeps an unversioned image.
  final Duration imageTtl;

  /// How long a browser keeps an unversioned font.
  final Duration fontTtl;

  static const _immutable = 'public, max-age=31536000, immutable';
  static const _noStore = 'no-store';

  static const _imageExtensions = {
    'avif', 'webp', 'svg', 'png', 'jpg', 'jpeg', 'gif', 'ico', //
  };
  static const _fontExtensions = {'woff2', 'woff', 'ttf', 'otf'};

  /// Returns the header to set, or null when [existing] must stay.
  ///
  /// [path] is the original request path, version prefix included. [method]
  /// is the request method. [hasSetCookie] tells whether the response sets a
  /// cookie; such a response is per visitor and never public.
  String? headerFor({
    required String path,
    required String method,
    required int statusCode,
    required bool hasSetCookie,
    required String? existing,
    required String? buildId,
  }) {
    if (existing != null) return null;
    final readOnly = method == 'GET' || method == 'HEAD';
    if (!readOnly || hasSetCookie) return _noStore;
    // A 304 revalidation refreshes the stored response's metadata, so it
    // takes the same policy as the 2xx it revalidates (RFC 9111 4.3.4).
    final cacheable =
        (statusCode >= 200 && statusCode < 300) || statusCode == 304;
    if (!cacheable) return _noStore;

    final version = splitVersion(path);
    if (version != null) {
      final current = buildId != null && buildId.isNotEmpty;
      return current && version.id == buildId ? _immutable : _noStore;
    }

    final extension = fileExtensionOf(path);
    if (_imageExtensions.contains(extension)) {
      return 'public, max-age=${imageTtl.inSeconds}';
    }
    if (_fontExtensions.contains(extension)) {
      return 'public, max-age=${fontTtl.inSeconds}';
    }
    return 'public, max-age=0, s-maxage=${htmlEdgeTtl.inSeconds}';
  }
}
