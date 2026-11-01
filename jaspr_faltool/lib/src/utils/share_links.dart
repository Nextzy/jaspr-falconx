/// Builds the URL that opens each social network's share dialog.
///
/// Every `url` must be absolute. The builders are pure and encode each value.
abstract final class ShareLinks {
  /// Returns the Facebook sharer URL for [url].
  static String facebook(String url) =>
      'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(url)}';

  /// Returns the X (Twitter) tweet-intent URL for [url] with optional [text].
  static String x(String url, {String? text}) =>
      'https://twitter.com/intent/tweet?${_query({'url': url, 'text': ?text})}';

  /// Returns the LinkedIn share URL for [url] with an optional [summary].
  static String linkedIn(String url, {String? summary}) =>
      'https://www.linkedin.com/sharing/share-offsite/?'
      '${_query({'url': url, 'summary': ?summary})}';

  /// Returns the LINE share URL for [url], with [text] before it when given.
  static String line(String url, {String? text}) =>
      'https://social-plugins.line.me/lineit/share?text='
      '${Uri.encodeComponent(text != null ? '$text $url' : url)}';

  static String _query(Map<String, String> params) => params.entries
      .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
