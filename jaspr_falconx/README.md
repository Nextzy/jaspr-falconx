# jaspr_falconx

Shared helpers for Jaspr sites built on falconx.

## Page error status

`pageErrorStatus(error)` maps a failed page load to an HTTP status: 404 when the CMS answered 403 or 404, otherwise 503 so crawlers retry. `isExpectedPageFailure(error)` is true for the 404 case.

```dart
final status = pageErrorStatus(error); // 404 or 503
```

## Locale path

`switchLocalePath(path, toCode, supported)` swaps the leading locale segment, or prefixes it when the path has none. It keeps the query and the fragment.

```dart
switchLocalePath('/th/blogs/abc?page=2', 'en', ['th', 'en']); // /en/blogs/abc?page=2
```
