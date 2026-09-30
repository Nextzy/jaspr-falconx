import 'package:jaspr_falconx/lib.dart';
import 'package:jaspr_riverpod/legacy.dart';

abstract class ComponentStateNotifier<T>
    extends StateNotifier<ComponentState<T>> {
  new(T initial) : super(ComponentState.initial(initial));
}

abstract class NullableComponentStateNotifier<T>
    extends StateNotifier<ComponentState<T?>> {
  new([T? initial])
      : super(ComponentState.initial(initial));
}
