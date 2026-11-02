import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:jaspr_falserver/jaspr_falserver.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

Handler wrap(Future<Iterable<SitemapUrl>> Function() load) =>
    sitemapMiddleware(load)((_) => Response.notFound('inner'));

Request get(String url, {String method = 'GET'}) =>
    Request(method, Uri.parse(url));

void main() {
  group('renderSitemap', () {
    test('writes loc, lastmod and alternates, escaped', () {
      final xml = renderSitemap([
        SitemapUrl(
          loc: 'https://mangmee.finance/th/blogs/a&b',
          alternates: {
            'th': 'https://mangmee.finance/th/blogs/a&b',
            'en': 'https://mangmee.finance/en/blogs/a&b',
          },
          lastModified: DateTime.utc(2026, 11, 2, 23),
        ),
      ]);
      expect(xml, startsWith('<?xml version="1.0" encoding="UTF-8"?>'));
      expect(
        xml,
        contains(
          '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" '
          'xmlns:xhtml="http://www.w3.org/1999/xhtml">',
        ),
      );
      expect(
        xml,
        contains('<loc>https://mangmee.finance/th/blogs/a&amp;b</loc>'),
      );
      expect(xml, contains('<lastmod>2026-11-02</lastmod>'));
      expect(
        xml,
        contains(
          '<xhtml:link rel="alternate" hreflang="en" '
          'href="https://mangmee.finance/en/blogs/a&amp;b"/>',
        ),
      );
    });

    test('escapes < > quotes and apostrophes', () {
      final xml = renderSitemap([const SitemapUrl(loc: 'https://x/<a>"b\'c')]);
      expect(xml, contains('<loc>https://x/&lt;a&gt;&quot;b&apos;c</loc>'));
    });

    test('omits lastmod and alternates when absent', () {
      final xml = renderSitemap([const SitemapUrl(loc: 'https://x/th')]);
      expect(xml, isNot(contains('lastmod')));
      expect(xml, isNot(contains('xhtml:link')));
    });
  });

  group('sitemapMiddleware', () {
    test('serves xml on GET and HEAD', () async {
      final ok = await wrap(
        () async => [const SitemapUrl(loc: 'https://x/th')],
      )(get('http://x/sitemap.xml'));
      expect(ok.statusCode, 200);
      expect(ok.headers['content-type'], 'application/xml; charset=utf-8');
      expect(await ok.readAsString(), contains('<loc>https://x/th</loc>'));
      expect(ok.headers.containsKey('cache-control'), isFalse);

      final head = await wrap(() async => [])(
        get('http://x/sitemap.xml', method: 'HEAD'),
      );
      expect(head.statusCode, 200);
    });

    test('passes other paths and methods through', () async {
      expect((await wrap(() async => [])(get('http://x/th'))).statusCode, 404);
      final post = await wrap(() async => [])(
        get('http://x/sitemap.xml', method: 'POST'),
      );
      expect(post.statusCode, 404);
    });

    test('answers 503 with retry-after when load throws', () async {
      final down = await wrap(() async => throw StateError('cms down'))(
        get('http://x/sitemap.xml'),
      );
      expect(down.statusCode, 503);
      expect(down.headers['retry-after'], '60');
    });

    test('writes exactly one stderr line for a multi-line error', () async {
      final sink = _CaptureStdout();
      await IOOverrides.runZoned(() async {
        await wrap(() async => throw StateError('cms\ndown'))(
          get('http://x/sitemap.xml'),
        );
      }, stderr: () => sink);
      final lines = const LineSplitter().convert(sink.text);
      expect(lines, hasLength(1));
      expect(lines.single, contains('cms down'));
    });

    test('does not serve a versioned URL as the sitemap', () async {
      final handler = const Pipeline()
          .addMiddleware(assetMiddleware(buildId: 'b1'))
          .addMiddleware(sitemapMiddleware(() async => []))
          .addHandler((_) => Response.notFound('inner'));
      final versioned = await handler(get('http://x/_v/b1/sitemap.xml'));
      expect(versioned.statusCode, isNot(200));
      expect(versioned.headers['cache-control'], 'no-store');
      final plain = await handler(get('http://x/sitemap.xml'));
      expect(plain.statusCode, 200);
      expect(
        plain.headers['cache-control'],
        'public, max-age=0, s-maxage=86400',
      );
    });
  });
}

class _CaptureStdout implements Stdout {
  final _buffer = StringBuffer();
  String get text => _buffer.toString();

  @override
  void writeln([Object? object = '']) => _buffer.writeln(object);

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}
