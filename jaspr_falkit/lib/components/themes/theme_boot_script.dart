import 'package:jaspr_falkit/lib.dart';

/// localStorage key holding the visitor's theme preference.
const String themeStorageKey = 'jaspr_theme_preference';

/// Next preference in the toggle cycle: light, dark, system, light.
ThemeMode nextThemeMode(ThemeMode current) => switch (current) {
  ThemeMode.light => ThemeMode.dark,
  ThemeMode.dark => ThemeMode.system,
  ThemeMode.system => ThemeMode.light,
};

/// Inline `<script id="theme-boot">` that paints the theme class on `<html>`
/// before first paint and exposes `window.falSetTheme(pref)`.
///
/// The server cannot know the visitor's preference, so the browser applies it
/// from localStorage and `prefers-color-scheme`. This keeps pages cacheable.
class ThemeBootScript extends StatelessComponent {
  const ThemeBootScript({
    this.lightClass = 'light',
    this.darkClass = 'dark',
    this.storageKey = themeStorageKey,
    super.key,
  });

  /// Class set on `<html>` for the light theme.
  final String lightClass;

  /// Class set on `<html>` for the dark theme.
  final String darkClass;

  /// localStorage key read and written by the script.
  final String storageKey;

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'script',
      attributes: const {'id': 'theme-boot'},
      children: [RawText(_script())],
    );
  }

  String _script() {
    final k = _jsString(storageKey);
    final l = _jsString(lightClass);
    final d = _jsString(darkClass);
    // Paint before subscribing, so a browser without
    // MediaQueryList.addEventListener (Safari before 14) still gets the theme.
    // classList keeps every <html> class that is not a theme token.
    return """
(function(){var k='$k',L=t('$l'),D=t('$d'),h=document.documentElement,m=matchMedia('(prefers-color-scheme: dark)'),cur;
function t(s){return s.split(' ').filter(function(x){return x;});}
function paint(p){var dark=p==='dark'||(p==='system'&&m.matches),c=h.classList,a=dark?D:L,i;for(i=0;i<L.length;i++)c.remove(L[i]);for(i=0;i<D.length;i++)c.remove(D[i]);for(i=0;i<a.length;i++)c.add(a[i]);h.setAttribute('data-theme',p);}
function read(){try{return localStorage.getItem(k)||'system'}catch(e){return 'system'}}
function onChange(){if(cur==='system')paint('system');}
window.falSetTheme=function(p){cur=p;try{localStorage.setItem(k,p)}catch(e){}paint(p);};
cur=read();paint(cur);
if(m.addEventListener)m.addEventListener('change',onChange);else if(m.addListener)m.addListener(onChange);})();""";
  }

  /// Escapes [value] for a single-quoted JS string inside an inline script.
  static String _jsString(String value) => value
      .replaceAll(r'\', r'\\')
      .replaceAll("'", r"\'")
      .replaceAll('<', r'\x3c')
      .replaceAll('\n', r'\n')
      .replaceAll('\r', r'\r');
}
