# Package Version Migration — jaspr 0.22 / jaspr_riverpod 0.4 / dart_falmodel

**Date:** 2026-04-07
**Branch:** develop
**Status:** Design approved, ready for implementation

## Context

Staged version bumps in `pubspec.yaml` files across all 8 packages introduced breaking changes that prevent the workspace from analyzing cleanly:

| Package | From | To |
|---|---|---|
| jaspr | 0.21.2 | 0.22.4 |
| jaspr_router | 0.7.3 | 0.8.1 |
| jaspr_riverpod | 0.3.23 | 0.4.4 |
| universal_web | 1.1.1 | 1.1.1+1 |
| build_runner | 2.8.0 | 2.13.1 |
| test | 1.26.3 | 1.31.0 |
| very_good_analysis | 10.0.0 | 10.2.0 |
| dart_falmodel (git ref) | fd77887 | 607c281 |

`melos bootstrap` succeeds, but `dart analyze` reports **19 compile errors** in `jaspr_falconx` and assorted warnings/lints across other packages.

## Root Causes (verified against pub-cache sources)

1. **jaspr_riverpod 0.4** moved `StateNotifier`, `StateNotifierProvider`, `StateController`, `StateProvider`, `ChangeNotifierProvider` from the main entrypoint into `package:jaspr_riverpod/legacy.dart`. They still exist; consumers must add a separate import.
2. **dart_falmodel** refactored `Failure` (freezed). It now has only `message: String?` and `level: FeedbackLevel`. The previous `code` and `developerMessage` fields are gone.
3. **jaspr 0.22** removed `Unit` and `option` from its public exports.
4. **sentry_dart** marked many internal symbols (`OnSpanFinish`, `SentryInternalLogger`, `SdkLifecycleRegistry`, etc., 19 total) as internal — they cannot be re-exported by `jaspr_falmonitor/lib/lib.dart`.
5. **very_good_analysis 10.2** introduced the `use_null_aware_elements` lint, generating 498 info-level findings (mostly in `jaspr_falkit/lib/components/seo/schema/website.dart`). All are auto-fixable.
6. **jaspr_falwind/analysis_options.yaml** includes `package:flutter_lints/flutter.yaml`, but `flutter_lints` is not in the package's dependencies and this is not a Flutter project. Also uses an unsupported `formatter.line-length` option.

## Goals

- `dart analyze` exits with 0 errors and 0 warnings in every package.
- Info-level lints listed in this spec are eliminated; other info-level findings outside the listed scope may remain.
- No behavioral changes beyond what is required by the new APIs.
- No unrelated refactors.

## Non-Goals

- Upgrading to a newer Riverpod 3.x Notifier-based API. We retain the legacy `StateNotifier` style for now to keep the diff minimal.
- Cleaning up SEO schema implementations beyond auto-fixable lints.
- Touching `dart_falmodel` itself — we adapt to its new shape.

## Fix Plan

Apply in dependency order (bottom of the layered architecture upward) so that each package analyzes cleanly before the next one is touched.

### Fix A — `jaspr_faltool/lib/lib.dart`

Remove `Unit` and `option` from the `hide` clause on `package:jaspr/jaspr.dart`. They no longer exist in jaspr 0.22.

### Fix B — `jaspr_falconx` riverpod legacy import

Add `import 'package:jaspr_riverpod/legacy.dart';` to:
- `jaspr_falconx/lib/src/states/component_state_notifier.dart` (so `StateNotifier` resolves)
- `jaspr_falconx/lib/src/states/page_controller.dart` (so `StateNotifierProvider` resolves and the inherited `state` setter is available)

This single change resolves 13 of the 15 errors in `page_controller.dart` (the `Undefined name 'state'` and `dispose` issues both come from the missing `StateNotifier` base class).

### Fix C — `jaspr_falconx/lib/src/states/page_controller.dart` nullable receiver

Lines 98–100 access `value.event` where `value` is the second positional argument of `context.listen`. After the legacy import is added, verify whether this argument is nullable in jaspr_riverpod 0.4. If yes:

```dart
context.listen(
  _controllerProvider!,
  (previous, value) {
    final event = value?.event;
    if (event is EVENT && event != null) {
      listener(event);
    }
  },
);
```

Also confirm `dispose` is still a valid override on the legacy `StateNotifier`. If the override warning persists after Fix B, drop the `@override` annotation and call cleanup via `addListener` / provider `ref.onDispose` instead.

### Fix D — `jaspr_falconx/lib/src/states/riverpod_codec.dart`

Sync the JSON shape with the new `Failure { message, level }`:

**Encoder (lines 42–47):**
```dart
'failure': {
  'message': input.failureOrNull?.message,
  'level': input.failureOrNull?.level.name,
},
```

**Decoder (lines 65–70):**
```dart
return Left(
  Failure(
    message: failureJson['message'] as String?,
    level: FeedbackLevel.values.byName(
      failureJson['level'] as String? ?? 'medium',
    ),
  ),
);
```

Verify that `FeedbackLevel` is exported from `jaspr_falconx/lib.dart`; add the export if missing.

### Fix E — `jaspr_falmonitor`

1. `lib/lib.dart`: append a `hide` clause to the sentry export listing all 19 internal symbols flagged by analyze (`OnProcessMetric`, `OnSpanFinish`, `OnSpanStart`, `SanitizedSentryRequest`, `SdkLifecycleCallback`, `SdkLifecycleEvent`, `SdkLifecycleRegistry`, `SemanticAttributesConstants`, `SentryAttributeFormatting`, `SentryAttributeMapFormatting`, `SentryInternalLogger`, `SentrySpanData`, `SentrySpanDescriptions`, `SentrySpanOperations`, `SentryTraceOrigins`, `UrlDetails`, `formatDateAsIso8601WithMillisPrecision`, `getBreadcrumbLogLevelFromHttpStatusCode`, `getUtcDateTime`, `jsonSerializationFallback`).
2. `pubspec.yaml`: add `publish_to: none` to silence the `invalid_dependency` warning about path deps.
3. `lib/src/analytic_option.dart`: remove the unused self-import.

### Fix F — `jaspr_falwind/analysis_options.yaml`

- Remove the `include: package:flutter_lints/flutter.yaml` line. Replace with `include: package:very_good_analysis/analysis_options.yaml` for consistency with the rest of the workspace, or delete the include entirely if `very_good_analysis` isn't a dev_dependency of falwind.
- Remove the unsupported `formatter.line-length` option.
- Address the unused `hasCustomConfig` local variable in `lib/builder.dart:120`.

### Fix G — `jaspr_falkit` lint sweep

Run `dart fix --apply` inside `jaspr_falkit/`. This auto-fixes the 498 `use_null_aware_elements` findings (mostly in `lib/components/seo/schema/website.dart`). Review the diff to confirm no semantic changes.

### Fix H — `jaspr_falstore/lib/src/key_value_storage.dart`

Remove the unused `import 'package:jaspr_falstore/lib.dart';` self-import.

## Verification

After every fix, run inside the affected package:

```bash
dart analyze
```

After all fixes are applied, run from repo root:

```bash
for p in jaspr_faltool jaspr_falmodel jaspr_falconnect jaspr_falkit \
         jaspr_falstore jaspr_falmonitor jaspr_falwind jaspr_falconx; do
  echo "===== $p ====="
  (cd "$p" && dart analyze)
done
```

**Acceptance criteria:** every package reports 0 errors and 0 warnings. Info-level findings outside this spec's scope may remain.

## Rollout Order

```
Fix A (faltool)  →  Fix H (falstore)  →  Fix E (falmonitor)
              ↓
            Fix F (falwind)
              ↓
            Fix G (falkit)
              ↓
       Fix B + C + D (falconx)  ← biggest, do last
              ↓
       Final verification sweep
```

## Risks & Mitigations

| Risk | Mitigation |
|---|---|
| The legacy `dispose` override doesn't exist in jaspr_riverpod 0.4's legacy `StateNotifier` | Check after Fix B; if needed, switch to `ref.onDispose` registered in the provider builder |
| `riverpod_codec` JSON format change breaks any persisted SSR payloads | The codec is used for server→client hand-off only (not on-disk persistence), so a stale payload would only affect an in-flight render. Acceptable. |
| `dart fix --apply` rewrites code unexpectedly in falkit | Review the diff before committing; revert any non-`use_null_aware_elements` changes |
| `FeedbackLevel.values.byName` throws on unknown level strings during decode | The fallback `?? 'medium'` covers null; an unknown non-null string is a programmer error and should fail loudly |
