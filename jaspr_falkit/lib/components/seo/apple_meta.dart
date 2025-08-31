import 'package:jaspr_falkit/lib.dart';

class AppleMeta extends Fragment {
  AppleMeta({
    this.title,
    this.capable,
    this.fullscreen,
    this.iconUrl,
    this.color,
    String appleIcon = '/apple-touch-icon.png',
    String pwaScript = 'https://unpkg.com/ios-pwa-splash@1.0.0/cdn.min.js',
  }) : super(
         children: [
           Meta(
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
             name: 'apple-touch-fullscreen',
             content: fullscreen ?? 'yes',
             unique: true,
           ),
           if (iconUrl.isNotNullOrBlank)
             LinkHeader(
               rel: 'apple-touch-icon',
               href: iconUrl!,
               unique: true,
             ),
           script(
             id: pwaScript.hashStr(length: 15),
             src: pwaScript,
           ),
           script(
             id: appleIcon.hashStr(length: 5),
             src: '',
             content: "iosPWASplash('$appleIcon', '${color ?? '#FFFFFF'}');",
           ),
         ],
       );

  final String? title;
  final String? capable;
  final String? fullscreen;
  final String? iconUrl;
  final String? color;
}
