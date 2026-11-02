import 'package:jaspr_falserver/jaspr_falserver.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

void main() {
  Future<Response> send(
    Handler inner, {
    String method = 'GET',
    Middleware? middleware,
  }) async => (middleware ?? securityHeadersMiddleware())(inner)(
    Request(method, Uri.parse('http://localhost/en/profile')),
  );

  test('exposes the default values', () {
    expect(defaultReferrerPolicy, 'strict-origin-when-cross-origin');
    expect(
      defaultPermissionsPolicy,
      'camera=(), microphone=(), geolocation=(), payment=(), usb=()',
    );
    expect(
      defaultContentSecurityPolicy,
      "frame-ancestors 'self'; base-uri 'self'; object-src 'none'",
    );
  });

  test('adds all three defaults to a 200 GET', () async {
    final r = await send((_) => Response.ok('x'));
    expect(r.headers['referrer-policy'], defaultReferrerPolicy);
    expect(r.headers['permissions-policy'], defaultPermissionsPolicy);
    expect(r.headers['content-security-policy'], defaultContentSecurityPolicy);
  });

  for (final (name, method, handler) in <(String, String, Handler)>[
    ('404', 'GET', (_) => Response.notFound('x')),
    ('503', 'GET', (_) => Response(503)),
    ('HEAD', 'HEAD', (_) => Response.ok(null)),
    ('304', 'GET', (_) => Response.notModified()),
  ]) {
    test('adds the headers to a $name response', () async {
      final r = await send(handler, method: method);
      expect(r.headers['referrer-policy'], defaultReferrerPolicy);
      expect(r.headers['permissions-policy'], defaultPermissionsPolicy);
      expect(
        r.headers['content-security-policy'],
        defaultContentSecurityPolicy,
      );
    });
  }

  test('keeps a header the inner handler set', () async {
    final r = await send(
      (_) => Response.ok(
        'x',
        headers: {'content-security-policy': "default-src 'self'"},
      ),
    );
    expect(r.headers['content-security-policy'], "default-src 'self'");
    expect(r.headers['referrer-policy'], defaultReferrerPolicy);
    expect(r.headers['permissions-policy'], defaultPermissionsPolicy);
  });

  test('null turns one header off and leaves the others', () async {
    final r = await send(
      (_) => Response.ok('x'),
      middleware: securityHeadersMiddleware(permissionsPolicy: null),
    );
    expect(r.headers.containsKey('permissions-policy'), isFalse);
    expect(r.headers['referrer-policy'], defaultReferrerPolicy);
    expect(r.headers['content-security-policy'], defaultContentSecurityPolicy);
  });

  test('uses a custom value verbatim', () async {
    final r = await send(
      (_) => Response.ok('x'),
      middleware: securityHeadersMiddleware(referrerPolicy: 'no-referrer'),
    );
    expect(r.headers['referrer-policy'], 'no-referrer');
  });

  test('rejects a value with a line break at creation', () {
    expect(
      () => securityHeadersMiddleware(referrerPolicy: 'a\nb'),
      throwsArgumentError,
    );
    expect(
      () => securityHeadersMiddleware(permissionsPolicy: 'a\rb'),
      throwsArgumentError,
    );
    expect(
      () => securityHeadersMiddleware(contentSecurityPolicy: 'a\r\nb'),
      throwsArgumentError,
    );
  });
}
