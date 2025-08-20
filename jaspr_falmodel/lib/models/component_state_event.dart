import 'package:jaspr_falmodel/lib.dart';

enum FullComponentState {
  initial,
  normal,
  empty,
  hovered,
  focused,
  focusedVisible,
  pressed,
  dragged,
  selected,
  scrolledUnder,
  disabled,
  loading,
  success,
  cancel,
  warning,
  fail;

  bool get isInitial => this == FullComponentState.initial; //
  bool get isNormal => this == FullComponentState.normal; //
  bool get isEmpty => this == FullComponentState.empty; //
  bool get isHovered => this == FullComponentState.hovered; //
  bool get isFocused => this == FullComponentState.focused; //
  bool get isFocusedVisible => this == FullComponentState.focusedVisible; //
  bool get isPressed => this == FullComponentState.pressed; //
  bool get isDragged => this == FullComponentState.dragged; //
  bool get isSelected => this == FullComponentState.selected; //
  bool get isScrolledUnder => this == FullComponentState.scrolledUnder; //
  bool get isDisabled => this == FullComponentState.disabled; //
  bool get isLoading => this == FullComponentState.loading; //
  bool get isSuccess => this == FullComponentState.success; //
  bool get isFail => this == FullComponentState.fail; //
  bool get isWarning => this == FullComponentState.warning; //
  bool get isCancel => this == FullComponentState.cancel; //

  bool get isNotInitial => !isInitial; //
  bool get isNotNormal => !isNormal; //
  bool get isNotEmpty => !isEmpty; //
  bool get isNotHovered => !isHovered; //
  bool get isNotFocused => !isFocused; //
  bool get isNotFocusedVisible => !isFocusedVisible; //
  bool get isNotPressed => !isPressed; //
  bool get isNotDragged => !isDragged; //
  bool get isNotSelected => !isSelected; //
  bool get isNotScrolledUnder => !isScrolledUnder; //
  bool get isNotDisabled => !isDisabled; //
  bool get isNotLoading => !isLoading; //
  bool get isNotSuccess => !isSuccess; //
  bool get isNotFail => !isFail; //
  bool get isNotWarning => !isWarning; //
  bool get isNotCancel => !isCancel; //
}

@immutable
class ComponentState<DATA> {
  const ComponentState._(
    this.state, {
    this.id,
    this.event,
    required this.data,
    required this.feedback,
  });

  final FullComponentState state;
  final String? id;

  /// Purpose to [UserFeedback] for show the message or data on the widgets
  final UserFeedback feedback;

  /// Purpose of event for communicate BLoC --> Component
  /// Important: [event] not copy because event must use for one time.
  /// if you want to send [event] to view, please use [addEvent]
  final Object? event;

  final DATA data;

  factory ComponentState.initial(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.initial,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  factory ComponentState.normal(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.normal,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  factory ComponentState.empty(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.empty,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  factory ComponentState.hovered(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.hovered,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  factory ComponentState.focused(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.focused,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  factory ComponentState.focusedVisible(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.focusedVisible,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  factory ComponentState.pressed(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.pressed,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  factory ComponentState.dragged(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.dragged,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  factory ComponentState.selected(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.selected,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  factory ComponentState.scrolledUnder(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.scrolledUnder,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  factory ComponentState.disabled(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.disabled,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  factory ComponentState.loading(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.loading,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  factory ComponentState.success(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.success,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  factory ComponentState.cancel(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.cancel,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  factory ComponentState.warning(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.warning,
    id: id,
    feedback: feedback ?? const Warning(),
    data: data,
  );

  factory ComponentState.fail(
    DATA data, {
    String? id,
    UserFeedback? feedback,
  }) => ComponentState._(
    FullComponentState.fail,
    id: id,
    feedback: feedback ?? const Failure(),
    data: data,
  );

  bool get isInitial => state.isInitial; //
  bool get isNormal => state.isNormal; //
  bool get isEmpty => state.isEmpty; //
  bool get isHovered => state.isHovered; //
  bool get isFocused => state.isFocused; //
  bool get isFocusedVisible => state.isFocusedVisible; //
  bool get isPressed => state.isPressed; //
  bool get isDragged => state.isDragged; //
  bool get isSelected => state.isSelected; //
  bool get isScrolledUnder => state.isScrolledUnder; //
  bool get isDisabled => state.isDisabled; //
  bool get isLoading => state.isLoading; //
  bool get isSuccess => state.isSuccess; //
  bool get isFail => state.isFail; //
  bool get isWarning => state.isWarning; //
  bool get isCancel => state.isCancel; //

  bool get isNotInitial => !isInitial; //
  bool get isNotNormal => !isNormal; //
  bool get isNotEmpty => !isEmpty; //
  bool get isNotHovered => !isHovered; //
  bool get isNotFocused => !isFocused; //
  bool get isNotFocusedVisible => !isFocusedVisible; //
  bool get isNotPressed => !isPressed; //
  bool get isNotDragged => !isDragged; //
  bool get isNotSelected => !isSelected; //
  bool get isNotScrolledUnder => !isScrolledUnder; //
  bool get isNotDisabled => !isDisabled; //
  bool get isNotLoading => !isLoading; //
  bool get isNotSuccess => !isSuccess; //
  bool get isNotFail => !isFail; //
  bool get isNotWarning => !isWarning; //
  bool get isNotCancel => !isCancel; //

  bool get hasData => data != null; //
  bool get noData => data == null; //

  R apply<R>(Function2<FullComponentState, DATA, R> f) => f(state, data);

  ComponentState<NT2> mapData<NT2>(
    Function1<DATA, NT2> f, {
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => ComponentState._(
    state,
    data: f(data),
    id: id ?? this.id,
    feedback: feedback ?? this.feedback,
  );

  ComponentState<DATA> mapState(
    Function1<FullComponentState, FullComponentState> f, {
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => ComponentState._(
    f(state),
    id: id ?? this.id,
    data: data,
    feedback: feedback ?? this.feedback,
  );

  ComponentState<DATA> toState(
    FullComponentState state, {
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: state,
    id: id,
    data: data,
    feedback: feedback ?? const Information(),
  );

  ComponentState<DATA> toInitial({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.initial,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  ComponentState<DATA> toNormal({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.normal,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  ComponentState<DATA> toEmpty({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.empty,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  ComponentState<DATA> toHovered({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.hovered,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  ComponentState<DATA> toFocused({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.focused,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  ComponentState<DATA> toFocusedVisible({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.focusedVisible,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  ComponentState<DATA> toPressed({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.pressed,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  ComponentState<DATA> toDragged({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.dragged,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  ComponentState<DATA> toSelected({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.selected,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  ComponentState<DATA> toScrolledUnder({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.scrolledUnder,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  ComponentState<DATA> toDisabled({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.disabled,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  ComponentState<DATA> toLoading({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.loading,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  ComponentState<DATA> toSuccess({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.success,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  ComponentState<DATA> toCancel({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.cancel,
    id: id,
    feedback: feedback ?? const Information(),
    data: data,
  );

  ComponentState<DATA> toWarning({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.warning,
    id: id,
    feedback: feedback ?? const Warning(),
    data: data,
  );

  ComponentState<DATA> toFail({
    DATA? data,
    String? id,
    UserFeedback? feedback,
    bool? build,
  }) => copy(
    state: FullComponentState.fail,
    id: id,
    feedback: feedback ?? const Failure(),
    data: data,
  );

  /// Important: Do not copy [event] because event must use that one time.
  /// [event] if you want to send event to view, please use [addEvent]
  /// [build] this flag use for control rebuild at widget.
  ComponentState<DATA> copy({
    FullComponentState? state,
    String? id,
    UserFeedback? feedback,
    DATA? data,
    bool? build,
  }) => ComponentState<DATA>._(
    state ?? this.state,
    id: id ?? this.id,
    data: data ?? this.data,
    feedback: feedback ?? this.feedback,
  );

  ComponentState<DATA> addEvent(Object event) => ComponentState<DATA>._(
    state,
    id: id,
    data: data,
    feedback: feedback,
    event: event,
  );

  @override
  String toString() {
    return 'ComponentState{state: $state, id: $id, data: $data, feedback: $feedback, event: $event}';
  }
}
