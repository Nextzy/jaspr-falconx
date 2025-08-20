import 'package:jaspr_falmodel/lib.dart';

class Locale {
  const Locale({
    required this.languageCode,
    this.scriptCode,
    this.countryCode,
  });

  final String languageCode;
  final String? scriptCode;
  final String? countryCode;

  /// Concatenates language, script and country code with dashes.
  String get languageTag => [languageCode, scriptCode, countryCode]
      .where((element) => element != null)
      .join('-');

  /// For whatever reason, the intl package uses underscores instead of dashes
  /// that contradicts https://www.unicode.org/reports/tr35/
  /// that is used by the Locale class in dart:ui.
  String get underscoreTag => [languageCode, scriptCode, countryCode]
      .where((element) => element != null)
      .join('_');

  @override
  String toString() =>
      'Locale{languageCode: $languageCode, scriptCode: $scriptCode, countryCode: $countryCode}';
}
