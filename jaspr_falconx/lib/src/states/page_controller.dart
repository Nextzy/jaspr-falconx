import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falconx/lib.dart';

abstract class PreloadComponentNotifier<DATA, EVENT>
    extends NullableComponentStateNotifier<DATA> {
  PreloadComponentNotifier({
    DATA? initialData,
    required DATA Function(Map<String, dynamic> json) fromJson,
    required String id,
  }) : super(initialData) {
    _preloadProvider = SyncProvider<Either<Failure, DATA?>>((ref) async {
      return preloadCall();
    }, id: id, name: id, codec: riverpodEitherCodec(fromJson));
    _controllerProvider = StateNotifierProvider<
        PreloadComponentNotifier<DATA, EVENT>, ComponentState<DATA?>>(
      name: id,
      (ref) {
        return this;
      },
    );
  }

  SyncProvider<Either<Failure, DATA?>>? _preloadProvider;
  StateNotifierProvider<PreloadComponentNotifier<DATA, EVENT>,
      ComponentState<DATA?>>? _controllerProvider;

  Future<Either<Failure, DATA?>> preloadCall();

  bool hasPreload(BuildContext context) {
    return context.read(_preloadProvider!).valueOrNull != null;
  }

  Future<void> preload(BuildContext context) async {
    // Call on server only
    await context.read(_preloadProvider!.future);
  }

  ComponentState<DATA?> readPreload(BuildContext context) {
      //** Preload data on server **//
      final either = context.read(_preloadProvider!).valueOrNull;
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
      final either = context.read(_preloadProvider!).valueOrNull;
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
      final either = context.read(_preloadProvider!).valueOrNull;
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
          listener(value.event as EVENT);
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
