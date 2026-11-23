import 'package:jaspr_falconnect/jaspr_falconnect.dart';
import 'package:test/test.dart';

void main() {
  test('barrel exports Result and ComponentState', () {
    final result = Result<int>.success(1);
    final state = ComponentState<int>.normal(1);

    expect(result.isSuccess, isTrue);
    expect(state, isA<ComponentState<int>>());
  });
}
