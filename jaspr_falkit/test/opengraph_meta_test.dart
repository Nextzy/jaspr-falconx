import 'package:jaspr_falkit/jaspr_falkit.dart';
import 'package:jaspr_test/server_test.dart';

void main() {
  testServer('DefaultOpenGraphMeta emits og:image without preloading it', (
    tester,
  ) async {
    tester.pumpComponent(
      const DefaultOpenGraphMeta(imageUrl: 'https://nonthawit.com/share.png'),
    );
    final response = await tester.request('/');

    expect(response.body, contains('og:image'));
    expect(response.body, contains('https://nonthawit.com/share.png'));
    expect(response.body, isNot(contains('rel="preload"')));
    expect(response.body, isNot(contains('as="image"')));
  });
}
