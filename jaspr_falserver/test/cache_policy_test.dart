import 'package:jaspr_falserver/jaspr_falserver.dart';
import 'package:test/test.dart';

void main() {
  const p = CachePolicy();
  String? h(
    String path, {
    int status = 200,
    String? existing,
    String? id = 'b1',
  }) => p.headerFor(
    path: path,
    statusCode: status,
    existing: existing,
    buildId: id,
  );

  test('keeps a header the render already set', () {
    expect(h('en/profile', existing: 'no-store'), isNull);
  });

  test('non-2xx is no-store', () {
    expect(h('en/x', status: 404), 'no-store');
    expect(h('', status: 302), 'no-store');
    expect(h('en/x', status: 500), 'no-store');
  });

  test('304 revalidation keeps the path-based policy', () {
    expect(
      h('_v/b1/main.client.dart.js', status: 304),
      'public, max-age=31536000, immutable',
    );
    expect(h('en/profile', status: 304), 'public, max-age=0, s-maxage=86400');
    expect(h('_v/old/a.js', status: 304), 'no-store');
  });

  test('current version is immutable', () {
    expect(
      h('_v/b1/main.client.dart.js'),
      'public, max-age=31536000, immutable',
    );
  });

  test('stale version is no-store', () {
    expect(h('_v/old/main.client.dart.js_1.part.js'), 'no-store');
  });

  test('images 1 day', () {
    for (final e in [
      'avif', 'webp', 'svg', 'png', 'jpg', 'jpeg', 'gif', 'ico', //
    ]) {
      expect(h('images/a.$e'), 'public, max-age=86400');
    }
    expect(h('images/A.PNG'), 'public, max-age=86400');
  });

  test('fonts 30 days, not immutable', () {
    for (final e in ['woff2', 'woff', 'ttf', 'otf']) {
      expect(h('fonts/a.$e'), 'public, max-age=2592000');
    }
  });

  test('html and unversioned files: edge 1 day, browser revalidates', () {
    for (final path in [
      'en/profile',
      '',
      'main.client.dart.js',
      'styles.css',
      'sitemap.xml',
      'llms.txt',
    ]) {
      expect(h(path), 'public, max-age=0, s-maxage=86400');
    }
  });

  test('no build id: _v paths are stale', () {
    expect(h('_v/b1/styles.css', id: null), 'no-store');
  });
}
