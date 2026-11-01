import 'package:jaspr_falkit/lib.dart';

/// Route-derived SEO context passed to the `seo` builder of [PageHead].
///
/// Holds the fields computed from the route; everything else (favicon,
/// publisher, imageUrl, siteName, ...) belongs to the app's SEO defaults.
class PageSeoContext {
  const PageSeoContext({
    required this.url,
    required this.canonical,
    required this.alternateLanguageUrls,
    required this.breadcrumbItems,
  });

  final String url;
  final String canonical;
  final List<AlternateLanguageTag> alternateLanguageUrls;
  final List<BreadcrumbItem> breadcrumbItems;
}

/// Emits `<html lang>` and the per-page SEO tags into `<head>`.
///
/// Server-only: `Document.head` is a zero-box directive that must not run
/// during client hydration. Theme classes belong to `ThemeBootScript`.
class PageHead extends StatelessComponent {
  const PageHead({
    required this.languageCode,
    required this.supportedLanguageCodes,
    required this.siteUrl,
    required this.path,
    required this.seo,
    required this.rootBreadcrumbName,
    this.breadcrumbName,
    this.defaultLanguageCode,
    super.key,
  });

  /// Language of the page, set as `<html lang>` and used in breadcrumb URLs.
  final String languageCode;

  /// Language codes that get an `hreflang` alternate link.
  final List<String> supportedLanguageCodes;

  /// Origin without trailing slash, for example `https://nonthawit.com`.
  final String siteUrl;

  /// Route location starting with `/`, for example `/en/projects/42`.
  ///
  /// Any query or fragment is ignored: URLs use the path part only.
  final String path;

  /// Builds the SEO tags from the route-derived context.
  final SeoMetaTags Function(PageSeoContext seo) seo;

  /// Name of the first breadcrumb (the site root).
  final String rootBreadcrumbName;

  /// Display name for a path segment. Falls back to the segment itself when
  /// this is null or returns null.
  final String? Function(String segment)? breadcrumbName;

  /// Language whose URL `x-default` points at. Null keeps the current page.
  final String? defaultLanguageCode;

  @override
  Component build(BuildContext context) {
    final full = '$siteUrl${Uri.parse(path).path}';
    final ctx = PageSeoContext(
      url: full,
      canonical: full,
      alternateLanguageUrls: _alternateLanguageUrls(full),
      breadcrumbItems: _breadcrumbs(),
    );
    return Component.fragment([
      Document.html(attributes: {'lang': languageCode}),
      Document.head(children: [seo(ctx)]),
    ]);
  }

  List<AlternateLanguageTag> _alternateLanguageUrls(String full) => [
    for (final code in supportedLanguageCodes)
      AlternateLanguageTag(
        locale: code,
        url: _replaceFirstPathSegment(full, locale: code),
      ),
    AlternateLanguageTag(
      locale: 'x-default',
      url: defaultLanguageCode == null
          ? full
          : _replaceFirstPathSegment(full, locale: defaultLanguageCode!),
    ),
  ];

  String _replaceFirstPathSegment(String url, {required String locale}) {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments.toList();
    if (segments.isNotEmpty && segments[0].length == 2) {
      segments[0] = locale;
    }
    return uri.replace(pathSegments: segments).toString();
  }

  List<BreadcrumbItem> _breadcrumbs() {
    final segments = Uri.parse(path).pathSegments
        .where((seg) => seg.isNotEmpty)
        .toList();
    if (segments.isEmpty) {
      return [];
    }

    final pathSegments = segments[0].length == 2
        ? segments.skip(1).toList()
        : segments;

    return [
      BreadcrumbItem(name: rootBreadcrumbName, url: '$siteUrl/$languageCode'),
      for (var i = 0; i < pathSegments.length; i++)
        BreadcrumbItem(
          name: breadcrumbName?.call(pathSegments[i]) ?? pathSegments[i],
          url:
              '$siteUrl/${[languageCode, ...pathSegments.take(i + 1)].join('/')}',
        ),
    ];
  }
}
