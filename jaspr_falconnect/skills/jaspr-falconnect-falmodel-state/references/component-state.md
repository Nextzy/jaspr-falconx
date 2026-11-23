# Component state

`package: jaspr_falmodel` (re-exports `dart_falmodel`, which supplies `UserFeedback`, `Success`, `Warning`, `Failure`, and `Information`): `ComponentState<T>` and `FullComponentState`.

## `ComponentState<T>`

An immutable value: a `FullComponentState state`, `T data`, a `UserFeedback feedback`, an optional `String? id`, and an optional one-shot `Object? event`. The constructor is private; start from a factory.

### Factories

One per `FullComponentState` value, all with the shape `factory ComponentState.x(T data, {String? id, UserFeedback? feedback})`:

`initial`, `normal`, `empty`, `hovered`, `focused`, `focusedVisible`, `pressed`, `dragged`, `selected`, `scrolledUnder`, `disabled`, `loading`, `success`, `cancel`, `warning`, `fail`.

`feedback` defaults to `Information()`, except `warning` (`Warning()`) and `fail` (`Failure()`).

### Transitions and transforms

| Member | Signature | `feedback` | `event` |
|---|---|---|---|
| `toX` (one per state: `toInitial`, `toLoading`, `toSuccess`, `toFail`, ...) | `ComponentState<T> toX({T? data, String? id, UserFeedback? feedback, bool? build})` | the argument, else the state's default | dropped |
| `toState` | `ComponentState<T> toState(FullComponentState state, {T? data, String? id, UserFeedback? feedback, bool? build})` | the argument, else `Information()` | dropped |
| `copy` | `ComponentState<T> copy({FullComponentState? state, String? id, UserFeedback? feedback, T? data, bool? build})` | the argument, else kept | dropped |
| `mapData` | `ComponentState<R> mapData<R>(R Function(T) f, {String? id, UserFeedback? feedback, bool? build})` | the argument, else kept | kept |
| `mapState` | `ComponentState<T> mapState(FullComponentState Function(FullComponentState) f, {String? id, UserFeedback? feedback, bool? build})` | the argument, else kept | kept |
| `apply` | `R apply<R>(R Function(FullComponentState, T) f)` | n/a | n/a |
| `addEvent` | `ComponentState<T> addEvent(Object event)` | kept | set |

A `null` `data` or `id` argument keeps the current value. `toState` passes `Information()` even for `FullComponentState.fail` or `.warning`; call `toFail` or `toWarning` to get their defaults. `build` is ignored everywhere.

### Getters

`state`, `data`, `feedback`, `id`, `event`; `is*` and `isNot*` for every state (`isLoading`, `isNotLoading`, `isFail`, ...); `hasData` (`data != null`) and `noData`.

```dart
ComponentState<List<String>> loadTags(List<String> tags) {
  var state = ComponentState.initial(<String>[]);
  state = state.toLoading();
  state = state.toSuccess(data: tags, feedback: const Success(message: 'Loaded'));
  return state;
}

ComponentState<List<String>> failLoading(ComponentState<List<String>> state) =>
    state.toFail(feedback: const Failure(message: 'Could not load tags'));

ComponentState<int> countTags(ComponentState<List<String>> state) =>
    state.mapData((tags) => tags.length);

String? feedbackMessage(ComponentState<Object?> state) =>
    state.isFail ? state.feedback.errorMessage : null;
```

### In a component

`ComponentState` is a plain value: keep it in a `State` field and replace it inside `setState`. In a `@client` island the state lives in the browser; the server render shows the initial value, so start the load behind `kIsWeb`.

```dart
class TagCount extends StatefulComponent {
  const TagCount({required this.loadCount, super.key});

  final Future<int> Function() loadCount;

  @override
  State<TagCount> createState() => _TagCountState();
}

class _TagCountState extends State<TagCount> {
  ComponentState<int> _count = ComponentState.loading(0);

  @override
  void initState() {
    super.initState();
    if (kIsWeb) _load();
  }

  Future<void> _load() async {
    final count = await component.loadCount();
    if (!mounted) return;
    setState(() => _count = _count.toSuccess(data: count));
  }

  @override
  Component build(BuildContext context) {
    if (_count.isLoading) return Component.text('Loading');
    return Component.text('${_count.data} tags');
  }
}
```

## One-shot events

`addEvent(event)` returns a copy carrying `event`. Every later `copy`, `to*`, or `toState` drops it (`mapData` and `mapState` keep it), so call `addEvent` last and the component reacts to the event once.

```dart
const String showSavedToast = 'show-saved-toast';

ComponentState<String> markSaved(ComponentState<String> state) =>
    state.toSuccess().addEvent(showSavedToast);

bool shouldShowSavedToast(ComponentState<String> state) =>
    state.event == showSavedToast;
```

## `FullComponentState`

Enum: `initial`, `normal`, `empty`, `hovered`, `focused`, `focusedVisible`, `pressed`, `dragged`, `selected`, `scrolledUnder`, `disabled`, `loading`, `success`, `cancel`, `warning`, `fail`. Each value has `is*` and `isNot*` getters.

```dart
ComponentState<String> disableWhileLoading(ComponentState<String> state) =>
    state.mapState(
      (current) =>
          current.isLoading ? FullComponentState.disabled : current,
    );
```

## Gotchas

- `ComponentState` has no `==` or `hashCode` override; two states built from the same values compare unequal.
- `isEmpty` is the `empty` state. Use `hasData` or `noData` to test the data for `null`.
- To clear `data` to `null`, build a new state with a factory; `copy(data: null)` keeps the old data.
- An app library that imports this barrel and also another library declaring `Failure`, `Success`, or `Warning` gets `ambiguous_import`; hide the name on one import.
