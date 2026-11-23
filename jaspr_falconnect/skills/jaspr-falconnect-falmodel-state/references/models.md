# Models

`package: jaspr_falmodel`: `ComponentSize`, `ThemeMode`, and `Locale`.

## `ComponentSize`

Enum ordered from smallest to largest: `micro`, `tiny`, `small`, `medium`, `large`, `huge`, `giant`. It carries no values; map each size to your own CSS.

```dart
String buttonPaddingClass(ComponentSize size) => switch (size) {
  ComponentSize.micro || ComponentSize.tiny => 'px-1',
  ComponentSize.small || ComponentSize.medium => 'px-3',
  ComponentSize.large || ComponentSize.huge || ComponentSize.giant => 'px-5',
};
```

## `ThemeMode`

Enum `system`, `light`, `dark`, with `isSystem`, `isLight`, and `isDark`.

| Member | Signature | Notes |
|---|---|---|
| `fromJson` | `static ThemeMode fromJson(Map<String, dynamic> data)` | Reads `data['mode']`: `'system'`, `'light'`, or `'dark'`; anything else gives `system` |
| `toJson` | `Map<String, dynamic> toJson()` | `{'mode': 'light'}` and so on |

```dart
ThemeMode themeFromSaved(Map<String, dynamic>? saved) =>
    saved == null ? ThemeMode.system : ThemeMode.fromJson(saved);

Map<String, dynamic> themeToSave(ThemeMode mode) => mode.toJson();
```

`fromJson` takes the map, not the bare string: `ThemeMode.fromJson({'mode': 'dark'})`. For a bare string, use `ThemeMode.values.byName(name)`, which throws on an unknown name.

## `Locale`

`const Locale({required String languageCode, String? scriptCode, String? countryCode})`.

| Getter | Example for `languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'` |
|---|---|
| `languageTag` | `zh-Hant-TW` (BCP 47, for `<html lang>` and `hreflang`) |
| `underscoreTag` | `zh_Hant_TW` (the underscore form intl uses for locale names) |

Missing parts are skipped: `Locale(languageCode: 'th')` gives `th` for both.

```dart
const Locale thai = Locale(languageCode: 'th', countryCode: 'TH');

String htmlLang(Locale locale) => locale.languageTag;

bool sameLocale(Locale a, Locale b) => a.languageTag == b.languageTag;
```

## Gotchas

- `Locale` has no `==` or `hashCode` override, so two `Locale`s built at runtime from the same codes compare unequal and do not dedupe in a `Set`. Compare `languageTag`.
- `Locale` does not parse a tag string; split it yourself when reading `th-TH` from a URL or header.
