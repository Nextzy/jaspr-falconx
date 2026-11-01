/// Named `truncateText` because `dart_faltool` already defines a different
/// `String.truncate(int?, {ellipsis})`; two same-named extension members make
/// every call ambiguous when both are in scope.
extension AppNullStringExtension on String? {
  String truncateText({int maxLength = 157, String? truncate}) {
    if (this == null) return '';
    return this!.length > maxLength
        ? '${this!.substring(0, maxLength)}${truncate ?? '...'}'
        : this ?? '';
  }
}

extension AppStringExtension on String {
  String truncateText({int maxLength = 157, String? truncate}) {
    return length > maxLength
        ? '${substring(0, maxLength)}${truncate ?? '...'}'
        : this;
  }
}
