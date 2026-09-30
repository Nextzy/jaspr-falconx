import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falconx/lib.dart';
import 'package:jaspr_riverpod/legacy.dart';
import 'package:jaspr_riverpod/misc.dart';

abstract class PreloadComponentNotifier<DATA, EVENT>
    extends NullableComponentStateNotifier<DATA> {
  new({
    DATA? initialData,
    required DATA Function(dynamic json) fromJson,
    required String id,
  }) : _id = id,
       _codec = riverpodResultCodec(fromJson),
       super(initialData) {
    _preloadProvider = FutureProvider<Result<DATA?>>(
      (ref) async => preloadCall(),
      name: id,
      dependencies: const [],
    );
    _controllerProvider =
        StateNotifierProvider<
          PreloadComponentNotifier<DATA, EVENT>,
          ComponentState<DATA?>
        >((ref) {
          return this;
        });
  }

  final String _id;
  final Codec<Result<DATA?>, Object?> _codec;
  FutureProvider<Result<DATA?>>? _preloadProvider;
  StateNotifierProvider<
    PreloadComponentNotifier<DATA, EVENT>,
    ComponentState<DATA?>
  >?
  _controllerProvider;

  Future<Result<DATA?>> preloadCall();

  bool hasPreload(BuildContext context) {
    return context.read(_preloadProvider!).value != null;
  }

  Future<void> preload(BuildContext context) async {
    // Call on server only
    await context.read(_preloadProvider!.future);
  }

  /// Returns a [ProviderSync] to register in `ProviderScope(sync: [...])`
  /// so the preload result is hydrated from server to client.
  ///
  /// Per jaspr_riverpod docs, synced providers should be registered on the
  /// root `ProviderScope`. The underlying `_preloadProvider` is created with
  /// `dependencies: const []` so nested-scope overrides also work if needed.
  ProviderSync syncPreload() => _preloadProvider!.syncWith(_id, codec: _codec);

  ComponentState<DATA?> readPreload(BuildContext context) {
    final result = context.read(_preloadProvider!).value;
    if (result?.isFailure ?? false) {
      return ComponentState.fail(null, feedback: result!.exception.toFailure());
    }
    return ComponentState.initial(result?.valueOrNull);
  }

  ComponentState<DATA?> watch(BuildContext context) {
    final state = context.watch(_controllerProvider!);
    if (state.isInitial && state.data == null) {
      return readPreload(context);
    }
    return state;
  }

  ComponentState<DATA?> read(BuildContext context) {
    final state = context.read(_controllerProvider!);
    if (state.isInitial && state.data == null) {
      return readPreload(context);
    }
    return state;
  }

  void listenEvent(BuildContext context, void Function(EVENT event) listener) {
    context.listen(_controllerProvider!, (previous, value) {
      final event = value.event;
      if (event is EVENT && event != null) {
        listener(event);
      }
    });
  }

  void emitEvent(EVENT event) {
    state = state.addEvent(event as Object);
  }

  void emit({DATA? data, UserFeedback? feedback}) {
    state = state.toNormal(data: data, feedback: feedback);
  }

  void emitLoading({DATA? data, UserFeedback? feedback}) {
    state = state.toLoading(data: data, feedback: feedback);
  }

  void emitSuccess({DATA? data, UserFeedback? feedback}) {
    state = state.toSuccess(data: data, feedback: feedback);
  }

  void emitFail({DATA? data, UserFeedback? feedback}) {
    state = state.toFail(data: data, feedback: feedback);
  }

  void emitWarning({DATA? data, UserFeedback? feedback}) {
    state = state.toWarning(data: data, feedback: feedback);
  }

  @override
  void dispose() {
    _preloadProvider = null;
    _controllerProvider = null;
    super.dispose();
  }
}
