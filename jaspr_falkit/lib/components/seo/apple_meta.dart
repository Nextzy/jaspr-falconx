import 'package:jaspr_falkit/lib.dart';

class AppleTag {
  const AppleTag({
    this.title,
    this.capable,
    this.fullscreen,
    this.iconUrl,
    this.color,
  });

  final String? title;
  final String? capable;
  final String? fullscreen;
  final String? iconUrl;
  final String? color;
}

class AppleMeta extends Fragment {
  AppleMeta(AppleTag tag)
      : super(
          children: [
            Meta(
                name: 'apple-mobile-web-app-status-bar-style',
                content: 'default'),
            if (tag.title.isNotNullOrBlank)
              Meta(name: 'apple-mobile-web-app-title', content: tag.title),
            Meta(
                name: 'apple-mobile-web-app-capable',
                content: tag.capable ?? 'yes'),
            Meta(
                name: 'apple-touch-fullscreen',
                content: tag.fullscreen ?? 'yes'),
            if (tag.iconUrl.isNotNullOrBlank)
              link(rel: 'apple-touch-icon', href: tag.iconUrl!),
            script(src: 'https://unpkg.com/ios-pwa-splash@1.0.0/cdn.min.js'),
            script(
              src: '',
              content:
                  "iosPWASplash('/apple-touch-icon.png', '${tag.color ?? '#FFFFFF'}');",
            )
          ],
        );
}
