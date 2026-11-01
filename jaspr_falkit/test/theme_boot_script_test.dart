import 'package:jaspr_falkit/jaspr_falkit.dart';
import 'package:jaspr_test/server_test.dart';

void main() {
  testServer('ThemeBootScript renders the boot script', (tester) async {
    tester.pumpComponent(
      const ThemeBootScript(
        lightClass: 'light bg-bg-default',
        darkClass: 'dark bg-bg-default',
      ),
    );
    final body = (await tester.request('/')).body;
    expect(body, contains('id="theme-boot"'));
    expect(body, contains("'jaspr_theme_preference'"));
    expect(body, contains("'dark bg-bg-default'"));
    expect(body, contains('window.falSetTheme'));
    expect(body, contains("setAttribute('data-theme'"));
  });

  testServer('ThemeBootScript escapes quotes and script end tags', (
    tester,
  ) async {
    tester.pumpComponent(const ThemeBootScript(darkClass: "a'b</script>"));
    final body = (await tester.request('/')).body;
    expect(body, contains(r"a\'b\x3c/script>"));
    expect(body, isNot(contains("a'b")));
  });
}
