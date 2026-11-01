import 'package:jaspr_falconx/jaspr_falconx.dart';
import 'package:test/test.dart';

void main() {
  group('pageErrorStatus', () {
    test('CMS 403 (Directus, unknown id) is 404', () {
      expect(pageErrorStatus(const NetworkForbiddenException()), 404);
    });

    test('CMS 404 is 404', () {
      expect(pageErrorStatus(const NetworkNotFoundException()), 404);
    });

    test('CMS 500 is 503', () {
      expect(pageErrorStatus(const NetworkInternalServerException()), 503);
    });

    test('a timeout is 503', () {
      expect(pageErrorStatus(const NetworkTimeoutException()), 503);
    });

    test('a network error is 503', () {
      expect(
        pageErrorStatus(
          const NetworkException(type: NetworkErrorType.network, statusCode: 0),
        ),
        503,
      );
      expect(pageErrorStatus(const NoInternetConnectException()), 503);
    });

    test('an unexpected error is 503', () {
      expect(
        pageErrorStatus(
          const DomainLayerException(type: SystemErrorType.unexpected),
        ),
        503,
      );
    });

    // requiredResultData rethrows a plain CommonException that keeps only
    // the type of the network exception.
    test('reads the status from a copied exception type', () {
      expect(
        pageErrorStatus(
          const CommonException(type: NetworkErrorType.forbidden),
        ),
        404,
      );
      expect(
        pageErrorStatus(
          const CommonException(type: NetworkErrorType.internalServerError),
        ),
        503,
      );
    });
  });

  group('isExpectedPageFailure', () {
    test('CMS 403 and 404 are expected', () {
      expect(isExpectedPageFailure(const NetworkForbiddenException()), isTrue);
      expect(isExpectedPageFailure(const NetworkNotFoundException()), isTrue);
    });

    test('CMS 500 and a timeout are not expected', () {
      expect(
        isExpectedPageFailure(const NetworkInternalServerException()),
        isFalse,
      );
      expect(isExpectedPageFailure(const NetworkTimeoutException()), isFalse);
    });
  });
}
