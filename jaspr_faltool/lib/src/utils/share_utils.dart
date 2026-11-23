import 'package:jaspr/jaspr.dart' show kIsWeb;
import 'package:jaspr_faltool/src/utils/share_links.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

/// Opens share dialogs and copies text in the browser.
///
/// Every method does nothing on the server.
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
    if (!kIsWeb) return;
    final fullUrl = _getFullUrl(url);
    // Facebook doesn't support pre-filled text in the sharer dialog
    // The message will be extracted from the Open Graph meta tags
    web.window.open(ShareLinks.facebook(fullUrl), '_blank');
  }

  static Future<void> shareToTwitter(String url, {String? message}) async {
    if (!kIsWeb) return;
    final fullUrl = _getFullUrl(url);
    web.window.open(ShareLinks.x(fullUrl, text: message), '_blank');
  }

  static Future<void> shareToLinkedIn(String url, {String? message}) async {
    if (!kIsWeb) return;
    final fullUrl = _getFullUrl(url);
    // LinkedIn uses Open Graph tags for title and description
    // Custom message can be added through summary parameter
    // (deprecated but sometimes works)
    web.window.open(ShareLinks.linkedIn(fullUrl, summary: message), '_blank');
  }

  static Future<void> shareToLine(String url, {String? message}) async {
    if (!kIsWeb) return;
    final fullUrl = _getFullUrl(url);
    // LINE allows custom text to be prepended to the URL
    web.window.open(ShareLinks.line(fullUrl, text: message), '_blank');
  }

  /// Copies [text] and returns whether the browser accepted it.
  ///
  /// Returns `false` on the server or when the browser rejects the write.
  static Future<bool> copyToClipboard(String text, {bool isUrl = false}) async {
    if (!kIsWeb) return false;
    final textToCopy = isUrl ? _getFullUrl(text) : text;
    try {
      await web.window.navigator.clipboard.writeText(textToCopy).toDart;
      return true;
    } on Object {
      return false;
    }
  }
}
