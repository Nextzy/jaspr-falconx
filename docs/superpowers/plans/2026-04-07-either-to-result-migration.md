# Either → Result Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace `Either<Failure, T>` with `Result<T>` across the `jaspr-falconx` monorepo, unifying error handling on `CommonException`.

**Architecture:** Introduce a `CommonException → Failure` adapter extension local to `jaspr_falconx`, rename `Either*` types/codecs/fetchers to `Result*`, change the `riverpod_codec.dart` JSON shape, and update the `page_controller.dart` boundary to call the adapter before handing feedback to `ComponentState.fail`.

**Tech Stack:** Dart, `dart_falmodel.Result`, `dart_falmodel.CommonException`, `jaspr_riverpod`, Melos workspace.

**Spec:** `docs/superpowers/specs/2026-04-07-either-to-result-migration-design.md`

---

## File Structure

**Create:**
- `jaspr_falconx/lib/src/extensions/common_exception_feedback_ext.dart` — adapter
- `jaspr_falconx/lib/src/extensions/extensions.dart` — barrel
- `jaspr_falconx/test/common_exception_feedback_ext_test.dart`
- `jaspr_falconx/test/riverpod_result_codec_test.dart`

**Modify:**
- `jaspr_falconx/lib/src/src.dart` — add extensions export
- `jaspr_falconx/lib/src/states/riverpod_codec.dart` — rename + reshape
- `jaspr_falconx/lib/src/states/page_controller.dart` — swap types + boundary adapter
- `jaspr_falconnect/lib/engine/fetches/stream_fetcher.dart` — rename + retype
- `jaspr_falconnect/lib/engine/fetches/stream_fetcher_list.dart` — rename + retype
- `docs/superpowers/plans/2026-04-07-package-version-migration.md` — update code samples

---

## Task 1: Adapter extension + tests

**Files:**
- Create: `jaspr_falconx/lib/src/extensions/common_exception_feedback_ext.dart`
- Create: `jaspr_falconx/lib/src/extensions/extensions.dart`
- Create: `jaspr_falconx/test/common_exception_feedback_ext_test.dart`
- Modify: `jaspr_falconx/lib/src/src.dart`

- [ ] **Step 1: Write the failing test**

Create `jaspr_falconx/test/common_exception_feedback_ext_test.dart`:

```dart
import 'package:jaspr_falconx/lib.dart';
import 'package:test/test.dart';

void main() {
  group('CommonExceptionFeedbackX.toFailure', () {
    test('uses userMessage when available, default level medium', () {
      final ex = CommonException(
        type: ErrorType.notFound,
        userMessage: 'not found',
        developerMessage: 'dev msg',
      );
      final f = ex.toFailure();
      expect(f.message, 'not found');
      expect(f.level, FeedbackLevel.medium);
    });

    test('falls back to developerMessage when userMessage is null', () {
      final ex = CommonException(
        type: ErrorType.unknown,
        developerMessage: 'dev only',
      );
      expect(ex.toFailure().message, 'dev only');
    });

    test('message is null when both messages are null', () {
      final ex = CommonException(type: ErrorType.unknown);
      expect(ex.toFailure().message, isNull);
    });

    test('accepts custom level', () {
      final ex = CommonException(
        type: ErrorType.permission,
        userMessage: 'denied',
      );
      final f = ex.toFailure(level: FeedbackLevel.high);
      expect(f.level, FeedbackLevel.high);
    });
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd jaspr_falconx && dart test test/common_exception_feedback_ext_test.dart`
Expected: compile error — `toFailure` undefined on `CommonException`.

- [ ] **Step 3: Implement the extension**

Create `jaspr_falconx/lib/src/extensions/common_exception_feedback_ext.dart`:

```dart
import 'package:jaspr_falconx/lib.dart';

extension CommonExceptionFeedbackX on CommonException {
  Failure toFailure({FeedbackLevel level = FeedbackLevel.medium}) => Failure(
        message: userMessage ?? developerMessage,
        level: level,
      );
}
```

Create `jaspr_falconx/lib/src/extensions/extensions.dart`:

```dart
export 'common_exception_feedback_ext.dart';
```

Modify `jaspr_falconx/lib/src/src.dart` — append one line:

```dart
export 'extensions/extensions.dart';
export 'states/states.dart';
```

- [ ] **Step 4: Run test to verify it passes**

Run: `cd jaspr_falconx && dart test test/common_exception_feedback_ext_test.dart`
Expected: all 4 tests PASS.

- [ ] **Step 5: Commit**

```bash
git add jaspr_falconx/lib/src/extensions jaspr_falconx/lib/src/src.dart jaspr_falconx/test/common_exception_feedback_ext_test.dart
git commit -m "feat(falconx): add CommonException.toFailure adapter extension"
```

---

## Task 2: `riverpod_codec.dart` — rename and reshape to `Result`

**Files:**
- Modify: `jaspr_falconx/lib/src/states/riverpod_codec.dart`
- Create: `jaspr_falconx/test/riverpod_result_codec_test.dart`

- [ ] **Step 1: Write failing round-trip test**

Create `jaspr_falconx/test/riverpod_result_codec_test.dart`:

```dart
import 'package:jaspr_falconx/lib.dart';
import 'package:test/test.dart';

class _Data {
  _Data(this.v);
  factory _Data.fromJson(dynamic json) => _Data((json as Map)['v'] as int);
  final int v;
  Map<String, dynamic> toJson() => {'v': v};
}

void main() {
  group('riverpodResultCodec', () {
    final codec = riverpodResultCodec<_Data>(_Data.fromJson);

    test('encodes and decodes a success result', () {
      final encoded = codec.encode(Result.success(_Data(42)));
      final decoded = codec.decode(encoded);
      expect(decoded.isSuccess, true);
      expect(decoded.value.v, 42);
    });

    test('encodes and decodes a failure result preserving type enum', () {
      final encoded = codec.encode(
        Result<_Data>.failure(
          CommonException(
            type: ErrorType.notFound,
            userMessage: 'missing',
            developerMessage: 'dev',
          ),
        ),
      );
      final decoded = codec.decode(encoded);
      expect(decoded.isFailure, true);
      expect(decoded.exception.type, ErrorType.notFound);
      expect(decoded.exception.userMessage, 'missing');
      expect(decoded.exception.developerMessage, 'dev');
    });

    test('decoder falls back to ErrorType.unknown for unknown type name', () {
      const bad = '{"exception":{"type":"nope","userMessage":"x"}}';
      final decoded = codec.decoder.convert(bad);
      expect(decoded.isFailure, true);
      expect(decoded.exception.type, ErrorType.unknown);
      expect(decoded.exception.userMessage, 'x');
    });

    test('decoder falls back to ErrorType.unknown for missing type', () {
      const bad = '{"exception":{"userMessage":"x"}}';
      final decoded = codec.decoder.convert(bad);
      expect(decoded.exception.type, ErrorType.unknown);
    });
  });
}
```

- [ ] **Step 2: Run to confirm failure**

Run: `cd jaspr_falconx && dart test test/riverpod_result_codec_test.dart`
Expected: compile error — `riverpodResultCodec` undefined.

- [ ] **Step 3: Replace `riverpod_codec.dart` contents**

Overwrite `jaspr_falconx/lib/src/states/riverpod_codec.dart`:

```dart
import 'package:jaspr_falconx/lib.dart';

Codec<T, Object?> riverpodCodec<T>(
  T Function(dynamic json) fromJson,
) => RiverpodCodec(fromJson);

Codec<Result<T>, Object?> riverpodResultCodec<T>(
  T Function(dynamic json) fromJson,
) => RiverpodResultCodec(fromJson);

class RiverpodEncoder<T> extends Converter<T, Object?> {
  @override
  Object? convert(T input) => jsonEncode(input);
}

class RiverpodDecoder<T> extends Converter<Object?, T> {
  const RiverpodDecoder(this.fromJson);

  final T Function(Map<String, dynamic> json) fromJson;

  @override
  T convert(Object? input) =>
      fromJson(jsonDecode(input as String) as Map<String, dynamic>);
}

class RiverpodCodec<T> extends Codec<T, Object?> {
  const RiverpodCodec(this.fromJson);

  final T Function(Map<String, dynamic> json) fromJson;

  @override
  Converter<T, Object?> get encoder => RiverpodEncoder();

  @override
  Converter<Object?, T> get decoder => RiverpodDecoder(fromJson);
}

class RiverpodResultEncoder<T> extends Converter<Result<T>, Object?> {
  @override
  Object? convert(Result<T> input) {
    final ex = input.exceptionOrNull;
    return jsonEncode({
      if (ex != null)
        'exception': {
          'type': ex.type is Enum
              ? (ex.type as Enum).name
              : ex.type.toString(),
          'userMessage': ex.userMessage,
          'developerMessage': ex.developerMessage,
        },
      'data': input.valueOrNull,
    });
  }
}

class RiverpodResultDecoder<T> extends Converter<Object?, Result<T>> {
  const RiverpodResultDecoder(this.fromJson);

  final T Function(dynamic json) fromJson;

  @override
  Result<T> convert(Object? input) {
    final json = jsonDecode(input as String) as Map<String, dynamic>;
    final exJson = json['exception'] as Map<String, dynamic>?;
    final dataJson = json['data'];

    if (exJson != null) {
      return Result.failure(
        CommonException(
          type: _parseErrorType(exJson['type'] as String?),
          userMessage: exJson['userMessage'] as String?,
          developerMessage: exJson['developerMessage'] as String?,
        ),
      );
    } else if (dataJson != null) {
      return Result.success(fromJson(dataJson));
    }
    throw Exception('Invalid json');
  }

  ErrorType _parseErrorType(String? name) {
    if (name == null) return ErrorType.unknown;
    try {
      return ErrorType.values.byName(name);
    } catch (_) {
      return ErrorType.unknown;
    }
  }
}

class RiverpodResultCodec<T> extends Codec<Result<T>, Object?> {
  const RiverpodResultCodec(this.fromJson);

  final T Function(dynamic json) fromJson;

  @override
  Converter<Result<T>, Object?> get encoder => RiverpodResultEncoder();

  @override
  Converter<Object?, Result<T>> get decoder =>
      RiverpodResultDecoder(fromJson);
}
```

- [ ] **Step 4: Run the codec tests**

Run: `cd jaspr_falconx && dart test test/riverpod_result_codec_test.dart`
Expected: all 4 tests PASS.

- [ ] **Step 5: Commit**

```bash
git add jaspr_falconx/lib/src/states/riverpod_codec.dart jaspr_falconx/test/riverpod_result_codec_test.dart
git commit -m "refactor(falconx): migrate riverpod codec from Either<Failure> to Result"
```

---

## Task 3: `page_controller.dart` — swap types + adapter at boundary

**Files:**
- Modify: `jaspr_falconx/lib/src/states/page_controller.dart`

- [ ] **Step 1: Rewrite the file**

Overwrite `jaspr_falconx/lib/src/states/page_controller.dart`:

```dart
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
       _codec = riverpodResultCodec(fromJson),
       super(initialData) {
    _preloadProvider = FutureProvider<Result<DATA?>>(
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
  ProviderSync syncPreload() => _preloadProvider!.syncWith(_id, codec: _codec);

  ComponentState<DATA?> readPreload(BuildContext context) {
    //** Preload data on server **//
    final result = context.read(_preloadProvider!).value;
    if (result?.isFailure ?? false) {
      return ComponentState.fail(
        null,
        feedback: result!.exception.toFailure(),
      );
    }
    return ComponentState.initial(result?.valueOrNull);
  }

  ComponentState<DATA?> watch(BuildContext context) {
    final state = context.watch(_controllerProvider!);

    if (state.isInitial && state.data == null) {
      //** Preload data on server **//
      final result = context.read(_preloadProvider!).value;
      if (result?.isFailure ?? false) {
        return ComponentState.fail(
          null,
          feedback: result!.exception.toFailure(),
        );
      }
      return ComponentState.initial(result?.valueOrNull);
    }

    return state;
  }

  ComponentState<DATA?> read(BuildContext context) {
    final state = context.read(_controllerProvider!);

    if (state.isInitial && state.data == null) {
      //** Preload data on server **//
      final result = context.read(_preloadProvider!).value;
      if (result?.isFailure ?? false) {
        return ComponentState.fail(
          null,
          feedback: result!.exception.toFailure(),
        );
      }
      return ComponentState.initial(result?.valueOrNull);
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
```

- [ ] **Step 2: Analyze `jaspr_falconx`**

Run: `cd jaspr_falconx && dart analyze`
Expected: no errors from this file.

- [ ] **Step 3: Commit**

```bash
git add jaspr_falconx/lib/src/states/page_controller.dart
git commit -m "refactor(falconx): migrate PreloadComponentNotifier to Result"
```

---

## Task 4: Rename `EitherStreamFetcher` → `ResultStreamFetcher`

**Files:**
- Modify: `jaspr_falconnect/lib/engine/fetches/stream_fetcher.dart`

- [ ] **Step 1: Rewrite the file**

Overwrite `jaspr_falconnect/lib/engine/fetches/stream_fetcher.dart`:

```dart
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
```

- [ ] **Step 2: Analyze**

Run: `cd jaspr_falconnect && dart analyze lib/engine/fetches/stream_fetcher.dart`
Expected: no errors.

- [ ] **Step 3: Commit**

```bash
git add jaspr_falconnect/lib/engine/fetches/stream_fetcher.dart
git commit -m "refactor(falconnect): rename EitherStreamFetcher to ResultStreamFetcher"
```

---

## Task 5: Rename `EitherStreamFetcherList` → `ResultStreamFetcherList`

**Files:**
- Modify: `jaspr_falconnect/lib/engine/fetches/stream_fetcher_list.dart`

- [ ] **Step 1: Rewrite the file**

Overwrite `jaspr_falconnect/lib/engine/fetches/stream_fetcher_list.dart`:

```dart
import 'package:jaspr_falconnect/lib.dart';

class ResultStreamFetcherList {
  final Map<dynamic, ResultStreamFetcher> _fetcherMap = {};

  Stream<ComponentState<T?>> fetchStream<T>({
    required Object key,
    required Stream<Result<T>> call,
    bool debounceFetch = true,
  }) {
    _fetcherMap.removeWhere((key, value) => value.isClose);
    if (_canFetch(key, debounceFetch)) {
      final fetcher = ResultStreamFetcher<T>();
      _fetcherMap[key] = fetcher;
      return fetcher.fetch(call);
    } else {
      return (_fetcherMap[key]! as ResultStreamFetcher<T>).stream;
    }
  }

  Stream<ComponentState<T?>> fetchFuture<T>({
    required Object key,
    required Future<Result<T>> call,
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
```

- [ ] **Step 2: Analyze whole package**

Run: `cd jaspr_falconnect && dart analyze`
Expected: no errors.

- [ ] **Step 3: Commit**

```bash
git add jaspr_falconnect/lib/engine/fetches/stream_fetcher_list.dart
git commit -m "refactor(falconnect): rename EitherStreamFetcherList to ResultStreamFetcherList"
```

---

## Task 6: Update the package-version migration plan doc

**Files:**
- Modify: `docs/superpowers/plans/2026-04-07-package-version-migration.md`

- [ ] **Step 1: Read the current snippets**

Run: `grep -n "Either" docs/superpowers/plans/2026-04-07-package-version-migration.md`
Expected: matches at lines ~326, 328, 343, 345, 362-368, 390-396.

- [ ] **Step 2: Replace `RiverpodEitherEncoder/Decoder` snippets**

Update every occurrence of `Either<Failure, T>` / `RiverpodEitherEncoder` / `RiverpodEitherDecoder` in the doc's code blocks to the new `Result<T>` / `RiverpodResultEncoder` / `RiverpodResultDecoder` shape defined in Task 2. The point is to keep the historical migration doc internally consistent — do not invent new content, just match the shipped code.

- [ ] **Step 3: Commit**

```bash
git add docs/superpowers/plans/2026-04-07-package-version-migration.md
git commit -m "docs: update version-migration plan snippets to Result codec names"
```

---

## Task 7: Workspace-wide verification

- [ ] **Step 1: Analyze all packages**

Run: `melos exec -- dart analyze`
Expected: no errors across the workspace.

- [ ] **Step 2: Run all tests in touched packages**

Run: `cd jaspr_falconx && dart test` and `cd jaspr_falconnect && dart test`
Expected: all tests PASS (including the two new test files from Tasks 1–2).

- [ ] **Step 3: Grep for stragglers**

Run: `grep -rn "Either<Failure" jaspr_falconx jaspr_falconnect jaspr_falkit jaspr_falmodel jaspr_falmonitor jaspr_falstore jaspr_faltool jaspr_falwind`
Expected: zero matches.

Run: `grep -rn "EitherStreamFetcher\|RiverpodEither\|riverpodEitherCodec" jaspr_falconx jaspr_falconnect`
Expected: zero matches.

- [ ] **Step 4: Final commit (if verification revealed nothing, skip)**

If Steps 1–3 are all clean, no additional commit is needed. If any straggler was found, fix it and commit separately with a descriptive message.
