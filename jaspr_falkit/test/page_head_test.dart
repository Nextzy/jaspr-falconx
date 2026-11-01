import 'package:jaspr_falkit/jaspr_falkit.dart';
import 'package:jaspr_test/server_test.dart';

PageHead _head(
  String path,
  void Function(PageSeoContext) capture, {
  String languageCode = 'en',
  String? defaultLanguageCode,
}) => PageHead(
  languageCode: languageCode,
  supportedLanguageCodes: const ['th', 'en'],
  siteUrl: 'https://nonthawit.com',
  path: path,
  defaultLanguageCode: defaultLanguageCode,
  rootBreadcrumbName: 'Nonthawit',
  breadcrumbName: (segment) => segment == 'projects' ? 'Projects' : null,
  seo: (ctx) {
    capture(ctx);
    return const SeoMetaTags(title: 'T');
  },
);

void main() {
  testServer('PageHead builds url, alternates, and breadcrumbs', (
    tester,
  ) async {
    late PageSeoContext ctx;
    tester.pumpComponent(_head('/en/projects/42', (c) => ctx = c));
    final response = await tester.request('/');

    expect(ctx.url, 'https://nonthawit.com/en/projects/42');
    expect(ctx.canonical, ctx.url);
    expect(ctx.alternateLanguageUrls.map((t) => '${t.locale}=${t.url}'), [
      'th=https://nonthawit.com/th/projects/42',
      'en=https://nonthawit.com/en/projects/42',
      'x-default=https://nonthawit.com/en/projects/42',
    ]);
    expect(ctx.breadcrumbItems.map((b) => b.url), [
      'https://nonthawit.com/en',
      'https://nonthawit.com/en/projects',
      'https://nonthawit.com/en/projects/42',
    ]);
    expect(ctx.breadcrumbItems.map((b) => b.name), [
      'Nonthawit',
      'Projects',
      '42',
    ]);
    expect(response.body, contains('lang="en"'));
  });

  testServer('PageHead emits no breadcrumbs for an empty path', (tester) async {
    late PageSeoContext ctx;
    tester.pumpComponent(_head('', (c) => ctx = c));
    await tester.request('/');
    expect(ctx.breadcrumbItems, isEmpty);
  });

  testServer('PageHead handles a Thai path', (tester) async {
    late PageSeoContext ctx;
    tester.pumpComponent(
      _head('/th/tools', (c) => ctx = c, languageCode: 'th'),
    );
    final response = await tester.request('/');

    expect(ctx.url, 'https://nonthawit.com/th/tools');
    expect(ctx.alternateLanguageUrls.map((t) => '${t.locale}=${t.url}'), [
      'th=https://nonthawit.com/th/tools',
      'en=https://nonthawit.com/en/tools',
      'x-default=https://nonthawit.com/th/tools',
    ]);
    expect(ctx.breadcrumbItems.map((b) => b.url), [
      'https://nonthawit.com/th',
      'https://nonthawit.com/th/tools',
    ]);
    expect(response.body, contains('lang="th"'));
  });

  testServer('PageHead keeps a path without a locale segment', (tester) async {
    late PageSeoContext ctx;
    tester.pumpComponent(_head('/policies/abc', (c) => ctx = c));
    await tester.request('/');

    expect(ctx.alternateLanguageUrls.map((t) => '${t.locale}=${t.url}'), [
      'th=https://nonthawit.com/policies/abc',
      'en=https://nonthawit.com/policies/abc',
      'x-default=https://nonthawit.com/policies/abc',
    ]);
    // Mirrors page_state.dart:154-215: no segment is skipped, URLs get the
    // page language prefix.
    expect(ctx.breadcrumbItems.map((b) => b.url), [
      'https://nonthawit.com/en',
      'https://nonthawit.com/en/policies',
      'https://nonthawit.com/en/policies/abc',
    ]);
    expect(ctx.breadcrumbItems.map((b) => b.name), [
      'Nonthawit',
      'policies',
      'abc',
    ]);
  });

  testServer('PageHead drops the query and fragment from every URL', (
    tester,
  ) async {
    late PageSeoContext ctx;
    tester.pumpComponent(_head('/th/blogs/a?fbclid=x#top', (c) => ctx = c));
    await tester.request('/');

    expect(ctx.url, 'https://nonthawit.com/th/blogs/a');
    expect(ctx.canonical, 'https://nonthawit.com/th/blogs/a');
    expect(ctx.alternateLanguageUrls.map((t) => '${t.locale}=${t.url}'), [
      'th=https://nonthawit.com/th/blogs/a',
      'en=https://nonthawit.com/en/blogs/a',
      'x-default=https://nonthawit.com/th/blogs/a',
    ]);
    expect(ctx.breadcrumbItems.last.url, 'https://nonthawit.com/en/blogs/a');
  });

  testServer('PageHead points x-default at defaultLanguageCode', (
    tester,
  ) async {
    late PageSeoContext ctx;
    tester.pumpComponent(
      _head('/en/projects/42', (c) => ctx = c, defaultLanguageCode: 'th'),
    );
    await tester.request('/');

    final alternates = {
      for (final t in ctx.alternateLanguageUrls) t.locale: t.url,
    };
    expect(alternates['x-default'], 'https://nonthawit.com/th/projects/42');
    expect(alternates['en'], 'https://nonthawit.com/en/projects/42');
    expect(ctx.canonical, 'https://nonthawit.com/en/projects/42');
  });
}
