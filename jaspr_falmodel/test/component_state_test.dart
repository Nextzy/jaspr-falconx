import 'package:jaspr_falmodel/lib.dart';
import 'package:test/test.dart';

void main() {
  group('ComponentState event', () {
    const event = 'e';
    final transforms =
        <String, ComponentState<int> Function(ComponentState<int>)>{
          'mapData': (s) => s.mapData((d) => d + 1),
          'mapState': (s) => s.mapState((state) => state),
        };

    for (final entry in transforms.entries) {
      test('${entry.key} keeps the event', () {
        final mapped = entry.value(ComponentState.normal(1).addEvent(event));

        expect(mapped.event, event);
      });
    }
  });
}
