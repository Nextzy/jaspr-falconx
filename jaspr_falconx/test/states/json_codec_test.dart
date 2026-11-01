import 'package:jaspr_falconx/src/states/json_codec.dart';
import 'package:test/test.dart';

class _Sample {
  const _Sample(this.id, this.label);
  factory fromJson(dynamic json) {
    final m = json as Map;
    return _Sample(m['id'] as String, m['label'] as String);
  }
  final String id;
  final String label;
  Map<String, dynamic> toJson() => {'id': id, 'label': label};
}

void main() {
  group('jsonCodec<T>', () {
    final codec = jsonCodec<_Sample>(_Sample.fromJson);

    test('roundtrips a non-null value preserving fields', () {
      final encoded = codec.encode(const _Sample('42', 'hello'));
      final decoded = codec.decode(encoded);
      expect(decoded, isNotNull);
      expect(decoded!.id, '42');
      expect(decoded.label, 'hello');
    });

    test('roundtrips null as null', () {
      final encoded = codec.encode(null);
      final decoded = codec.decode(encoded);
      expect(encoded, isNull);
      expect(decoded, isNull);
    });
  });

  group('jsonListCodec<T>', () {
    final codec = jsonListCodec<_Sample>(_Sample.fromJson);

    test('roundtrips a list of values', () {
      const input = [_Sample('1', 'a'), _Sample('2', 'b')];
      final encoded = codec.encode(input);
      final decoded = codec.decode(encoded);
      expect(decoded.length, 2);
      expect(decoded[0].id, '1');
      expect(decoded[0].label, 'a');
      expect(decoded[1].id, '2');
      expect(decoded[1].label, 'b');
    });

    test('roundtrips an empty list', () {
      final encoded = codec.encode(const []);
      final decoded = codec.decode(encoded);
      expect(decoded, isEmpty);
    });
  });
}
