/// Returns the first non-empty segment of [path] when it is in [supported].
///
/// Any query string or fragment on [path] is ignored.
String? localeFromPath(String path, Iterable<String> supported) {
  final end = path.indexOf(RegExp('[?#]'));
  final pathOnly = end == -1 ? path : path.substring(0, end);
  for (final segment in pathOnly.split('/')) {
    if (segment.isEmpty) continue;
    return supported.contains(segment) ? segment : null;
  }
  return null;
}

/// Picks the best locale from an `Accept-Language` header value.
///
/// Languages are ranked by q-value (ties keep header order); a region subtag
/// is dropped (`th-TH` matches `th`). Languages with q=0 are refused. Returns
/// [fallback] when nothing matches.
String pickLocale(
  String? acceptLanguage,
  Iterable<String> supported, {
  required String fallback,
}) {
  if (acceptLanguage == null || acceptLanguage.trim().isEmpty) return fallback;

  final candidates = <({String language, double q, int order})>[];
  var order = 0;
  for (final part in acceptLanguage.split(',')) {
    final pieces = part.split(';');
    final tag = pieces.first.trim().toLowerCase();
    if (tag.isEmpty) continue;
    var q = 1.0;
    for (final param in pieces.skip(1)) {
      final kv = param.split('=');
      if (kv.length == 2 && kv[0].trim().toLowerCase() == 'q') {
        q = double.tryParse(kv[1].trim()) ?? 0;
      }
    }
    if (q <= 0) continue;
    candidates.add((language: tag.split('-').first, q: q, order: order++));
  }

  candidates.sort((a, b) {
    final byQ = b.q.compareTo(a.q);
    return byQ != 0 ? byQ : a.order.compareTo(b.order);
  });

  for (final candidate in candidates) {
    if (supported.contains(candidate.language)) return candidate.language;
  }
  return fallback;
}
