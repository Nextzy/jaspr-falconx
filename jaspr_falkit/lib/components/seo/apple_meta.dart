import 'package:jaspr_falkit/lib.dart';

class AppleMeta extends StatelessComponent {
  const AppleMeta({
    this.title,
    this.capable,
    this.fullscreen,
    this.iconUrl,
    this.color,
    this.appleIcon,
    this.pwaScript = 'https://unpkg.com/ios-pwa-splash@1.0.0/cdn.min.js',
  });

  final String? title;
  final String? capable;
  final String? fullscreen;
  final String? iconUrl;
  final String? color;
  final String? appleIcon;
  final String pwaScript;

  @override
  Component build(BuildContext context) => Document.head(
    children: [
      const Meta(
        name: 'apple-mobile-web-app-status-bar-style',
        content: 'default',
        unique: true,
      ),
      if (title.isNotNullOrBlank)
        Meta(
          name: 'apple-mobile-web-app-title',
          content: title,
          unique: true,
        ),
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
          rel: 'apple-touch-icon',
          href: appleIcon ?? iconUrl!,
        ),
      script(
        id: pwaScript.hashStr(length: 5),
        src: pwaScript,
      ),
      script(
        id: (appleIcon ?? iconUrl)?.hashStr(length: 5),
        src: '',
        content:
            "iosPWASplash('${appleIcon ?? iconUrl}', '${color ?? '#FFFFFF'}');",
      ),
    ],
  );
}
