import 'package:jaspr_falserver/src/asset_version.dart';

/// Chooses the `Cache-Control` value for a response.
class CachePolicy {
  const CachePolicy();

  static const _immutable = 'public, max-age=31536000, immutable';
  static const _edge = 'public, max-age=0, s-maxage=86400';
  static const _image = 'public, max-age=86400';
  static const _font = 'public, max-age=2592000';
  static const _noStore = 'no-store';

  static const _imageExtensions = {
    'avif', 'webp', 'svg', 'png', 'jpg', 'jpeg', 'gif', 'ico', //
  };
  static const _fontExtensions = {'woff2', 'woff', 'ttf', 'otf'};

  /// Returns the header to set, or null when [existing] must stay.
  ///
  /// [path] is the original request path, version prefix included.
  String? headerFor({
    required String path,
    required int statusCode,
    required String? existing,
    required String? buildId,
  }) {
    if (existing != null) return null;
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

    final extension = _extensionOf(path);
    if (_imageExtensions.contains(extension)) return _image;
    if (_fontExtensions.contains(extension)) return _font;
    return _edge;
  }

  static String _extensionOf(String path) {
    final name = path.substring(path.lastIndexOf('/') + 1);
    final dot = name.lastIndexOf('.');
    return dot < 0 ? '' : name.substring(dot + 1).toLowerCase();
  }
}
