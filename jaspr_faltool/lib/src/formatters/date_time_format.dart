import 'package:dart_faltool/dart_faltool.dart' show DateFormat;

class AppDateTime {
  static DateTime? dateTimeFromString(String? dateString) {
    return dateString != null ? DateTime.parse(dateString) : null;
  }

  static String? dateTimeToString(DateTime? dateTime) {
    return dateTime?.toIso8601String();
  }
}

extension DateTimeFormatNullExtension on DateTime? {
  String? toFormatString({String format = 'd MMM yyyy', String? locale}) {
    if (this == null) return null;
    return DateFormat(format, locale).format(this!);
  }
}

extension DateTimeFormatExtension on DateTime {
  String toFormatString({String format = 'd MMM yyyy', String? locale}) {
    return DateFormat(format, locale).format(this);
  }
}

extension StringDateTimeFormatNullExtension on String? {
  DateTime? toDateTime([String format = 'd MMM yyyy']) {
    if (this == null) return null;
    final formatter = DateFormat(format);
    return formatter.parse(this!);
  }
}

extension StringDateTimeFormatExtension on String {
  DateTime toDateTime([String format = 'd MMM yyyy']) {
    final formatter = DateFormat(format);
    return formatter.parse(this);
  }
}
