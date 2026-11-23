# Umami

`package: jaspr_falmonitor`. `UmamiHandler.instance` calls the Umami tracker's `window.umami` object through `dart:js_interop`. On the server a conditional export swaps in a stub whose every method does nothing.

## `UmamiAnalyticOption`

| Field | Default | Read by the handler |
|---|---|---|
| `enabled` | `true` | yes |
| `websiteId`, `scriptUrl`, `hostUrl`, `autoTrack`, `domains` | `null` | no |

`initial(option)` only stores the option. It does not load the tracker, so add the Umami script to your document head yourself:

```html
<script defer src="https://umami.example.com/script.js"
        data-website-id="your-website-id"></script>
```

## What each call sends

| Call | Tracker call |
|---|---|
| `setupUserIdentifier(userId:, attributes:)` | `umami.identify(attributes)`; `userId` is not sent |
| `captureEvent(type:, name:, screenName:, eventAttributes:)` | `umami.track(type, {name, screen_name, ...eventAttributes})`, leaving out a `null` `name` or `screenName` |
| `captureScreenView(path, referrer:)` | `umami.track()`, which records the current page; `path` and `referrer` are not sent |
| `captureError` | nothing |

```dart
Future<void> trackSignup(String plan) => Monitoring.captureEvent(
  type: 'signup',
  name: 'signup-button',
  eventAttributes: {'plan': plan},
);
```

## Gotchas

- The tracker must be on the page before `Monitoring.init` runs with an Umami option, because `init` calls `setupUserIdentifier`, which reads `window.umami` with no error guard. `captureEvent` and `captureScreenView` catch their errors and log them with `Log.w` from `jaspr_faltool`.
- To send a user id, put it in `attributes` under `id`; Umami uses an `id` property in the `identify` data as the Distinct ID.
- The tracker records page views by default. Calling `captureScreenView` on every route change as well counts each page twice; turn the tracker's own page views off with `data-auto-pageview="false"` (Umami 3.2 and later) if you send them yourself.
- `eventAttributes` keys share one object with `name` and `screen_name`, so an attribute with either key overwrites it.
