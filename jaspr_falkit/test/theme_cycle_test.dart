import 'package:jaspr_falkit/jaspr_falkit.dart';
import 'package:test/test.dart';

void main() {
  test('nextThemeMode cycles light, dark, system', () {
    expect(nextThemeMode(ThemeMode.light), ThemeMode.dark);
    expect(nextThemeMode(ThemeMode.dark), ThemeMode.system);
    expect(nextThemeMode(ThemeMode.system), ThemeMode.light);
  });
}
