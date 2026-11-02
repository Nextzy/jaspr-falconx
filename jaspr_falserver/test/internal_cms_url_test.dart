import 'dart:async';
import 'dart:io';

import 'package:jaspr_falserver/jaspr_falserver.dart';
import 'package:test/test.dart';

void main() {
  group('validInternalCmsUrl', () {
    test('returns null for null, empty, and whitespace', () {
      expect(validInternalCmsUrl(null), isNull);
      expect(validInternalCmsUrl(''), isNull);
      expect(validInternalCmsUrl('  \n'), isNull);
    });

    test('trims a set URL', () {
      expect(
        validInternalCmsUrl(' http://directus.railway.internal:8055 '),
        'http://directus.railway.internal:8055',
      );
    });

    test('trims and strips one trailing slash', () {
      expect(
        validInternalCmsUrl(' http://directus.railway.internal:8055/ '),
        'http://directus.railway.internal:8055',
      );
    });

    test('returns null for a URL without a scheme', () {
      expect(validInternalCmsUrl('directus.railway.internal:8055'), isNull);
    });

    test('returns null for a non-http scheme', () {
      expect(validInternalCmsUrl('ftp://x'), isNull);
    });
  });

  group('resolveServerCmsBaseUrl', () {
    const public = 'https://cms.example.com';
    const internal = 'http://directus.railway.internal:8055';

    test('unset internal URL gives public and skips the probe', () async {
      var calls = 0;
      final result = await resolveServerCmsBaseUrl(
        publicUrl: public,
        probe: (_) async {
          calls++;
          return true;
        },
      );
      expect(result, public);
      expect(calls, 0);
    });

    test('valid internal URL with a passing probe gives internal', () async {
      String? probed;
      final result = await resolveServerCmsBaseUrl(
        publicUrl: public,
        internalUrl: '$internal/',
        probe: (url) async {
          probed = url;
          return true;
        },
      );
      expect(result, internal);
      expect(probed, internal);
    });

    test('a failing probe gives public and logs once', () async {
      final logs = <String>[];
      final result = await resolveServerCmsBaseUrl(
        publicUrl: public,
        internalUrl: internal,
        probe: (_) async => false,
        log: logs.add,
      );
      expect(result, public);
      expect(logs, hasLength(1));
    });

    test('a throwing probe gives public and logs the reason', () async {
      final logs = <String>[];
      final result = await resolveServerCmsBaseUrl(
        publicUrl: public,
        internalUrl: internal,
        probe: (_) async => throw StateError('HTTP 503'),
        log: logs.add,
      );
      expect(result, public);
      expect(logs.single, contains('HTTP 503'));
      expect(logs.single, isNot(contains('CMS_INTERNAL_API_BASE_URL')));
    });

    test('malformed internal URL gives public and skips the probe', () async {
      var calls = 0;
      final result = await resolveServerCmsBaseUrl(
        publicUrl: public,
        internalUrl: 'directus.railway.internal:8055',
        probe: (_) async {
          calls++;
          return true;
        },
      );
      expect(result, public);
      expect(calls, 0);
    });
  });

  group('pingOk', () {
    late HttpServer server;
    final open = <HttpResponse>[];

    tearDown(() async {
      for (final r in open) {
        unawaited(r.close().catchError((_) {}));
      }
      open.clear();
      await server.close(force: true);
    });

    test('returns true for a 200', () async {
      server = (await HttpServer.bind('127.0.0.1', 0))
        ..listen((req) {
          expect(req.uri.path, '/server/ping');
          unawaited((req.response..write('pong')).close());
        });
      expect(await pingOk('http://127.0.0.1:${server.port}'), isTrue);
    });

    test('throws for a non-200', () async {
      server = (await HttpServer.bind('127.0.0.1', 0))
        ..listen((req) {
          unawaited((req.response..statusCode = 503).close());
        });
      await expectLater(
        pingOk('http://127.0.0.1:${server.port}'),
        throwsStateError,
      );
    });

    test('gives up within about 2 s when the body never ends', () async {
      server = (await HttpServer.bind('127.0.0.1', 0))
        ..listen((req) {
          open.add(req.response);
          req.response
            ..bufferOutput = false
            ..headers.contentLength = 1000
            ..write('p');
        });
      final watch = Stopwatch()..start();
      await expectLater(
        pingOk('http://127.0.0.1:${server.port}'),
        throwsA(isA<TimeoutException>()),
      );
      expect(watch.elapsed, lessThan(const Duration(milliseconds: 2500)));
    });
  });
}
