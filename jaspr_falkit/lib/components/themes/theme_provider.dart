import 'package:jaspr_falkit/lib.dart';

class ThemeProvider extends InheritedComponent {
  const ThemeProvider({
    required this.currentTheme,
    required this.isDark,
    required this.setTheme,
    required super.child,
    super.key,
  });

  final ThemeMode currentTheme;
  final bool isDark;
  final void Function(ThemeMode) setTheme;

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return currentTheme != oldWidget.currentTheme;
  }
}
