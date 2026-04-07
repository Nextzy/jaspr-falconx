import 'package:jaspr_falconnect/lib.dart';

class ResultStreamFetcher<T> {
  ResultStreamFetcher([StreamController<ComponentState<T?>>? controller])
      : _streamController =
            controller ?? StreamController<ComponentState<T?>>();

  final StreamController<ComponentState<T?>> _streamController;
  StreamSubscription? _streamSubscription;

  Stream<ComponentState<T?>> get stream => _streamController.stream;

  bool get isClose => _streamController.isClosed;

  T? _data;

  Stream<ComponentState<T?>> fetch(
    Stream<Result<T>> call,
  ) {
    _streamController.add(ComponentState.loading(_data));
    _streamSubscription = call.listen(
      (result) {
        result.when(
          (T data) {
            _data = data;
            _streamController.add(ComponentState.success(_data));
          },
          (exception, stackTrace) {
            _streamController.addError(exception, stackTrace);
            close();
          },
        );
      },
      onDone: close,
      onError: (Object error, StackTrace? stackTrace) {
        _streamController.addError(error, stackTrace);
        close();
      },
    );
    return _streamController.stream;
  }

  Future<void> close() async {
    _data = null;
    await _streamSubscription?.cancel();
    await _streamController.close();
  }
}
