import 'dart:js_interop';

import 'package:jaspr_falmodel/jaspr_falmodel.dart';

@JS('falSetTheme')
external void _falSetTheme(String pref);

/// Stores [mode] and repaints the page through `window.falSetTheme`, defined
/// by the inline theme boot script.
void setThemePreference(ThemeMode mode) => _falSetTheme(mode.name);
