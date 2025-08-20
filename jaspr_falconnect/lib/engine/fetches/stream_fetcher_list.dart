import 'package:jaspr_falconnect/lib.dart';

class EitherStreamFetcherList {
  final Map<dynamic, EitherStreamFetcher> _fetcherMap = {};

  Stream<ComponentState<T?>> fetchStream<T>({
    required Object key,
    required Stream<Either<Failure, T>> call,
    bool debounceFetch = true,
  }) {
    _fetcherMap.removeWhere((key, value) => value.isClose);
    if (_canFetch(key, debounceFetch)) {
      final fetcher = EitherStreamFetcher<T>();
      _fetcherMap[key] = fetcher;
      return fetcher.fetch(call);
    } else {
      return (_fetcherMap[key]! as EitherStreamFetcher<T>).stream;
    }
  }

  Stream<ComponentState<T?>> fetchFuture<T>({
    required Object key,
    required Future<Either<Failure, T>> call,
    bool debounceFetch = true,
  }) =>
      fetchStream<T>(
        key: key,
        call: Stream.fromFuture(call),
        debounceFetch: debounceFetch,
      );


  bool _canFetch(Object key, bool debounceFetch) {
    if (debounceFetch) {
      return _fetcherMap[key] == null;
    } else {
      // Remove and close old fetcher before.
      final fetcher = _fetcherMap.remove(key);
      fetcher?.close();
      return true;
    }
  }

  void closeSync() {
    _fetcherMap.forEach((key, fetcher) => fetcher.close());
  }

  Future<void> closeAsync() async {
    await Future.wait(_fetcherMap
        .mapEntries(
          (fetcher) => fetcher.value.close(),
        )
        .toList());
  }
}
