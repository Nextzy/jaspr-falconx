---
name: jaspr-falconx-falstore-storage
description: Use when calling `jaspr_falstore` APIs such as `KeyValueStorage.instance` with `save`, `load`, `loadSafe`, `delete`, and `deleteAll`, or before writing a browser localStorage wrapper of your own, including reading a saved preference in a `@client` island.
---

# jaspr_falstore storage

Answers "does jaspr_falstore already provide this?" and "how do I call it?" here. `package: jaspr_falstore`; its barrel exports `KeyValueStorage` and nothing else.

## Capability map

`KeyValueStorage` wraps the browser's `window.localStorage`. Use the `const` singleton `KeyValueStorage.instance`; the constructor is private.

| Need | Use | In the browser | On the server |
|---|---|---|---|
| Store a string | `bool save(String key, {required String? data})` | writes and returns `true`; `data: null` returns `false` and writes nothing | returns `false` |
| Read a string | `String? load(String key)` | the value, or `null` when the key is missing | returns `null` |
| Read with a fallback | `String loadSafe(String key, {required String defaultData})` | the value, or `defaultData` when the key is missing | returns `defaultData` |
| Remove one key | `void delete({required String key})` | removes it | does nothing |
| Remove every key | `void deleteAll()` | clears all of the origin's localStorage | does nothing |

```dart
const String lastTabKey = 'last_tab';

void saveLastTab(String tab) {
  KeyValueStorage.instance.save(lastTabKey, data: tab);
}

String savedLastTab() =>
    KeyValueStorage.instance.loadSafe(lastTabKey, defaultData: 'overview');

void forgetLastTab() {
  KeyValueStorage.instance.delete(key: lastTabKey);
}
```

Values are strings only. Store a structured value as JSON with `jsonEncode` and read it back with `jsonDecode`, both from `dart:convert`.

## Do not reinvent

- Before writing a localStorage helper or reading `window.localStorage` yourself, use `KeyValueStorage.instance`; it already guards every call with `kIsWeb`.

## Gotchas

- The server has no storage: during server rendering `load` returns `null` and `loadSafe` returns `defaultData`. The server-rendered HTML always shows the default, and a stored value appears only after the browser runs your code, for example in a `@client` island.
- `save(key, data: null)` keeps the old value; call `delete(key: key)` to remove it.
- `deleteAll` clears the whole origin's localStorage, including keys other code wrote. Prefer `delete` per key.
- localStorage is plain text that any script on the origin can read, so never store tokens, passwords, or other secrets in it.
- `save` does not catch errors from `localStorage.setItem`, which throws when the storage quota is full.
- Code that reaches the browser (`@client` islands and anything they import) never imports `dart:io`, `package:jaspr/server.dart`, or `jaspr_falserver`. Server code may use `dart:io`.
- Write constructors with the type name (`const Foo(...)`, `Foo._()`), never `new(...)`: consuming apps run jaspr_builder 0.23.5, which rejects primary constructors.

## Out of scope

Encrypted or server-side storage, cookies, and package internals.
