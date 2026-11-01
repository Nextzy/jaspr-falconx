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
      final result = await repo.runDataCatching<int>(
        () async => throw DioException(
          requestOptions: RequestOptions(path: '/x'),
          type: DioExceptionType.connectionTimeout,
        ),
      );
      expect(result.isFailure, isTrue);
    });

    test('lifts a CommonException into DataLayerException', () async {
      final result = await repo.runDataCatching<int>(
        () async => throw const NetworkNotFoundException(),
      );
      expect(result.exception, isA<DataLayerException>());
      expect(result.exception.type, NetworkErrorType.notFound);
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
