# Umami

`package: jaspr_falmonitor`. `UmamiHandler.instance` calls the Umami tracker's `window.umami` object through `dart:js_interop`. On the server a conditional export swaps in a stub whose every method does nothing.

## `UmamiAnalyticOption`

| Field | Default | Tracker attribute |
|---|---|---|
| `enabled` | `true` | none; `false` turns the handler off |
| `scriptUrl` | `null` | `src` |
| `websiteId` | `null` | `data-website-id` |
| `hostUrl` | `null` | `data-host-url`, only when set |
| `autoTrack` | `null` | `data-auto-track` (`"true"` or `"false"`), only when set |
| `domains` | `null` | `data-domains`, comma-joined, only when set |

When `enabled` and both `scriptUrl` and `websiteId` are set, `initial(option)` appends one `<script defer>` with those attributes to `document.head` and completes when it fires `load` or `error`, or after 10 seconds, with one warning, if the script never answers. Remove a hand-added Umami `<script>`, or the page loads the tracker twice. `initial` loads the tracker once per page: a later call with a different `websiteId` or `scriptUrl` does not replace the script. With either field unset, `initial` only stores the option and you load the tracker yourself. `UmamiHandler.resetTrackerLoad()` is a test-only hook that clears the once-per-page memo.

```dart
const UmamiAnalyticOption(
  websiteId: 'your-website-id',
  scriptUrl: 'https://umami.example.com/script.js',
);
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

- Every handler call does nothing, after one `Log.w` from `jaspr_faltool`, while `window.umami` is undefined: the script failed to load, an ad blocker stopped it, or `initial` has not run.
- To send a user id, put it in `attributes` under `id`; Umami uses an `id` property in the `identify` data as the Distinct ID.
- The tracker records page views by default. Calling `captureScreenView` on every route change as well counts each page twice; set `autoTrack: false` (`data-auto-track="false"`) if you send them yourself. It disables all automatic tracking, page views, click events, and path changes alike, so send those you still want.
- `eventAttributes` keys share one object with `name` and `screen_name`, so an attribute with either key overwrites it.
