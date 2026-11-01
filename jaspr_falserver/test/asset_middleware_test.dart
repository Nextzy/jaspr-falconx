import 'package:jaspr_falserver/jaspr_falserver.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

void main() {
  late String seen;
  late Request seenRequest;
  Response inner(Request r) {
    seen = r.url.path;
    seenRequest = r;
    return Response.ok('x');
  }

  final handler = assetMiddleware(buildId: 'b1')(inner);
  Future<Response> get(String path) async =>
      handler(Request('GET', Uri.parse('http://localhost/$path')));

  test('strips current version prefix and marks immutable', () async {
    final r = await get('_v/b1/main.client.dart.js');
    expect(seen, 'main.client.dart.js');
    expect(r.headers['cache-control'], 'public, max-age=31536000, immutable');
  });

  test('serves stale version from current files with no-store', () async {
    final r = await get('_v/old/main.client.dart.js_1.part.js');
    expect(seen, 'main.client.dart.js_1.part.js');
    expect(r.headers['cache-control'], 'no-store');
  });

  test('leaves an existing cache-control alone', () async {
    final h = assetMiddleware(buildId: 'b1')(
      (_) => Response.ok('x', headers: {'cache-control': 'no-store'}),
    );
    final r = await h(Request('GET', Uri.parse('http://localhost/en/profile')));
    expect(r.headers['cache-control'], 'no-store');
  });

  test('html gets the edge policy', () async {
    expect(
      (await get('en/profile')).headers['cache-control'],
      'public, max-age=0, s-maxage=86400',
    );
  });

  test('forwards query, method and headers faithfully', () async {
    await handler(
      Request(
        'GET',
        Uri.parse('http://localhost/_v/b1/main.client.dart.js?x=1'),
        headers: {'accept-encoding': 'gzip'},
      ),
    );
    expect(seenRequest.url.path, 'main.client.dart.js');
    expect(seenRequest.url.query, 'x=1');
    expect(seenRequest.method, 'GET');
    expect(seenRequest.headers['accept-encoding'], 'gzip');
  });
}
