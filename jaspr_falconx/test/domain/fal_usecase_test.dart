import 'package:jaspr_falconx/jaspr_falconx.dart';
import 'package:test/test.dart';

class _U extends FalUsecase {
  _U();
}

void main() {
  test('maps a thrown Exception to DomainLayerException', () async {
    final r = await _U().runDomainCatching<int>(
      () async => throw Exception('x'),
    );
    expect(r.isFailure, isTrue);
    expect(r.exception, isA<DomainLayerException>());
  });

  test('keeps a thrown CommonException', () async {
    const e = DomainLayerException(type: SystemErrorType.unexpected);
    final r = await _U().runDomainCatching<int>(() async => throw e);
    expect(r.exception, same(e));
  });

  test('passes a success through', () async {
    final r = await _U().runDomainCatching<int>(() async => Result.success(1));
    expect(r.value, 1);
  });

  test('requiredResultData rejects null', () {
    expect(
      () => _U().requiredResultData<int>(Result.success(null)),
      throwsA(isA<CommonException>()),
    );
  });

  test('requiredResultData rejects a failed validator', () {
    expect(
      () => _U().requiredResultData<int>(
        Result.success(1),
        validator: (v) => v > 1,
      ),
      throwsA(isA<CommonException>()),
    );
  });

  test('requiredFutureResultData returns the value', () async {
    expect(
      await _U().requiredFutureResultData<int>(Future.value(Result.success(7))),
      7,
    );
  });
}
