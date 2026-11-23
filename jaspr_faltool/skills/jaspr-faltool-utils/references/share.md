# Share

`package: jaspr_faltool`. `ShareLinks` builds share URLs anywhere; `ShareUtils` opens them in the browser.

## `ShareLinks`

Pure static builders that percent-encode every value. Pass an absolute `url`. Safe in server rendering, so a server-rendered `<a href>` can use them with no island.

| Member | Signature | Result |
|---|---|---|
| `facebook` | `static String facebook(String url)` | `https://www.facebook.com/sharer/sharer.php?u=<url>` |
| `x` | `static String x(String url, {String? text})` | `https://twitter.com/intent/tweet?url=<url>&text=<text>` (`text` omitted when `null`) |
| `linkedIn` | `static String linkedIn(String url, {String? summary})` | `https://www.linkedin.com/sharing/share-offsite/?url=<url>&summary=<summary>` (`summary` omitted when `null`) |
| `line` | `static String line(String url, {String? text})` | `https://social-plugins.line.me/lineit/share?text=<text url>` (`text`, a space, then `url`) |

```dart
String tweetLink(String articleUrl, String title) =>
    ShareLinks.x(articleUrl, text: title);

String lineLink(String articleUrl) => ShareLinks.line(articleUrl, text: 'Read this');
```

## `ShareUtils`

Browser only: each method reads `window` from `package:universal_web` with no `kIsWeb` check, so a call during server rendering throws. Call it from a browser event, such as an `onClick` handler in a `@client` island.

A relative `url` (for example `/posts/1`) becomes absolute with `window.location.origin`; a URL starting with `http://` or `https://` is kept.

| Member | Signature | Behavior |
|---|---|---|
| `shareToFacebook` | `static Future<void> shareToFacebook(String url)` | Opens `ShareLinks.facebook` in a new tab; Facebook takes text from the page's Open Graph tags |
| `shareToTwitter` | `static Future<void> shareToTwitter(String url, {String? message})` | Opens `ShareLinks.x` with `message` as `text` |
| `shareToLinkedIn` | `static Future<void> shareToLinkedIn(String url, {String? message})` | Opens `ShareLinks.linkedIn` with `message` as `summary` |
| `shareToLine` | `static Future<void> shareToLine(String url, {String? message})` | Opens `ShareLinks.line` with `message` before the URL |
| `copyToClipboard` | `static Future<bool> copyToClipboard(String text, {bool isUrl = false})` | Writes `text` (made absolute first when `isUrl`) to the clipboard |

```dart
Future<void> onShareClicked(String postPath) async {
  if (!kIsWeb) return;
  await ShareUtils.shareToTwitter(postPath, message: 'New post');
}

Future<void> onCopyLinkClicked(String postPath) async {
  if (!kIsWeb) return;
  await ShareUtils.copyToClipboard(postPath, isUrl: true);
}
```

## Gotchas

- `copyToClipboard` starts the clipboard write without awaiting it and always returns `true`, so `true` does not prove the copy worked (the browser can refuse it outside a user gesture or a secure context).
- `window.open` from code that is not handling a user click is usually blocked as a pop-up.
- `ShareLinks.x` targets `twitter.com/intent/tweet`, and `ShareUtils` names the method `shareToTwitter`.
