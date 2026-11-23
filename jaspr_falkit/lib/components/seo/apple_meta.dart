import 'package:jaspr_falkit/lib.dart';
import 'package:jaspr_falkit/src/script_json.dart';

class AppleMeta extends StatelessComponent {
  const AppleMeta({
    this.title,
    this.capable,
    this.fullscreen,
    this.iconUrl,
    this.color,
    this.appleIcon,
    this.pwaScript,
  });

  final String? title;
  final String? capable;
  final String? fullscreen;
  final String? iconUrl;
  final String? color;
  final String? appleIcon;

  /// URL of an iOS splash library; the inline script loads it only when set.
  final String? pwaScript;

  @override
  Component build(BuildContext context) => Document.head(
    children: [
      const Meta(
        name: 'apple-mobile-web-app-status-bar-style',
        content: 'default',
        unique: true,
      ),
      if (title.isNotNullOrBlank)
        Meta(name: 'apple-mobile-web-app-title', content: title, unique: true),
      Meta(
        name: 'apple-mobile-web-app-capable',
        content: capable ?? 'yes',
        unique: true,
      ),
      Meta(
        name: 'mobile-web-app-capable',
        content: capable ?? 'yes',
        unique: true,
      ),
      Meta(
        name: 'apple-touch-fullscreen',
        content: fullscreen ?? 'yes',
        unique: true,
      ),
      if (appleIcon.isNotNullOrBlank || iconUrl.isNotNullOrBlank)
        LinkHeader(
          id: 'link-apple-touch-icon',
          unique: false,
          rel: 'apple-touch-icon',
          href: appleIcon ?? iconUrl!,
        ),
      if (pwaScript.isNotNullOrBlank)
        script(
          id: (appleIcon ?? iconUrl)?.hashSha256(length: 5),
          // Load `pwaScript` only on iOS, after `window.load`, and call into it
          // from its `onload` so other platforms never download it.
          content:
              """
window.addEventListener('load', function() {
  var isIOS = (
    ['iPad Simulator','iPhone Simulator','iPod Simulator','iPad','iPhone','iPod']
      .includes(navigator.platform) ||
    (navigator.platform === 'MacIntel' && navigator.maxTouchPoints > 1) ||
    (/^(iPad|iPhone|iPod)/.test(navigator.userAgent) && !window.MSStream)
  );
  
  if (isIOS) {
    var s = document.createElement('script');
    s.src = ${encodeScriptJson(pwaScript)};
    s.onload = function() {
      iosPWASplash(${encodeScriptJson(appleIcon ?? iconUrl)}, ${encodeScriptJson(color ?? '#FFFFFF')});
    };
    document.head.appendChild(s);
  }
});
""",
        ),
    ],
  );
}
