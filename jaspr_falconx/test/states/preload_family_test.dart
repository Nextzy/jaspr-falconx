import 'package:jaspr_falconx/src/states/preload_family.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_riverpod/misc.dart';
import 'package:test/test.dart';

class _Item {
  const _Item(this.id);
  factory fromJson(dynamic json) => _Item((json as Map)['id'] as String);
  final String id;
  Map<String, dynamic> toJson() => {'id': id};
}

void main() {
  group('PreloadFamily<T, K>', () {
    test('provider returns same FutureProvider instance for equal keys', () {
      final family = PreloadFamily<_Item?, String>(
        fetch: (k) async => _Item(k),
        fromJson: _Item.fromJson,
        keyToString: (k) => 'item-$k',
      );

      final p1 = family.provider('a');
      final p2 = family.provider('a');
      // Riverpod 3.x families return equal (==) providers for the same key,
      // not identical (same object reference).
      expect(p1 == p2, isTrue);
    });

    test('provider yields fetched value when read', () async {
      final family = PreloadFamily<_Item?, String>(
        fetch: (k) async => _Item('fetched-$k'),
        fromJson: _Item.fromJson,
        keyToString: (k) => 'item-$k',
      );

      final container = ProviderContainer();
      addTearDown(container.dispose);

      final value = await container.read(family.provider('x').future);
      expect(value?.id, 'fetched-x');
    });

    test('syncFor returns a ProviderSync', () {
      final family = PreloadFamily<_Item?, String>(
        fetch: (k) async => _Item(k),
        fromJson: _Item.fromJson,
        keyToString: (k) => 'item-$k',
      );

      final sync = family.syncFor('a');
      expect(sync, isA<ProviderSync>());
    });
  });

  group('PreloadListFamily<T, K>', () {
    test('provider yields fetched list when read', () async {
      final family = PreloadListFamily<_Item, String>(
        fetch: (k) async => [_Item('$k-1'), _Item('$k-2')],
        fromJson: _Item.fromJson,
        keyToString: (k) => 'list-$k',
      );

      final container = ProviderContainer();
      addTearDown(container.dispose);

      final list = await container.read(family.provider('en').future);
      expect(list.length, 2);
      expect(list[0].id, 'en-1');
      expect(list[1].id, 'en-2');
    });

    test('syncFor returns a ProviderSync', () {
      final family = PreloadListFamily<_Item, String>(
        fetch: (k) async => const [],
        fromJson: _Item.fromJson,
        keyToString: (k) => 'list-$k',
      );

      expect(family.syncFor('en'), isA<ProviderSync>());
    });
  });
}
