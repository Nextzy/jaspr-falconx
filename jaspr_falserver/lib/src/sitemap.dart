import 'dart:io';

import 'package:jaspr_falserver/src/asset_middleware.dart'
    show versionedContextKey;
import 'package:shelf/shelf.dart';

/// One `<url>` entry: [loc], optional hreflang [alternates] keyed by language
/// code, and an optional [lastModified] written as a UTC date.
class SitemapUrl {
  const SitemapUrl({
    required this.loc,
    this.alternates = const {},
    this.lastModified,
  });

  final String loc;
  final Map<String, String> alternates;
  final DateTime? lastModified;
}

/// Renders [urls] as a sitemap XML document, escaping every URL.
String renderSitemap(Iterable<SitemapUrl> urls) {
  final buffer = StringBuffer()
    ..writeln('<?xml version="1.0" encoding="UTF-8"?>')
    ..writeln(
      '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" '
      'xmlns:xhtml="http://www.w3.org/1999/xhtml">',
    );
  for (final url in urls) {
    buffer
      ..writeln('<url>')
      ..writeln('<loc>${_escape(url.loc)}</loc>');
    final modified = url.lastModified?.toUtc();
    if (modified != null) {
      buffer.writeln('<lastmod>${_date(modified)}</lastmod>');
    }
    url.alternates.forEach((language, href) {
      buffer.writeln(
        '<xhtml:link rel="alternate" hreflang="${_escape(language)}" '
        'href="${_escape(href)}"/>',
      );
    });
    buffer.writeln('</url>');
  }
  buffer.writeln('</urlset>');
  return buffer.toString();
}

/// Answers GET and HEAD on [path] with the sitemap built by [load]; every
/// other request passes through.
///
/// A throwing [load] gives 503 with `retry-after: 60`. The middleware sets no
/// `cache-control`; a `CacheHeaderPolicy` middleware above it does.
Middleware sitemapMiddleware(
  Future<Iterable<SitemapUrl>> Function() load, {
  String path = '/sitemap.xml',
}) {
  final relative = path.startsWith('/') ? path.substring(1) : path;
  return (inner) {
    return (request) async {
      final isRead = request.method == 'GET' || request.method == 'HEAD';
      final isVersioned = request.context.containsKey(versionedContextKey);
      if (!isRead || isVersioned || request.url.path != relative) {
        return inner(request);
      }
      try {
        final body = renderSitemap(await load());
        return Response.ok(
          body,
          headers: {'content-type': 'application/xml; charset=utf-8'},
        );
      } on Object catch (error) {
        final message = '$error'.replaceAll(RegExp(r'\s*[\r\n]+\s*'), ' ');
        stderr.writeln('sitemap load failed: $message');
        return Response(503, headers: {'retry-after': '60'});
      }
    };
  };
}

String _date(DateTime utc) {
  String two(int value) => value.toString().padLeft(2, '0');
  final year = utc.year.toString().padLeft(4, '0');
  return '$year-${two(utc.month)}-${two(utc.day)}';
}

String _escape(String value) => value
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&apos;');
