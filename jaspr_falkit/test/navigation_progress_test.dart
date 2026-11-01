import 'package:jaspr_falkit/jaspr_falkit.dart';
import 'package:jaspr_test/server_test.dart';

void main() {
  testServer('NavigationProgress renders the bar, style, and script', (
    tester,
  ) async {
    tester.pumpComponent(
      const NavigationProgress(
        color: '#2f6fed',
        height: '4px',
        showDelay: Duration(milliseconds: 250),
        zIndex: 7,
      ),
    );
    final body = (await tester.request('/')).body;
    expect(body, contains('id="fal-nav-progress"'));
    expect(body, contains('aria-hidden="true"'));
    expect(body, contains('#2f6fed'));
    expect(body, contains('4px'));
    expect(body, contains('250'));
    expect(body, contains('z-index:7'));
    expect(body, contains('<script'));
    expect(body, contains('prefers-reduced-motion'));
    expect(body, contains('pageshow'));
    expect(body, contains('pagehide'));
  });

  testServer('NavigationProgress defaults', (tester) async {
    tester.pumpComponent(const NavigationProgress());
    final body = (await tester.request('/')).body;
    expect(body, contains('currentColor'));
    expect(body, contains('3px'));
    expect(body, contains('150'));
    expect(body, contains('z-index:9999'));
  });

  testServer('NavigationProgress filters the clicks it reacts to', (
    tester,
  ) async {
    tester.pumpComponent(const NavigationProgress());
    final body = (await tester.request('/')).body;
    expect(body, contains('defaultPrevented'));
    expect(body, contains('e.button'));
    expect(body, contains('metaKey'));
    expect(body, contains('download'));
    expect(body, contains('target'));
    expect(body, contains('new URL(h)'));
    expect(body, isNot(contains('location.href')));
    expect(body, contains('location.origin'));
    expect(body, contains('pathname'));
    expect(body, contains('search'));
  });

  testServer('NavigationProgress escapes a hostile color', (tester) async {
    tester.pumpComponent(
      const NavigationProgress(
        color: "red;}</style><script>alert('x')</script>",
        height: '3px</style><script>alert(1)</script>',
      ),
    );
    final body = (await tester.request('/')).body;
    expect(body, isNot(contains('</style><script>alert')));
    expect(body, isNot(contains('<script>alert')));
    expect(body, isNot(contains('</script><script>')));
  });

  testServer('NavigationProgress is flat by default', (tester) async {
    tester.pumpComponent(const NavigationProgress(color: '#2f6fed'));
    final body = (await tester.request('/')).body;
    expect(body, isNot(contains('box-shadow')));
  });

  testServer('NavigationProgress glow adds the box-shadow', (tester) async {
    tester.pumpComponent(
      const NavigationProgress(color: '#2f6fed', glow: true),
    );
    final body = (await tester.request('/')).body;
    expect(body, contains('box-shadow:0 0 6px #2f6fed'));
  });
}
