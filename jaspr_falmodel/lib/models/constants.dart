enum ComponentSize {
  micro,
  tiny,
  small,
  medium,
  large,
  huge,
  giant,
}

enum ThemeMode {
  /// Use either the light or dark theme based on what the user has selected in
  /// the system settings.
  system,

  /// Always use the light mode regardless of system preference.
  light,

  /// Always use the dark mode (if available) regardless of system preference.
  dark;

  bool get isSystem => this == ThemeMode.system;

  bool get isLight => this == ThemeMode.light;

  bool get isDark => this == ThemeMode.dark;

  /// Converts a string to a ThemeMode enum value
  static ThemeMode fromJson(Map<String, dynamic> data) {
    return switch (data['mode']) {
      'system' => ThemeMode.system,
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Map<String, dynamic> toJson() => switch (this) {
    ThemeMode.system => {'mode': 'system'},
    ThemeMode.light => {'mode': 'light'},
    ThemeMode.dark => {'mode': 'dark'},
  };
}
