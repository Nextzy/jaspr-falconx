import 'package:dart_falconnect/dart_falconnect.dart';
import 'package:jaspr_faltool/lib.dart' show kDebugMode;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Builds the [HttpClientConfig] a Jaspr app starts from.
///
/// Sends JSON, applies [timeout] to connect and receive, places the caller's
/// [interceptors] first, and ends the chain with [exceptionHandler] when set.
///
/// A [PrettyDioLogger] joins the interceptor list only when [debugLogging]
/// is true. It defaults to jaspr's compile-time `kDebugMode`, so release
/// builds never construct the logger.
HttpClientConfig jasprHttpClientConfig({
  List<Interceptor> interceptors = const [],
  NetworkExceptionHandlerInterceptor? exceptionHandler,
  Duration timeout = const Duration(seconds: 20),
  bool? debugLogging,
}) {
  return HttpClientConfig(
    contentType: Headers.jsonContentType,
    connectTimeout: timeout,
    receiveTimeout: timeout,
    exceptionHandler: exceptionHandler,
    interceptors: [
      ...interceptors,
      if (debugLogging ?? kDebugMode)
        PrettyDioLogger(
          request: true,
          requestHeader: false,
          requestBody: false,
          responseHeader: false,
          responseBody: false,
          error: true,
          maxWidth: 120,
          compact: true,
        ),
    ],
  );
}
