/// Returns the lowercase extension of the last segment of [path], or an empty
/// string when that segment has none. A leading dot (`.env`) is not an
/// extension.
String fileExtensionOf(String path) {
  final name = path.substring(path.lastIndexOf('/') + 1);
  final dot = name.lastIndexOf('.');
  return dot <= 0 ? '' : name.substring(dot + 1).toLowerCase();
}
