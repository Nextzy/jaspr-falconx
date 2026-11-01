import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:jaspr_falmodel/jaspr_falmodel.dart';

@JS('falSetTheme')
external void _falSetTheme(String pref);

/// Stores [mode] and repaints the page through `window.falSetTheme`.
///
/// Requires `ThemeBootScript` in the document head, which defines that
/// function; throws a [StateError] when it is missing.
void setThemePreference(ThemeMode mode) {
  if (!globalContext.has('falSetTheme')) {
    throw StateError(
      'setThemePreference needs ThemeBootScript in the document head',
    );
  }
  _falSetTheme(mode.name);
}
