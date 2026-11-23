---
name: jaspr-falconx-falmonitor-monitoring
description: Use when calling `jaspr_falmonitor` APIs such as `Monitoring.init`, `Monitoring.captureError`, `captureEvent`, or `captureScreenView`, `SentryAnalyticOption` and `SentryHandler`, `UmamiAnalyticOption` and `UmamiHandler`, or `MonitorHandler` and `AnalyticOption`, or before wiring Sentry error tracking or Umami analytics into a Jaspr app by hand.
---

# jaspr_falmonitor monitoring

Answers "does jaspr_falmonitor already provide this?" here and routes "how do I call it?" to one file under `references/`. `package: jaspr_falmonitor`; its barrel exports `Monitoring`, `MonitorHandler`, `AnalyticOption`, and the Sentry and Umami options and handlers. It does not re-export the `sentry` package.

## Capability map

`Monitoring` is a static facade over the two built-in handlers, `SentryHandler.instance` and `UmamiHandler.instance`.

| Need | Use | Sentry | Umami | Ref |
|---|---|---|---|---|
| Start monitoring in the browser | `Monitoring.init(sentry:, umami:)` | `Sentry.init` with the DSN | adds the tracker script when `scriptUrl` and `websiteId` are set | below |
| Report an error | `Monitoring.captureError(error, stackTrace:, attributes:)` | `Sentry.captureException` | does nothing | `references/sentry.md` |
| Track a user action | `Monitoring.captureEvent(type:, name:, screenName:, eventAttributes:)` | an info-level event with a breadcrumb | `umami.track(type, data)` | `references/sentry.md`, `references/umami.md` |
| Record a page view | `Monitoring.captureScreenView(path, referrer:)` | does nothing | `umami.track()` | `references/umami.md` |
| Device id and browser data | `Monitoring.userDeviceId`, `Monitoring.deviceInfo`, `Monitoring.getDeviceId()` | | | below |
| Attach a signed-in user | `SentryHandler.instance.setupUserIdentifier(userId:, attributes:)` | | | `references/sentry.md` |
| Another analytics provider | subclass `MonitorHandler<O>` with an `AnalyticOption` subclass | | | below |

A handler acts only when `enabled`: it has an option, and that option's `enabled` is `true` (the default). With no option, every `capture*` call is a no-op.

## Start in the browser

```dart
const String sentryDsn = 'https://publicKey@o0.ingest.sentry.io/0';

Future<void> startMonitoring() async {
  if (!kIsWeb) return;
  await Monitoring.init(
    sentry: const SentryAnalyticOption(dns: sentryDsn, sendDefaultPii: false),
    umami: const UmamiAnalyticOption(
      websiteId: 'your-website-id',
      scriptUrl: 'https://cloud.umami.is/script.js',
    ),
  );
}

Future<void> reportFailure(Object error, StackTrace stackTrace) =>
    Monitoring.captureError(error, stackTrace: stackTrace);
```

Call `startMonitoring` once, from the client entrypoint or from a `@client` island's `initState`. `init` then:

1. reads the device id from `localStorage` key `monitoring_device_id`, or generates and stores a random 32-character hex id from `Random.secure()` (a stored value in any other format is replaced);
2. collects `deviceInfo` from `navigator` and `screen`: exactly `platform`, `browser_name`, `language`, `screen_width`, and `screen_height`, or a single `error` key when the browser read fails;
3. runs each given handler's `initial`;
4. sends the device id and those five attributes (or the single `error` key) to both handlers' `setupUserIdentifier`.

`Monitoring.userDeviceId` and `Monitoring.deviceInfo` throw until `init` has run. `getDeviceId()` reads or creates the id without the rest of `init`. The type parameter on `init` is unused.

## Your own provider

`Monitoring` calls only the two built-in handlers, so a handler of your own is called directly.

```dart
class LogAnalyticOption extends AnalyticOption {
  const LogAnalyticOption({super.enabled});
}

class LogMonitorHandler extends MonitorHandler<LogAnalyticOption> {
  @override
  Future<void> initial(LogAnalyticOption option) async => this.option = option;

  @override
  Future<void> setupUserIdentifier({
    required String userId,
    Map<String, Object>? attributes,
  }) async {}

  @override
  Future<void> captureEvent({
    required String type,
    String? name,
    String? screenName,
    Map<String, Object>? eventAttributes,
  }) async {
    if (enabled) print('event $type $name');
  }

  @override
  Future<void> captureScreenView(String path, {String? referrer}) async {}

  @override
  Future<void> captureError(
    Object error, {
    StackTrace? stackTrace,
    Map<String, Object>? attributes,
  }) async {
    if (enabled) print('error $error');
  }
}
```

The abstract methods return `FutureOr<void>`; a `Future<void>` override is valid. `initial` must set `option`, or `enabled` stays `false`.

## Do not reinvent

- Before calling `Sentry.init` or `window.umami` yourself, scan the map above.
- Do not write your own device-id or browser-info collector; use `Monitoring.getDeviceId()` and `Monitoring.deviceInfo`.

## Gotchas

- `Monitoring.init` is browser-only. It reads `window.localStorage` and `navigator` through `universal_web`, whose server stubs throw, and an island's `initState` also runs during server pre-rendering, so guard it with `kIsWeb`. The `capture*` calls are safe on the server: `UmamiHandler` is a stub there, and an uninitialized `SentryHandler` does nothing.
- `init` sends a random device id and five attributes (`platform`, `browser_name`, `language`, `screen_width`, `screen_height`) to both handlers: Sentry gets them as the user id and user data, and Umami gets the map as `umami.identify` session data. The stored device id is a persistent identifier, so consent guidance applies to Sentry as well as Umami. `sendDefaultPii` defaults to `false`, but the Sentry 10.6.0 web SDK attaches regardless of it the full User-Agent header, the page URL with query string and fragment, the timezone name, `deviceMemory`, available screen size, `devicePixelRatio`, orientation, and online state. On web, `sendDefaultPii: true` only adds the auto-inferred IP address (`{{auto}}`). An app that needs less must add its own Sentry scrubbing (for example `beforeSend`); this package does none. Leave the Umami option out (or `enabled: false`) when session data needs consent.
- The Sentry option field is named `dns`, but it takes the Sentry DSN.
- `UmamiHandler.initial` adds the tracker when `scriptUrl` and `websiteId` are set, so remove a hand-added Umami `<script>`; calls do nothing while `window.umami` is missing. See `references/umami.md`.
- Errors go to Sentry only, and page views to Umami only.
- `Monitoring` has no public method for a signed-in user; call the handlers' `setupUserIdentifier` directly.
- Code that reaches the browser (`@client` islands and anything they import) never imports `dart:io`, `package:jaspr/server.dart`, or `jaspr_falserver`. Server code may use `dart:io`.
- Write constructors with the type name (`const Foo(...)`, `Foo._()`), never `new(...)`: consuming apps run jaspr_builder 0.23.5, which rejects primary constructors.

## Out of scope

The `sentry` package's own API, Umami dashboards and server setup, and package internals.
