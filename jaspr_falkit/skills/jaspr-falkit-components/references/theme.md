# Theme

`package: jaspr_falkit`: `ThemeBootScript`, `themeStorageKey`, `nextThemeMode`, and `setThemePreference`. `ThemeMode` (`system`, `light`, `dark`) comes from `jaspr_falmodel`; see the skill shipped for `jaspr_falmodel`.

The server cannot know a visitor's theme, so the page stays cacheable and the browser applies it: `ThemeBootScript` paints the theme before first paint, and a `@client` island changes it with `setThemePreference`.

## `ThemeBootScript`

A server-rendered `<script id="theme-boot">`. It does not wrap itself in `Document.head`; put it inside one so it runs before the body paints:

```dart
Component themeHead() => Document.head(children: const [ThemeBootScript()]);
```

| Parameter | Default | Meaning |
|---|---|---|
| `lightClass` | `'light'` | classes set on `<html>` for light; space-separated tokens are allowed |
| `darkClass` | `'dark'` | classes set on `<html>` for dark |
| `storageKey` | `themeStorageKey` (`'jaspr_theme_preference'`) | localStorage key read and written |
| `preferenceAttribute` | `null` | see the `data-theme` row below |

What the script does:

| Step | Behavior |
|---|---|
| Read | the stored preference, or `system` when it is missing or localStorage throws |
| Paint | resolves `system` through `prefers-color-scheme: dark`, removes every light and dark token from `<html>`'s class list, adds the active set, and keeps every other class |
| `data-theme` | with `preferenceAttribute: null`, holds the preference (`light`, `dark`, or `system`); when set, `data-theme` holds the resolved `light` or `dark` (the name daisyUI reads) and the named attribute holds the preference |
| Follow the OS | while the preference is `system`, repaints when `prefers-color-scheme` changes |
| `window.falSetTheme(pref)` | stores `pref`, then paints it |

Class and key strings are escaped for the inline script, so quotes and `</script` in them are safe.

## `setThemePreference` and `nextThemeMode`

| API | Behavior |
|---|---|
| `void setThemePreference(ThemeMode mode)` | in the browser, calls `window.falSetTheme(mode.name)`; throws `StateError` when `ThemeBootScript` is not in the page; on the server, does nothing |
| `ThemeMode nextThemeMode(ThemeMode current)` | the toggle cycle light, dark, system, light |
| `const String themeStorageKey` | `'jaspr_theme_preference'` |

Call `setThemePreference` from a `@client` island, in an event handler:

```dart
@client
class ThemeToggle extends StatefulComponent {
  const ThemeToggle({super.key});

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  ThemeMode _mode = ThemeMode.system;

  void _toggle() {
    final next = nextThemeMode(_mode);
    setThemePreference(next);
    setState(() => _mode = next);
  }

  @override
  Component build(BuildContext context) => Component.element(
    tag: 'button',
    attributes: const {'type': 'button'},
    events: {'click': (_) => _toggle()},
    children: [Component.text('Theme: ${_mode.name}')],
  );
}
```

To start the island from the saved preference, read it in `initState` behind `kIsWeb` with `KeyValueStorage` from `jaspr_falstore` (not re-exported by this barrel): `ThemeMode.values.asNameMap()[KeyValueStorage.instance.load(themeStorageKey)] ?? ThemeMode.system`. The stored value is the bare name (`dark`), not the `toJson` map, so `ThemeMode.fromJson` does not parse it.

## Gotchas

- `setThemePreference` is for `@client` code only. Server code that calls it compiles and silently does nothing.
- Without `ThemeBootScript` in the head, `setThemePreference` throws `StateError('setThemePreference needs ThemeBootScript in the document head')` in the browser.
- This package sets no theme class on the server; only the boot script adds it in the browser. Keep the boot script in `<head>`, not the body, so the class is in place before the first paint.
- With a custom `storageKey`, read the preference with that same key; `themeStorageKey` is only the default.
- A `script-src` Content-Security-Policy must allow the inline boot script, for example by its hash. The hash changes when the parameters change.
- Listing `jaspr_falstore` beside `jaspr_falkit` (which depends on it) as git dependencies fails `dart pub get` at a tag `ref:`, because the sibling `path: ../` dependencies resolve to the commit hash. Use the tag's full 40-character commit hash as `ref:` for every listed `jaspr_fal*` package; the "When you list more than one package" section of the `jaspr-falconx` README explains how to read it. An app that lists `jaspr_falconx` already has `jaspr_falstore`.
- Code that reaches the browser (`@client` islands and anything they import) never imports `dart:io`, `package:jaspr/server.dart`, or `jaspr_falserver`. Server code may use `dart:io`.
- Write constructors with the type name (`const Foo(...)`, `Foo._()`), never `new(...)`: consuming apps run jaspr_builder 0.23.5, which rejects primary constructors.
