# Formatters

`package: jaspr_faltool`. Date formatting uses intl's `DateFormat`, re-exported through `dart_faltool`.

## Dates

| Member | Signature | Notes |
|---|---|---|
| `DateTime.toFormatString` | `String toFormatString({String format = 'd MMM yyyy', String? locale})` | `DateFormat(format, locale).format(this)` |
| `DateTime?.toFormatString` | `String? toFormatString({String format = 'd MMM yyyy', String? locale})` | `null` in, `null` out |
| `String.toDateTime` | `DateTime toDateTime([String format = 'd MMM yyyy'])` | `DateFormat(format).parse(this)`; throws `FormatException` when the text does not match |
| `String?.toDateTime` | `DateTime? toDateTime([String format = 'd MMM yyyy'])` | `null` in, `null` out |
| `AppDateTime.dateTimeFromString` | `static DateTime? dateTimeFromString(String? dateString)` | `DateTime.parse`; throws `FormatException` on text that is not ISO 8601 |
| `AppDateTime.dateTimeToString` | `static String? dateTimeToString(DateTime? dateTime)` | `toIso8601String()` |

```dart
String publishedLabel(DateTime publishedAt) =>
    publishedAt.toFormatString(format: 'd MMMM yyyy');

DateTime parseEventDay(String text) => text.toDateTime('yyyy-MM-dd');

String? toJsonDate(DateTime? value) => AppDateTime.dateTimeToString(value);
```

The default locale is intl's `Intl.defaultLocale`, `en_US` unless set. Other locales, such as `th`, throw `LocaleDataException` until `initializeDateFormatting(locale)` from `package:intl/date_symbol_data_local.dart` has completed. That library is not re-exported: list `intl` in your own `pubspec.yaml`, import it, and await it once at startup on each side that formats dates (server `main` and client `main`).

## `truncateText`

| Member | Signature | Notes |
|---|---|---|
| `String.truncateText` | `String truncateText({int maxLength = 157, String? truncate})` | Keeps the first `maxLength` UTF-16 code units, then appends `truncate` (default `'...'`) |
| `String?.truncateText` | same | `null` gives `''` |

```dart
String cardExcerpt(String? body) => body.truncateText(maxLength: 120);

String shortTitle(String title) => title.truncateText(maxLength: 40, truncate: '…');
```

- The suffix comes on top of `maxLength`, so the result can be `maxLength + truncate.length` long.
- The cut counts code units, so it can split an emoji or another surrogate pair.
- `dart_faltool`'s `String.truncate(int?, {ellipsis})` is a different member with different defaults.

## `EmojiWrapper`

| Member | Signature | Notes |
|---|---|---|
| `wrapEmojis` | `static String wrapEmojis(String? text, {String className = 'text-black', String tag = 'span'})` | Wraps each emoji match in `<tag class="className">...</tag>`; `null` or empty gives `''`; text with only ASCII returns unchanged |
| `emojiPattern` | `static final RegExp emojiPattern` | Unicode emoji ranges plus variation selectors, skin tones, ZWJ sequences, flags, and keycaps |

```dart
String headlineHtml(String trustedHeadline) =>
    EmojiWrapper.wrapEmojis(trustedHeadline, className: 'emoji');
```

The result is HTML, so render it with `RawText(html)` from `package:jaspr/dom.dart`. `wrapEmojis` does not escape the rest of the text: pass only trusted or already escaped text, since user input rendered through `RawText` is an XSS hole. The default class `text-black` is a Tailwind class; pass your own `className` when the app does not use Tailwind.
