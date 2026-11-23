---
name: jaspr-faltool-utils
description: Use when calling `jaspr_faltool` APIs such as `Log`, `BuildConfig`, `AppDateTime`, the `toFormatString` and `toDateTime` date-format extensions, `truncateText`, `EmojiWrapper`, `ShareLinks`, or `ShareUtils`, when fpdart's `option` or `Unit` or numeral's number extensions are missing beside it, or before adding a logging, date-format, truncation, or social-share helper, since jaspr_faltool also re-exports dart_faltool and the libraries it brings.
---

# jaspr_faltool utils

Answers "does jaspr_faltool already provide this?" here and routes "how do I call it?" to one file under `references/`. `package: jaspr_faltool`; its barrel also re-exports `dart_faltool`, so that package's extensions, `TypeId`, `UuidGenerator`, and libraries (`rxdart`, `fpdart`, `intl`, `logger`, ...) come with it, minus the names listed under Gotchas; see the skill shipped for `dart_faltool` (installed with this package).

## Capability map

| Need | Use | Ref |
|---|---|---|
| Debug logging | `Log.t/d/i/w/e/f`, `Log.error`, `Log.title`, `Log.success`, `Log.setup` | `references/logging.md` |
| Debug or release branch | `BuildConfig.debug`, `BuildConfig.release` | `references/logging.md` |
| Format or parse a date | `DateTime.toFormatString`, `String.toDateTime`, `AppDateTime.dateTimeFromString/dateTimeToString` | `references/formatters.md` |
| Cut long text with a suffix | `truncateText(maxLength:, truncate:)` on `String` and `String?` | `references/formatters.md` |
| Wrap emoji in a styled tag | `EmojiWrapper.wrapEmojis`, `EmojiWrapper.emojiPattern` | `references/formatters.md` |
| Social share URL, server or browser | `ShareLinks.facebook/x/linkedIn/line` | `references/share.md` |
| Open a share dialog or copy a link in the browser | `ShareUtils.shareToFacebook/shareToTwitter/shareToLinkedIn/shareToLine/copyToClipboard` | `references/share.md` |
| String, date, number, collection extensions; IDs; third-party libraries | the re-exported `dart_faltool` API | the skill shipped for `dart_faltool` |

## Do not reinvent

- Before adding a pub dependency or writing a helper, scan the map above and the skill shipped for `dart_faltool`.
- When this package's barrel is imported, do not also import `dart_faltool`, `intl`, `logger`, `fpdart`, or another library it re-exports; the symbols are already in scope.
- Do not hand-build share URLs; `ShareLinks` encodes every value and runs on the server and in the browser.
- Do not write a truncation helper. `dart_faltool` already has a different `String.truncate(int?, {ellipsis})`, which is why this one is named `truncateText`.

## Gotchas

- The barrel hides fpdart's `Unit` and `option`, so jaspr's CSS `Unit` and `<option>` element win. Write `Option.of(...)` or `some(...)` for an fpdart option.
- The barrel hides numeral's `NumeralNumExtension`, so `.percent` on a number is jaspr's CSS unit. numeral's `compact()`, `decimal()`, `percent()`, `bytes()`, and `currency()` number methods are not in scope either; `toPercentage` and the other number extensions from `dart_faltool` still are.
- Code that reaches the browser (`@client` islands and anything they import) never imports `dart:io`, `package:jaspr/server.dart`, or `jaspr_falserver`. Server code may use `dart:io`.
- Write constructors with the type name (`const Foo(...)`, `Foo._()`), never `new(...)`: consuming apps run jaspr_builder 0.23.5, which rejects primary constructors.
- `ShareUtils` does nothing on the server, and `copyToClipboard` returns `false` there or when the browser refuses. `ShareLinks` is safe on both sides.
- Every `Log` method writes nothing when jaspr's `kReleaseMode` is true, so do not rely on `Log` for production server logs.
- `Log` defaults to logger's `DevelopmentFilter`, which logs only when asserts are on. Call `Log.setup(filter: ProductionFilter())` to log in every non-release run.
- `EmojiWrapper.wrapEmojis` returns HTML and escapes nothing else in the text. Render it with `RawText` only for trusted or already escaped text; user input rendered that way is an XSS hole.
- `toFormatString(locale: 'th')` and other locales beyond intl's built-in `en_US` throw `LocaleDataException` until `initializeDateFormatting` from `package:intl/date_symbol_data_local.dart` has run. That library is not re-exported; list `intl` in your own `pubspec.yaml` to import it.

## Out of scope

The extensions, helpers, and third-party libraries of `dart_faltool` (see the skill shipped for that package), general usage of the re-exported libraries, and package internals.
