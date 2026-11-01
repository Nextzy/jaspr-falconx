import 'package:jaspr_falconnect/jaspr_falconnect.dart';
import 'package:jaspr_falmodel/jaspr_falmodel.dart';
import 'package:test/test.dart';

class _Repo extends FalRepository;

void main() {
  final repo = _Repo();

  group('FalRepository.runDataCatching', () {
    test('returns the result of execute', () async {
      final result = await repo.runDataCatching(() async => Result.success(1));
      expect(result.value, 1);
    });

    test('maps DioException through toException', () async {
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/x'),
        type: DioExceptionType.connectionTimeout,
      );
      final result = await repo.runDataCatching<int>(
        () async => throw dioError,
      );
      expect(result.isFailure, isTrue);
      expect(result.exception.type, dioError.toException().type);
      expect(result.exception.type, isNot(SystemErrorType.unexpected));
    });

    test('copies every field of a CommonException', () async {
      final original = Exception('root');
      final trace = StackTrace.fromString('#0 here');
      final result = await repo.runDataCatching<int>(
        () async => throw CommonException(
          type: NetworkErrorType.notFound,
          userMessage: 'user text',
          developerMessage: 'dev text',
          originalException: original,
          stackTrace: trace,
        ),
      );
      expect(result.exception, isA<DataLayerException>());
      expect(result.exception.type, NetworkErrorType.notFound);
      expect(result.exception.userMessage, 'user text');
      expect(result.exception.developerMessage, 'dev text');
      expect(result.exception.originalException, same(original));
      expect(result.exception.stackTrace, same(trace));
    });

    test('keeps a DataLayerException as is', () async {
      const original = DataLayerException(type: NetworkErrorType.notFound);
      final result = await repo.runDataCatching<int>(
        () async => throw original,
      );
      expect(result.exception, same(original));
    });

    test('wraps any other thrown object as unexpected', () async {
      final result = await repo.runDataCatching<int>(
        () async => throw StateError('boom'),
      );
      expect(result.exception.type, SystemErrorType.unexpected);
      expect(result.exception.developerMessage, contains('boom'));
    });
  });
}
