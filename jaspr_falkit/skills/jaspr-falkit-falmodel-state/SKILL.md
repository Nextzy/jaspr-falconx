---
name: jaspr-falkit-falmodel-state
description: Use when calling `jaspr_falmodel` APIs such as `ComponentState<T>` with its factories, `to*` transitions, `copy`, `mapState`, `mapData`, and one-shot `addEvent` events, the `FullComponentState` enum, `ComponentSize`, `ThemeMode`, or `Locale`, or before writing a loading, success, or fail state holder, a theme-mode enum, or a locale class of your own, since jaspr_falmodel also re-exports dart_falmodel.
---

# jaspr_falmodel state

Answers "does jaspr_falmodel already provide this?" here and routes "how do I call it?" to one file under `references/`. `package: jaspr_falmodel`; its barrel also re-exports `dart_falmodel`, so `UserFeedback` (`Success`, `Warning`, `Failure`, `Information`), `Result`, and the exceptions come with it; see the skill shipped for `dart_falmodel` (installed with this package).

## Capability map

| Need | Use | Ref |
|---|---|---|
| Component state holder | `ComponentState<T>`: `.initial/.normal/.loading/.success/.warning/.fail/...` factories, `toLoading/toSuccess/toFail/...`, `toState`, `copy` | `references/component-state.md` |
| Transform a state | `mapData`, `mapState`, `apply` | `references/component-state.md` |
| One-shot event to the component | `addEvent`, `event` | `references/component-state.md` |
| State enum with `is*` and `isNot*` getters | `FullComponentState` | `references/component-state.md` |
| User feedback inside a state | `feedback`, a `UserFeedback` from `dart_falmodel` | `references/component-state.md` |
| Size scale | `ComponentSize` (`micro` to `giant`) | `references/models.md` |
| Light, dark, or system theme | `ThemeMode` with `fromJson` and `toJson` | `references/models.md` |
| Locale tags | `Locale`, `languageTag`, `underscoreTag` | `references/models.md` |
| `Result`, `runCatching`, exceptions, request and response models | the re-exported `dart_falmodel` API | the skill shipped for `dart_falmodel` |

## Do not reinvent

- Before writing a loading, success, or fail state class, a theme-mode enum, or a locale value class, scan the map above.
- When this package's barrel is imported, do not also import `dart_falmodel`; its symbols are already in scope.
- This package holds only the state and model types; the code that fetches data and emits states lives in the app or in other packages.

## Gotchas

- `event` is one-shot: only the state that `addEvent` returns carries it. `copy`, `toState`, and every `to*` transition drop it; `mapData` and `mapState` keep it.
- Every `to*` transition and `toState` replace `feedback` with a default when you pass none: `Information()`, or `Warning()` for `toWarning` and `Failure()` for `toFail`. `copy`, `mapData`, and `mapState` keep the current `feedback`.
- `copy` and the `to*` transitions cannot set `data` to `null` (`data ?? this.data`); build a new state with a factory, such as `ComponentState<User?>.normal(null)`.
- The `build` parameter on `copy`, `to*`, `mapData`, and `mapState` is accepted and ignored; `ComponentState` has no `build` field.
- `isEmpty` tests the `empty` state, not the data; use `hasData` or `noData` for a `null` check.
- `ComponentState` and `Locale` do not override `==` or `hashCode`, so two equal-looking values compare unequal. Compare `state` and `data`, or `languageTag`.
- Code that reaches the browser (`@client` islands and anything they import) never imports `dart:io`, `package:jaspr/server.dart`, or `jaspr_falserver`. Server code may use `dart:io`.
- Write constructors with the type name (`const Foo(...)`, `Foo._()`), never `new(...)`: consuming apps run jaspr_builder 0.23.5, which rejects primary constructors.

## Out of scope

`UserFeedback`, `Result`, exceptions, and the request and response models (see the skill shipped for `dart_falmodel`), and package internals.
