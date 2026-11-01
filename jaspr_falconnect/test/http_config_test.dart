import 'package:jaspr_falconnect/jaspr_falconnect.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:test/test.dart';

class _Probe extends Interceptor;

void main() {
  group('jasprHttpClientConfig', () {
    test('keeps the caller interceptors first', () {
      final probe = _Probe();
      final config = jasprHttpClientConfig(
        interceptors: [probe],
        debugLogging: false,
      );
      expect(config.interceptors.first, same(probe));
    });

    test('maps timeout to connect and receive timeouts', () {
      final config = jasprHttpClientConfig(
        timeout: const Duration(seconds: 7),
        debugLogging: false,
      );
      expect(config.connectTimeout, const Duration(seconds: 7));
      expect(config.receiveTimeout, const Duration(seconds: 7));
      expect(config.contentType, Headers.jsonContentType);
    });

    test('defaults to a 20 second timeout', () {
      final config = jasprHttpClientConfig(debugLogging: false);
      expect(config.connectTimeout, const Duration(seconds: 20));
    });

    test('debug branch appends the logger after caller interceptors', () {
      final probe = _Probe();
      final config = jasprHttpClientConfig(
        interceptors: [probe],
        debugLogging: true,
      );
      expect(config.interceptors.first, same(probe));
      expect(config.interceptors.last, isA<PrettyDioLogger>());
    });

    test('release branch leaves the logger out of the list', () {
      final config = jasprHttpClientConfig(debugLogging: false);
      expect(config.interceptors.whereType<PrettyDioLogger>(), isEmpty);
    });

    test('forwards the exception handler', () {
      final handler = DefaultNetworkExceptionHandlerInterceptor();
      final config = jasprHttpClientConfig(
        exceptionHandler: handler,
        debugLogging: false,
      );
      expect(config.exceptionHandler, same(handler));
    });
  });
}
