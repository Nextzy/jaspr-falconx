import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falkit/jaspr_falkit.dart';
import 'package:jaspr_test/server_test.dart';

void main() {
  testServer('SeoMetaTags renders no msvalidate.01 by default', (tester) async {
    tester.pumpComponent(
      const Document.head(children: [SeoMetaTags(title: 'T')]),
    );
    final response = await tester.request('/');

    expect(response.body, isNot(contains('msvalidate.01')));
  });

  testServer('SeoMetaTags renders the given msValidate', (tester) async {
    tester.pumpComponent(
      const Document.head(
        children: [
          SeoMetaTags(
            title: 'T',
            microsoft: MicrosoftMeta(msValidate: 'abc'),
          ),
        ],
      ),
    );
    final response = await tester.request('/');

    expect(response.body, contains('msvalidate.01'));
    expect(response.body, contains('content="abc"'));
  });

  testServer('SeoMetaTags keeps schemaWebSite fields beside the fallback', (
    tester,
  ) async {
    tester.pumpComponent(
      SeoDefaults(
        siteName: 'Site',
        child: Document.head(
          children: [
            SeoMetaTags(
              title: 'T',
              schemaWebSite: WebSiteSchemaData(
                potentialAction: WebSiteSchema.createSearchAction(
                  searchUrlTemplate: 'https://x.com/s?q={q}',
                ),
                sameAs: const ['https://x.com/a'],
              ),
            ),
          ],
        ),
      ),
    );
    final response = await tester.request('/');

    expect(response.body, contains('"potentialAction"'));
    expect(response.body, contains('"sameAs":["https://x.com/a"]'));
    expect(response.body, contains('"name":"Site"'));
  });

  testServer('SeoMetaTags lets schemaWebSite.name win over the fallbacks', (
    tester,
  ) async {
    tester.pumpComponent(
      Document.head(
        children: [
          SeoMetaTags(
            title: 'T',
            schemaWebSite: WebSiteSchemaData(name: 'X'),
          ),
        ],
      ),
    );
    final response = await tester.request('/');

    expect(response.body, contains('"name":"X"'));
    expect(response.body, isNot(contains('"name":"T"')));
  });

  testServer('MicrosoftMeta renders no msvalidate.01 for a blank value', (
    tester,
  ) async {
    tester.pumpComponent(
      const Document.head(children: [MicrosoftMeta(msValidate: '  ')]),
    );
    final response = await tester.request('/');

    expect(response.body, isNot(contains('msvalidate.01')));
  });

  testServer('DefaultMeta canonical in an inner head replaces the outer one', (
    tester,
  ) async {
    tester.pumpComponent(
      const Document.head(
        children: [
          DefaultMeta(canonical: 'https://a/'),
          Document.head(children: [DefaultMeta(canonical: 'https://b/')]),
        ],
      ),
    );
    final response = await tester.request('/');

    expect('rel="canonical"'.allMatches(response.body), hasLength(1));
    expect(response.body, contains('href="https://b/"'));
    expect(response.body, isNot(contains('href="https://a/"')));
  });

  testServer('SeoMetaTags keeps schemaBlogPosting fields beside the fallback', (
    tester,
  ) async {
    tester.pumpComponent(
      Document.head(
        children: [
          SeoMetaTags(
            title: 'Post',
            type: OgType.article,
            schemaBlogPosting: BlogPostingSchema(
              about: const {'@type': 'Thing', 'name': 'Dart'},
            ),
          ),
        ],
      ),
    );
    final response = await tester.request('/');

    expect(response.body, contains('"about"'));
    expect(response.body, contains('"headline":"Post"'));
  });

  testServer('LinkHeader keeps links that differ only in href', (tester) async {
    tester.pumpComponent(
      const Document.head(
        children: [
          LinkHeader(rel: 'preload', href: '/a.woff2'),
          LinkHeader(rel: 'preload', href: '/b.woff2'),
        ],
      ),
    );
    final response = await tester.request('/');

    expect(response.body, contains('/a.woff2'));
    expect(response.body, contains('/b.woff2'));
  });

  testServer('DefaultMeta favicon in an inner head replaces the outer one', (
    tester,
  ) async {
    tester.pumpComponent(
      const Document.head(
        children: [
          DefaultMeta(favicon: '/a.ico', faviconSvg: '/a.svg'),
          Document.head(
            children: [DefaultMeta(favicon: '/b.ico', faviconSvg: '/b.svg')],
          ),
        ],
      ),
    );
    final response = await tester.request('/');

    expect('rel="icon"'.allMatches(response.body), hasLength(2));
    expect(response.body, contains('href="/b.ico"'));
    expect(response.body, contains('href="/b.svg"'));
    expect(response.body, isNot(contains('/a.ico')));
    expect(response.body, isNot(contains('/a.svg')));
  });
}
