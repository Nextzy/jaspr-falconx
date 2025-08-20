import 'package:universal_web/web.dart' as web;

class ShareUtils {
  static String _getFullUrl(String url) {
    // If the URL is already absolute, return it as is
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }

    // Otherwise, construct the full URL using window.location
    final origin = web.window.location.origin;
    final path = url.startsWith('/') ? url : '/$url';
    return '$origin$path';
  }

  static Future<void> shareToFacebook(String url) async {
    final fullUrl = _getFullUrl(url);
    // Facebook doesn't support pre-filled text in the sharer dialog
    // The message will be extracted from the Open Graph meta tags
    final shareUrl =
        'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(fullUrl)}';
    web.window.open(shareUrl, '_blank');
  }

  static Future<void> shareToTwitter(String url, {String? message}) async {
    final fullUrl = _getFullUrl(url);
    final params = <String, String>{
      'url': fullUrl,
      if (message != null) 'text': message,
    };
    final queryString = params.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
    final shareUrl = 'https://twitter.com/intent/tweet?$queryString';
    web.window.open(shareUrl, '_blank');
  }

  static Future<void> shareToLinkedIn(String url, {String? message}) async {
    final fullUrl = _getFullUrl(url);
    // LinkedIn uses Open Graph tags for title and description
    // Custom message can be added through summary parameter (deprecated but sometimes works)
    final params = <String, String>{
      'url': fullUrl,
      if (message != null) 'summary': message,
    };
    final queryString = params.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
    final shareUrl =
        'https://www.linkedin.com/sharing/share-offsite/?$queryString';
    web.window.open(shareUrl, '_blank');
  }

  static Future<void> shareToLine(String url, {String? message}) async {
    final fullUrl = _getFullUrl(url);
    // LINE allows custom text to be prepended to the URL
    final shareText = message != null ? '$message $fullUrl' : fullUrl;
    final shareUrl =
        'https://social-plugins.line.me/lineit/share?text=${Uri.encodeComponent(shareText)}';
    web.window.open(shareUrl, '_blank');
  }

  static Future<bool> copyToClipboard(String text, {bool isUrl = false}) async {
    final textToCopy = isUrl ? _getFullUrl(text) : text;
    web.window.navigator.clipboard.writeText(textToCopy);
    return true;
  }
}
