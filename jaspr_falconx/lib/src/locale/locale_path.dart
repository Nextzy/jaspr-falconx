/// Returns [path] with its locale segment set to [toCode].
///
/// Replaces the first segment when it is in [supported], otherwise prefixes
/// [toCode]. Keeps the `?query` and `#fragment`.
String switchLocalePath(
  String path,
  String toCode,
  Iterable<String> supported,
) {
  final end = path.indexOf(RegExp('[?#]'));
  final suffix = end == -1 ? '' : path.substring(end);
  final pathOnly = end == -1 ? path : path.substring(0, end);
  final segments = pathOnly.split('/').where((s) => s.isNotEmpty).toList();
  if (segments.isNotEmpty && supported.contains(segments.first)) {
    segments.removeAt(0);
  }
  return '/${[toCode, ...segments].join('/')}$suffix';
}
