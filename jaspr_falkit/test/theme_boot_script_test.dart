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

  testServer('ThemeBootScript paints before it subscribes', (tester) async {
    tester.pumpComponent(const ThemeBootScript());
    final body = (await tester.request('/')).body;
    final paint = body.indexOf('cur=read();paint(cur);');
    final subscribe = body.indexOf("m.addEventListener('change'");
    expect(paint, isNonNegative);
    expect(subscribe, greaterThan(paint));
  });

  testServer('ThemeBootScript falls back to addListener', (tester) async {
    tester.pumpComponent(const ThemeBootScript());
    final body = (await tester.request('/')).body;
    expect(
      body,
      contains(
        "if(m.addEventListener)m.addEventListener('change',onChange);"
        'else if(m.addListener)m.addListener(onChange);',
      ),
    );
  });

  testServer('ThemeBootScript edits classList and keeps other classes', (
    tester,
  ) async {
    tester.pumpComponent(
      const ThemeBootScript(
        lightClass: 'light bg-bg-default',
        darkClass: 'dark bg-bg-default',
      ),
    );
    final body = (await tester.request('/')).body;
    expect(body, isNot(contains('className')));
    expect(body, contains('c=h.classList'));
    expect(body, contains("L=t('light bg-bg-default')"));
    expect(body, contains("D=t('dark bg-bg-default')"));
    expect(body, contains('c.remove(L[i])'));
    expect(body, contains('c.remove(D[i])'));
    expect(body, contains('c.add(a[i])'));
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
