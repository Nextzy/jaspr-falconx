import 'package:jaspr_falconx/src/locale/locale_resolution.dart';

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
  final current = localeFromPath(pathOnly, supported);
  final rest = current == null
      ? pathOnly
      : pathOnly.substring(pathOnly.indexOf(current) + current.length);
  return '/$toCode${rest == '/' ? '' : rest}$suffix';
}
