import 'package:jaspr/dom.dart' show StyleRule;
import 'package:jaspr/server.dart';
import 'package:jaspr_falserver/jaspr_falserver.dart';
import 'package:test/test.dart';

void main() {
  test('versionedPath', () {
    expect(versionedPath('styles.css', 'b1'), '_v/b1/styles.css');
    expect(
      versionedPath('/main.client.dart.js', 'b1'),
      '_v/b1/main.client.dart.js',
    );
    expect(versionedPath('styles.css', null), 'styles.css');
    expect(versionedPath('styles.css', ''), 'styles.css');
  });

  test('splitVersion', () {
    expect(splitVersion('_v/b1/a/b.js'), (id: 'b1', rest: 'a/b.js'));
    expect(splitVersion('/_v/b1/a.js'), (id: 'b1', rest: 'a.js'));
    expect(splitVersion('_v/b1'), isNull);
    expect(splitVersion('en/profile'), isNull);
  });

  test('versionedServerOptions', () {
    final o = versionedServerOptions(
      const ServerOptions(clientId: 'main.client.dart.js'),
      'b1',
    );
    expect(o.clientId, '_v/b1/main.client.dart.js');
    expect(
      versionedServerOptions(const ServerOptions(), 'b1').clientId,
      isNull,
    );
  });

  test('versionedServerOptions versions stylesId and keeps the rest', () {
    const clients = <Type, ClientTarget>{};
    List<StyleRule> styles() => const [];
    final o = versionedServerOptions(
      ServerOptions(
        clientId: 'main.client.dart.js',
        clients: clients,
        stylesId: 'main.server.css',
        styles: styles,
      ),
      'b1',
    );
    expect(o.stylesId, '_v/b1/main.server.css');
    expect(o.clients, same(clients));
    expect(o.styles, same(styles));
    expect(
      versionedServerOptions(const ServerOptions(), 'b1').stylesId,
      isNull,
    );
    expect(
      versionedServerOptions(
        const ServerOptions(stylesId: 'main.server.css'),
        null,
      ).stylesId,
      'main.server.css',
    );
  });
}
