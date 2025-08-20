import 'package:jaspr_falkit/lib.dart';
import 'package:universal_web/web.dart' as web;

class ThemeManager extends StatefulComponent {
  const ThemeManager({
    required this.builder,
    this.initialTheme,
    super.key,
  });

  static const themeStorageKey = 'jaspr_theme_preference';

  final ThemeMode? initialTheme;
  final Component Function(BuildContext context, ThemeMode theme) builder;

  static ThemeMode loadTheme() {
    if (kIsWeb) {
      final themeStr = KeyValueStorage.instance.load(themeStorageKey);
      if (themeStr == null) {
        return ThemeMode.system;
      } else {
        return ThemeMode.values.firstWhere(
          (theme) => theme.name == themeStr,
          orElse: () => ThemeMode.system,
        );
      }
    }
    return ThemeMode.system;
  }

  @override
  State<ThemeManager> createState() => ThemeManagerState();
}

class ThemeManagerState extends State<ThemeManager> {
  ThemeMode _currentTheme = ThemeMode.system;
  bool _isDark = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _currentTheme = component.initialTheme ?? ThemeManager.loadTheme();
      applyTheme(_currentTheme);
    }
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield ThemeProvider(
      currentTheme: _currentTheme,
      isDark: _isDark,
      setTheme: setTheme,
      child: component.builder(context, _currentTheme),
    );
  }

  void applyTheme(ThemeMode themeMode) {
    if (kIsWeb) {
      switch (themeMode) {
        case ThemeMode.light:
          _isDark = false;
        case ThemeMode.dark:
          _isDark = true;
        case ThemeMode.system:
          _isDark = prefersDarkMode();
      }
    }
  }

  bool prefersDarkMode() {
    if (!kIsWeb) {
      // Cannot detect system theme on server, default to false
      return false;
    }

    try {
      // Use the prefers-color-scheme media query
      return web.window.matchMedia('(prefers-color-scheme: dark)').matches;
    } catch (e) {
      Log.e('Error detecting system theme: $e');
      return false;
    }
  }

  void setTheme(ThemeMode theme) {
    setState(() {
      _currentTheme = theme;
      saveTheme(theme);
      applyTheme(theme);
    });
  }

  void saveTheme(ThemeMode theme) {
    KeyValueStorage.instance
        .save(ThemeManager.themeStorageKey, data: theme.name);
  }
}
