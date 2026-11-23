# Sentry

`package: jaspr_falmonitor`. `SentryHandler.instance` wraps the `sentry` package, which this barrel does not re-export.

## `SentryAnalyticOption`

| Field | Default | Meaning |
|---|---|---|
| `dns` | required | the Sentry DSN (the field name is a typo for DSN) |
| `sendDefaultPii` | `true` | copied to Sentry's `sendDefaultPii`: request headers and the user's IP address |
| `enabled` | `true` | `false` keeps the handler off |

`initial(option)` stores the option and, when enabled, runs `Sentry.init` with `dsn` and `sendDefaultPii` only. Errors from `Sentry.init` are not caught.

## What each call sends

| Call | Sent to Sentry |
|---|---|
| `captureError(error, stackTrace:, attributes:)` | `Sentry.captureException(error, stackTrace:)`; with `attributes`, a message whose text is `attributes.toString()` |
| `captureEvent(type:, name:, screenName:, eventAttributes:)` | an info-level `SentryEvent`, described below |
| `setupUserIdentifier(userId:, attributes:)` | the scope's user, described below |
| `captureScreenView` | nothing |

`captureEvent` builds:

- message `User action: <type>` plus ` on <name>` when `name` is set, where `<type>` is `type` split on `_` with each word capitalized (`add_to_cart` becomes `Add To Cart`);
- `transaction` set to `screenName`, or `unknown_screen`;
- tags `action.type`, `action.target` (from `name`), `screen`, and `event.category: user_interaction`;
- a `user_action` context and one breadcrumb carrying `eventAttributes`; the breadcrumb category is `ui.<kind>`, where `<kind>` comes from the first of these checks that `type` contains, in order: `click` or `tap` (click), `add`, `remove` or `delete` (remove), `swipe` or `scroll` (navigation), `search`, `filter`, `share`, `submit`; otherwise `action`;
- fingerprint `['user_action', type, screenName ?? 'unknown_screen']`, so Sentry groups events by action type and screen.

`setupUserIdentifier` sets a `SentryUser` with `id: userId`. It reads `email`, `username`, `name`, and `ipAddress` from `attributes` (each must be a `String`) and puts every other key in the user's `data`. The `segment`, `userType`, and `plan` keys also become the tags `user.segment`, `user.type`, and `user.plan`.

```dart
Future<void> identifySignedInUser(String userId, String email) =>
    SentryHandler.instance.setupUserIdentifier(
      userId: userId,
      attributes: {'email': email, 'plan': 'pro'},
    );
```

## Gotchas

- `Monitoring.init` already called `setupUserIdentifier` with the device id and `deviceInfo`. A later call replaces that user, so the device data is gone unless you pass it again (`Monitoring.deviceInfo`).
- `setupUserIdentifier`, `captureError`, and `captureEvent` catch their own errors and log them with `Log.w` from `jaspr_faltool`; a failed report never throws.
- `sendDefaultPii` defaults to `true`; set it to `false` unless users consented.
