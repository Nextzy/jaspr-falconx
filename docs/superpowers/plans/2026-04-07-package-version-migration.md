# Package Version Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Resolve all compile errors and warnings introduced by the staged version bumps to jaspr 0.22.4, jaspr_riverpod 0.4.4, jaspr_router 0.8.1, and the new dart_falmodel git ref, so that `dart analyze` exits with 0 errors / 0 warnings in every workspace package.

**Architecture:** Apply targeted fixes package-by-package in dependency order (faltool → falstore → falmonitor → falwind → falkit → falconx). The biggest changes (`jaspr_riverpod` legacy import + `Failure` class refactor) are isolated to `jaspr_falconx`.

**Tech Stack:** Dart 3.9+, Melos workspace, jaspr 0.22, jaspr_riverpod 0.4 (legacy `StateNotifier` API), Freezed (for `Failure`), very_good_analysis 10.2.

**Spec:** `docs/superpowers/specs/2026-04-07-package-version-migration-design.md`

---

## File Map

| File | Action | Why |
|---|---|---|
| `jaspr_faltool/lib/lib.dart` | Modify | Remove `Unit, option` from hide |
| `jaspr_falstore/lib/src/key_value_storage.dart` | Modify | Remove unused self-import |
| `jaspr_falmonitor/lib/lib.dart` | Modify | Hide 19 sentry internal symbols |
| `jaspr_falmonitor/pubspec.yaml` | Modify | Add `publish_to: none` |
| `jaspr_falmonitor/lib/src/analytic_option.dart` | Modify | Remove unused self-import |
| `jaspr_falwind/analysis_options.yaml` | Modify | Drop flutter_lints include + bad option |
| `jaspr_falwind/lib/builder.dart` | Modify | Remove unused `hasCustomConfig` |
| `jaspr_falkit/**` | `dart fix --apply` | 498 auto-fixable lints |
| `jaspr_falconx/lib/src/states/component_state_notifier.dart` | Modify | Add `legacy.dart` import |
| `jaspr_falconx/lib/src/states/page_controller.dart` | Modify | Add legacy import + null-safe event + dispose fix |
| `jaspr_falconx/lib/src/states/riverpod_codec.dart` | Modify | Sync with new `Failure { message, level }` |
| `jaspr_falconx/lib/lib.dart` (maybe) | Modify | Export `FeedbackLevel` if not already |

---

## Task 1: Fix jaspr_faltool — drop removed jaspr exports

**Files:**
- Modify: `jaspr_faltool/lib/lib.dart:5`

- [ ] **Step 1.1: Apply edit**

Replace line 5:
```dart
export 'package:jaspr/jaspr.dart' hide IterableFilter, Unit, option;
```
with:
```dart
export 'package:jaspr/jaspr.dart' hide IterableFilter;
```

- [ ] **Step 1.2: Verify**

Run: `cd jaspr_faltool && dart analyze`
Expected: 0 warnings (info-only findings such as `use_null_aware_elements` and `lines_longer_than_80_chars` may remain — they are out of scope).

- [ ] **Step 1.3: Commit**

```bash
git add jaspr_faltool/lib/lib.dart
git commit -m "fix(faltool): drop Unit/option hides removed in jaspr 0.22"
```

---

## Task 2: Fix jaspr_falstore — remove unused self-import

**Files:**
- Modify: `jaspr_falstore/lib/src/key_value_storage.dart:2`

- [ ] **Step 2.1: Apply edit**

Delete line 2 (`import 'package:jaspr_falstore/lib.dart';`).

- [ ] **Step 2.2: Verify**

Run: `cd jaspr_falstore && dart analyze`
Expected: no `unused_import` warning. The `sort_pub_dependencies` info finding may remain.

- [ ] **Step 2.3: Commit**

```bash
git add jaspr_falstore/lib/src/key_value_storage.dart
git commit -m "fix(falstore): remove unused self-import"
```

---

## Task 3: Fix jaspr_falmonitor — hide sentry internals + publish_to + unused import

**Files:**
- Modify: `jaspr_falmonitor/lib/lib.dart:3`
- Modify: `jaspr_falmonitor/pubspec.yaml`
- Modify: `jaspr_falmonitor/lib/src/analytic_option.dart:1`

- [ ] **Step 3.1: Hide sentry internal symbols**

Replace `jaspr_falmonitor/lib/lib.dart` line 3:
```dart
export 'package:sentry/sentry.dart';
```
with:
```dart
export 'package:sentry/sentry.dart'
    hide
        OnProcessMetric,
        OnSpanFinish,
        OnSpanStart,
        SanitizedSentryRequest,
        SdkLifecycleCallback,
        SdkLifecycleEvent,
        SdkLifecycleRegistry,
        SemanticAttributesConstants,
        SentryAttributeFormatting,
        SentryAttributeMapFormatting,
        SentryInternalLogger,
        SentrySpanData,
        SentrySpanDescriptions,
        SentrySpanOperations,
        SentryTraceOrigins,
        UrlDetails,
        formatDateAsIso8601WithMillisPrecision,
        getBreadcrumbLogLevelFromHttpStatusCode,
        getUtcDateTime,
        jsonSerializationFallback;
```

- [ ] **Step 3.2: Add `publish_to: none` to pubspec**

In `jaspr_falmonitor/pubspec.yaml`, add `publish_to: none` near the top of the file (right after `name:`).

- [ ] **Step 3.3: Remove unused self-import**

Delete line 1 of `jaspr_falmonitor/lib/src/analytic_option.dart` (`import 'package:jaspr_falmonitor/lib.dart';`).

- [ ] **Step 3.4: Verify**

Run: `cd jaspr_falmonitor && dart analyze`
Expected: 0 warnings. All 19 `invalid_export_of_internal_element`, the `invalid_dependency` on path deps, and the `unused_import` should be gone. Info-level findings (`discarded_futures`, `use_null_aware_elements`, `directives_ordering`, `eol_at_end_of_file`, `lines_longer_than_80_chars`, `sort_pub_dependencies`) may remain.

- [ ] **Step 3.5: Re-run analyze if any new symbols appear**

If sentry version surfaces a NEW internal symbol not in the list above, append it to the `hide` clause and re-run. Confirm 0 warnings before committing.

- [ ] **Step 3.6: Commit**

```bash
git add jaspr_falmonitor/lib/lib.dart jaspr_falmonitor/pubspec.yaml jaspr_falmonitor/lib/src/analytic_option.dart
git commit -m "fix(falmonitor): hide sentry internals and silence path-dep warning"
```

---

## Task 4: Fix jaspr_falwind — analysis_options + unused var

**Files:**
- Modify: `jaspr_falwind/analysis_options.yaml`
- Modify: `jaspr_falwind/lib/builder.dart:120`

- [ ] **Step 4.1: Replace analysis_options.yaml include and remove formatter option**

In `jaspr_falwind/analysis_options.yaml`:
- Replace line 1 `include: package:flutter_lints/flutter.yaml` with `include: package:very_good_analysis/analysis_options.yaml`
- Delete line 54 `  line-length: 120` (keep `page_width: 120`)

If `very_good_analysis` is not listed in `jaspr_falwind/pubspec.yaml` dev_dependencies, add it: `very_good_analysis: ^10.2.0`.

- [ ] **Step 4.2: Remove unused local variable**

Read `jaspr_falwind/lib/builder.dart` lines 115–130 to see the surrounding context. If `hasCustomConfig` is computed but never used, delete its declaration. If it is used inside a `// ignore:` block or is meant to be used, replace with the actual usage instead.

- [ ] **Step 4.3: Verify**

Run: `cd jaspr_falwind && dart pub get && dart analyze`
Expected: 0 warnings. The `include_file_not_found`, `unsupported_option`, and `unused_local_variable` warnings should be gone.

- [ ] **Step 4.4: Commit**

```bash
git add jaspr_falwind/analysis_options.yaml jaspr_falwind/lib/builder.dart jaspr_falwind/pubspec.yaml
git commit -m "fix(falwind): replace flutter_lints include and remove unused var"
```

---

## Task 5: Fix jaspr_falkit — auto-apply use_null_aware_elements

**Files:**
- Modify: `jaspr_falkit/**/*.dart` (via `dart fix --apply`)

- [ ] **Step 5.1: Run dart fix in dry-run mode first**

Run: `cd jaspr_falkit && dart fix --dry-run`
Read the output. Confirm that proposed fixes are limited to `use_null_aware_elements` and other safe lint fixes. If you see anything that looks semantic (e.g. removing API calls), STOP and report.

- [ ] **Step 5.2: Apply fixes**

Run: `cd jaspr_falkit && dart fix --apply`

- [ ] **Step 5.3: Review the diff**

Run: `git diff jaspr_falkit/ | head -200` and skim a sample of the changes (especially `lib/components/seo/schema/website.dart`). Confirm that each change replaces an `if (x != null) x` pattern with `?x` or equivalent — nothing more.

- [ ] **Step 5.4: Verify**

Run: `cd jaspr_falkit && dart analyze`
Expected: significantly fewer issues. The `use_null_aware_elements` count should drop to ~0. The `sort_pub_dependencies` info finding may remain.

- [ ] **Step 5.5: Commit**

```bash
git add jaspr_falkit/
git commit -m "style(falkit): apply dart fix for use_null_aware_elements lint"
```

---

## Task 6: Fix jaspr_falconx — add jaspr_riverpod legacy import

This is the foundational change for Tasks 6–8. Adding the legacy import resolves the bulk of `jaspr_falconx` errors before any code change.

**Files:**
- Modify: `jaspr_falconx/lib/src/states/component_state_notifier.dart:1`
- Modify: `jaspr_falconx/lib/src/states/page_controller.dart:1-2`

- [ ] **Step 6.1: Add legacy import to component_state_notifier.dart**

Replace line 1 of `jaspr_falconx/lib/src/states/component_state_notifier.dart`:
```dart
import 'package:jaspr_falconx/lib.dart';
```
with:
```dart
import 'package:jaspr_falconx/lib.dart';
import 'package:jaspr_riverpod/legacy.dart';
```

- [ ] **Step 6.2: Add legacy import to page_controller.dart**

Replace lines 1-2 of `jaspr_falconx/lib/src/states/page_controller.dart`:
```dart
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falconx/lib.dart';
```
with:
```dart
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falconx/lib.dart';
import 'package:jaspr_riverpod/legacy.dart';
```

- [ ] **Step 6.3: Verify intermediate state**

Run: `cd jaspr_falconx && dart analyze 2>&1 | grep -E "error|warning" | head -30`
Expected: The 12 `Undefined name 'state'`, the `dispose` `undefined_super_member`, and the `override_on_non_overriding_member` should be GONE. The 4 `Failure.code` / `developerMessage` errors and the 2 `unchecked_use_of_nullable_value` errors at lines 98–100 will REMAIN — they are addressed in Tasks 7 and 8.

- [ ] **Step 6.4: Do NOT commit yet** — Tasks 7 and 8 share this file.

---

## Task 7: Fix jaspr_falconx page_controller — null-safe event

**Files:**
- Modify: `jaspr_falconx/lib/src/states/page_controller.dart:91-104`

- [ ] **Step 7.1: Apply null-safe edit**

Replace lines 91–104:
```dart
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
```
with:
```dart
  void listenEvent(
    BuildContext context,
    void Function(EVENT event) listener,
  ) {
    context.listen(
      _controllerProvider!,
      (previous, value) {
        final event = value?.event;
        if (event is EVENT && event != null) {
          listener(event);
        }
      },
    );
  }
```

- [ ] **Step 7.2: Verify**

Run: `cd jaspr_falconx && dart analyze 2>&1 | grep -E "error" | grep page_controller`
Expected: 0 errors in `page_controller.dart`. (4 errors in `riverpod_codec.dart` still remain — Task 8.)

- [ ] **Step 7.3: Do NOT commit yet** — bundle with Task 8.

---

## Task 8: Fix jaspr_falconx riverpod_codec — sync with Result-based codec

The new shipped code uses `Result<T>` with `CommonException` instead of `Either<Failure, T>`. The codec classes are now `RiverpodResultEncoder` and `RiverpodResultDecoder`, handling the new exception shape with `type: ErrorType`, `userMessage: String?`, and `developerMessage: String?`.

**Files:**
- Modify: `jaspr_falconx/lib/src/states/riverpod_codec.dart:38-89`

- [ ] **Step 8.1: Verify ErrorType is reachable**

Run: `cd jaspr_falconx && grep -rn "ErrorType" lib/ | head -5`
If `ErrorType` is not exported from `jaspr_falconx/lib.dart`, add `import 'package:jaspr_falmodel/lib.dart';` to `riverpod_codec.dart` (or whichever file exports falmodel into falconx). Confirm by trying to use `ErrorType.unknown` in the editor.

- [ ] **Step 8.2: Update encoder**

Replace lines 38–51:
```dart
class RiverpodEitherEncoder<T> extends Converter<Either<Failure, T>, dynamic> {
  @override
  dynamic convert(Either<Failure, T> input) {
    return jsonEncode({
      if (input.failureOrNull != null)
        'failure': {
          'code': input.failureOrNull?.code,
          'message': input.failureOrNull?.message,
          'developerMessage': input.failureOrNull?.developerMessage,
        },
      'data': input.dataOrNull,
    });
  }
}
```
with:
```dart
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
```

- [ ] **Step 8.3: Update decoder**

Replace lines 53–77:
```dart
class RiverpodEitherDecoder<T> extends Converter<dynamic, Either<Failure, T>> {
  const RiverpodEitherDecoder(this.fromJson);

  final T Function(dynamic json) fromJson;

  @override
  Either<Failure, T> convert(dynamic input) {
    final json = jsonDecode(input as String) as Map<String, dynamic>;
    final failureJson = json['failure'] as Map<String, dynamic>?;
    final dataJson = json['data'];

    if (failureJson != null) {
      return Left(
        Failure(
          code: failureJson['code'] as String?,
          message: failureJson['message'] as String?,
          developerMessage: failureJson['developerMessage'] as String?,
        ),
      );
    } else if (dataJson != null) {
      return Right(fromJson(dataJson));
    }
    throw Exception('Invalid json');
  }
}
```
with:
```dart
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
```

- [ ] **Step 8.4: Verify all of jaspr_falconx**

Run: `cd jaspr_falconx && dart analyze`
Expected: **0 errors, 0 warnings**. (Info-level findings such as `avoid_dynamic_calls` and `sort_pub_dependencies` may remain.)

- [ ] **Step 8.5: Commit Tasks 6 + 7 + 8 together**

```bash
git add jaspr_falconx/lib/src/states/
git commit -m "fix(falconx): migrate to jaspr_riverpod 0.4 legacy + new Failure shape"
```

---

## Task 9: Final workspace verification

- [ ] **Step 9.1: Run analyze across every package**

Run from repo root:
```bash
for p in jaspr_faltool jaspr_falmodel jaspr_falconnect jaspr_falkit \
         jaspr_falstore jaspr_falmonitor jaspr_falwind jaspr_falconx; do
  echo "===== $p ====="
  (cd "$p" && dart analyze 2>&1 | grep -E "error|warning" || echo "  clean")
done
```

Expected output: every package prints `clean` or only info-level findings outside this spec's scope.

- [ ] **Step 9.2: If any error or warning remains, STOP**

Report the failing package and finding back to the user. Do not improvise.

- [ ] **Step 9.3: Confirm git status is clean**

Run: `git status`
Expected: working tree clean (all migration commits already made).
