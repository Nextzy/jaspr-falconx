import 'package:jaspr_falconnect/lib.dart';
import 'package:test/test.dart';

Future<void> _settle() => Future<void>.delayed(Duration.zero);

void main() {
  late ResultStreamFetcherList list;
  late Completer<Result<int>> completer;

  setUp(() {
    list = ResultStreamFetcherList();
    completer = Completer<Result<int>>();
  });

  tearDown(() => list.closeAsync());

  test('second caller subscribing before completion sees success', () async {
    final first = list.fetchFuture<int>(key: 'k', call: completer.future);
    final second = list.fetchFuture<int>(key: 'k', call: completer.future);

    final firstLast = first.last;
    final secondLast = second.last;
    completer.complete(Result.success(1));

    for (final state in [await firstLast, await secondLast]) {
      expect(state.isSuccess, isTrue);
      expect(state.data, 1);
    }
  });

  test('second caller subscribing after completion sees the replay', () async {
    list.fetchFuture<int>(key: 'k', call: completer.future);
    final second = list.fetchFuture<int>(key: 'k', call: completer.future);

    completer.complete(Result.success(1));
    await _settle();
    final state = await second.last;

    expect(state.isSuccess, isTrue);
    expect(state.data, 1);
  });

  test('late subscriber receives the replayed error', () async {
    final stream = list.fetchFuture<int>(key: 'k', call: completer.future);

    completer.complete(
      Result.failure(
        const DataLayerException(type: SystemErrorType.unexpected),
      ),
    );
    await _settle();

    await expectLater(stream, emitsError(isA<DataLayerException>()));
  });

  test('same key starts a new fetch once the first one completed', () async {
    list.fetchFuture<int>(key: 'k', call: completer.future);
    completer.complete(Result.success(1));
    await _settle();

    final third = await list
        .fetchFuture<int>(key: 'k', call: Future.value(Result.success(2)))
        .last;

    expect(third.data, 2);
  });
}
