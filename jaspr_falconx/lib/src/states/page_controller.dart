import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falconx/lib.dart';
import 'package:jaspr_riverpod/legacy.dart';
import 'package:jaspr_riverpod/misc.dart';

abstract class PreloadComponentNotifier<DATA, EVENT>
    extends NullableComponentStateNotifier<DATA> {
  PreloadComponentNotifier({
    DATA? initialData,
    required DATA Function(dynamic json) fromJson,
    required String id,
  }) : _id = id,
       _codec = riverpodEitherCodec(fromJson),
       super(initialData) {
    _preloadProvider = FutureProvider<Either<Failure, DATA?>>(
      (ref) async => preloadCall(),
      name: id,
    );
    _controllerProvider =
        StateNotifierProvider<
          PreloadComponentNotifier<DATA, EVENT>,
          ComponentState<DATA?>
        >(
          name: id,
          (ref) {
            return this;
          },
        );
  }

  final String _id;
  final Codec<Either<Failure, DATA?>, Object?> _codec;
  FutureProvider<Either<Failure, DATA?>>? _preloadProvider;
  StateNotifierProvider<
    PreloadComponentNotifier<DATA, EVENT>,
    ComponentState<DATA?>
  >?
  _controllerProvider;

  Future<Either<Failure, DATA?>> preloadCall();

  bool hasPreload(BuildContext context) {
    return context.read(_preloadProvider!).value != null;
  }

  Future<void> preload(BuildContext context) async {
    // Call on server only
    await context.read(_preloadProvider!.future);
  }

  /// Returns a [ProviderSync] to register in `ProviderScope(sync: [...])`
  /// so the preload result is hydrated from server to client.
  ProviderSync syncPreload() => _preloadProvider!.syncWith(_id, codec: _codec);

  ComponentState<DATA?> readPreload(BuildContext context) {
    //** Preload data on server **//
    final either = context.read(_preloadProvider!).value;
    if (either?.isFailure ?? false) {
      return ComponentState.fail(null, feedback: either?.failure);
    } else {
      return ComponentState.initial(either?.data);
    }
  }

  ComponentState<DATA?> watch(BuildContext context) {
    final state = context.watch(_controllerProvider!);

    if (state.isInitial && state.data == null) {
      //** Preload data on server **//
      final either = context.read(_preloadProvider!).value;
      if (either?.isFailure ?? false) {
        return ComponentState.fail(null, feedback: either?.failure);
      } else {
        return ComponentState.initial(either?.data);
      }
    }

    return state;
  }

  ComponentState<DATA?> read(BuildContext context) {
    final state = context.read(_controllerProvider!);

    if (state.isInitial && state.data == null) {
      //** Preload data on server **//
      final either = context.read(_preloadProvider!).value;
      if (either?.isFailure ?? false) {
        return ComponentState.fail(null, feedback: either?.failure);
      } else {
        return ComponentState.initial(either?.data);
      }
    }

    return state;
  }

  void listenEvent(
    BuildContext context,
    void Function(EVENT event) listener,
  ) {
    context.listen(
      _controllerProvider!,
      (previous, value) {
        final event = value.event;
        if (event is EVENT && event != null) {
          listener(event);
        }
      },
    );
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
