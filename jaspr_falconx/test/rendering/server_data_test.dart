import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falconx/jaspr_falconx.dart';
import 'package:jaspr_test/server_test.dart';

void main() {
  testServer('renders builder on success', (tester) async {
    tester.pumpComponent(
      ServerData<String>(
        load: () async => Result.success('hi'),
        builder: (_, d) => Component.text('data:$d'),
        errorBuilder: (_, e) => const Component.text('err'),
      ),
    );
    final r = await tester.request('/');
    expect(r.body, contains('data:hi'));
    expect(r.headers['cache-control'], isNull);
  });

  testServer('renders errorBuilder and no-store on failure', (tester) async {
    tester.pumpComponent(
      ServerData<String>(
        load: () async => Result.failure(
          const DomainLayerException(type: SystemErrorType.unexpected),
        ),
        builder: (_, d) => const Component.text('data'),
        errorBuilder: (_, e) => const Component.text('err'),
      ),
    );
    final r = await tester.request('/');
    expect(r.body, contains('err'));
    expect(r.headers['cache-control'], 'no-store');
  });

  testServer('requestHeader is null when the header is absent', (tester) async {
    tester.pumpComponent(
      Builder(
        builder: (context) =>
            Component.text('al:${requestHeader(context, 'Accept-Language')}'),
      ),
    );
    final r = await tester.request('/');
    expect(r.body, contains('al:null'));
  });
}
