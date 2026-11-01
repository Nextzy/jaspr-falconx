import 'package:jaspr_faltool/jaspr_faltool.dart';
import 'package:test/test.dart';

void main() {
  const url = 'https://a.com/p?x=1&y=2';
  const encoded = 'https%3A%2F%2Fa.com%2Fp%3Fx%3D1%26y%3D2';

  test('facebook encodes the url', () {
    expect(
      ShareLinks.facebook(url),
      'https://www.facebook.com/sharer/sharer.php?u=$encoded',
    );
  });

  test('x adds text only when given', () {
    expect(ShareLinks.x(url), 'https://twitter.com/intent/tweet?url=$encoded');
    expect(
      ShareLinks.x(url, text: 'hi there'),
      'https://twitter.com/intent/tweet?url=$encoded&text=hi%20there',
    );
  });

  test('linkedIn adds summary only when given', () {
    const base = 'https://www.linkedin.com/sharing/share-offsite/';
    expect(ShareLinks.linkedIn(url), '$base?url=$encoded');
    expect(
      ShareLinks.linkedIn(url, summary: 'a&b'),
      '$base?url=$encoded&summary=a%26b',
    );
  });

  test('line prepends text to the url', () {
    const base = 'https://social-plugins.line.me/lineit/share?text=';
    expect(ShareLinks.line(url), '$base$encoded');
    expect(ShareLinks.line(url, text: 'hi'), '${base}hi%20$encoded');
    expect(ShareLinks.line('a b', text: 'x'), '${base}x%20a%20b');
  });
}
