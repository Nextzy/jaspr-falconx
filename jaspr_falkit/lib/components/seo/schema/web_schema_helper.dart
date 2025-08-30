import 'package:jaspr_falkit/lib.dart';
import 'package:jaspr_falkit/components/seo/schema/web_page.dart';
import 'package:jaspr_falkit/components/seo/schema/website.dart';

/// Helper class for creating WebSite and WebPage schemas with common patterns
class WebSchemaHelper {
  /// Creates a complete website schema with search functionality
  static WebSiteSchema createWebSite({
    required String name,
    required String url,
    String? description,
    String? searchUrlTemplate,
    Map<String, String>? publisher,
    List<String>? socialProfiles,
    String? inLanguage,
  }) {
    if (searchUrlTemplate != null) {
      return WebSiteSchema.withSearch(
        name: name,
        url: url,
        searchUrlTemplate: searchUrlTemplate,
        description: description,
        inLanguage: inLanguage ?? 'en',
        publisher: publisher,
        sameAs: socialProfiles,
      );
    }
    
    return WebSiteSchema.custom(
      name: name,
      url: url,
      description: description,
      inLanguage: inLanguage ?? 'en',
      publisher: publisher,
      sameAs: socialProfiles,
    );
  }

  /// Creates a homepage schema
  static WebPageSchema createHomePage({
    required String name,
    required String url,
    String? description,
    Map<String, dynamic>? organization,
    List<String>? socialProfiles,
  }) {
    return WebPageSchema.enhanced(
      name: name,
      url: url,
      description: description,
      publisher: organization,
      potentialAction: [
        {
          '@type': 'ReadAction',
          'target': url,
        },
      ],
    );
  }

  /// Creates an article page schema
  static WebPageSchema createArticlePage({
    required String headline,
    required String url,
    required String authorName,
    required String datePublished,
    String? description,
    String? dateModified,
    String? publisherName,
    String? publisherLogo,
    String? primaryImageUrl,
    List<String>? keywords,
    Map<String, dynamic>? breadcrumb,
  }) {
    return WebPageSchema.article(
      headline: headline,
      url: url,
      datePublished: datePublished,
      author: WebPageSchema.createAuthor(name: authorName),
      description: description,
      dateModified: dateModified ?? datePublished,
      publisher: publisherName != null
          ? WebPageSchema.createPublisher(
              name: publisherName,
              logo: publisherLogo,
            )
          : null,
      primaryImageOfPage: primaryImageUrl,
      keywords: keywords,
      breadcrumb: breadcrumb,
    );
  }

  /// Creates a product page schema
  static WebPageSchema createProductPage({
    required String name,
    required String url,
    required Map<String, dynamic> product,
    String? description,
    String? primaryImageUrl,
    Map<String, dynamic>? breadcrumb,
    Map<String, dynamic>? publisher,
  }) {
    return WebPageSchema.enhanced(
      name: name,
      url: url,
      description: description,
      primaryImageOfPage: primaryImageUrl,
      mainEntity: product,
      breadcrumb: breadcrumb,
      publisher: publisher,
    );
  }

  /// Creates a contact page schema
  static WebPageSchema createContactPage({
    required String url,
    Map<String, dynamic>? organization,
    Map<String, dynamic>? contactPoint,
  }) {
    return WebPageSchema.enhanced(
      name: 'Contact Us',
      url: url,
      description: 'Contact information and support',
      mainEntity: organization,
      potentialAction: contactPoint != null
          ? [
              {
                '@type': 'CommunicateAction',
                'recipient': contactPoint,
              },
            ]
          : null,
    );
  }

  /// Creates an FAQ page schema
  static WebPageSchema createFAQPage({
    required String name,
    required String url,
    required List<Map<String, String>> faqs,
    String? description,
  }) {
    return WebPageSchema.enhanced(
      name: name,
      url: url,
      description: description,
      mainEntity: {
        '@type': 'FAQPage',
        'mainEntity': faqs
            .map((faq) => {
                  '@type': 'Question',
                  'name': faq['question'],
                  'acceptedAnswer': {
                    '@type': 'Answer',
                    'text': faq['answer'],
                  },
                })
            .toList(),
      },
    );
  }

  /// Creates a search results page schema
  static WebPageSchema createSearchResultsPage({
    required String url,
    required String searchQuery,
    int? resultCount,
  }) {
    return WebPageSchema.enhanced(
      name: 'Search Results for: $searchQuery',
      url: url,
      description: 'Search results for $searchQuery',
      potentialAction: [
        {
          '@type': 'SearchAction',
          'query': searchQuery,
          if (resultCount != null) 'result': '$resultCount results found',
        },
      ],
    );
  }

  /// Creates breadcrumb structure for navigation
  static Map<String, dynamic> createBreadcrumb(List<BreadcrumbItem> items) {
    return {
      '@type': 'BreadcrumbList',
      'itemListElement': items
          .asMap()
          .entries
          .map((entry) => {
                '@type': 'ListItem',
                'position': entry.key + 1,
                'name': entry.value.name,
                'item': entry.value.url,
              })
          .toList(),
    };
  }

  /// Creates accessibility properties
  static Map<String, dynamic> createAccessibilityProps({
    List<String>? features,
    List<String>? hazards,
    String? summary,
  }) {
    final props = <String, dynamic>{};
    if (features != null && features.isNotEmpty) {
      props['accessibilityFeature'] = features;
    }
    if (hazards != null && hazards.isNotEmpty) {
      props['accessibilityHazard'] = hazards;
    }
    if (summary != null) {
      props['accessibilitySummary'] = summary;
    }
    return props;
  }

  /// Common accessibility features
  static const String alternativeText = 'alternativeText';
  static const String audioDescription = 'audioDescription';
  static const String captions = 'captions';
  static const String describedMath = 'describedMath';
  static const String highContrastDisplay = 'highContrastDisplay';
  static const String largePrint = 'largePrint';
  static const String longDescription = 'longDescription';
  static const String readingOrder = 'readingOrder';
  static const String signLanguage = 'signLanguage';
  static const String structuralNavigation = 'structuralNavigation';
  static const String tableOfContents = 'tableOfContents';
  static const String taggedPDF = 'taggedPDF';
  static const String textToSpeech = 'textToSpeech';
  static const String transcript = 'transcript';

  /// Common accessibility hazards
  static const String noFlashingHazard = 'noFlashingHazard';
  static const String noMotionSimulationHazard = 'noMotionSimulationHazard';
  static const String noSoundHazard = 'noSoundHazard';
  static const String unknownFlashingHazard = 'unknownFlashingHazard';
  static const String flashingHazard = 'flashingHazard';
  static const String motionSimulationHazard = 'motionSimulationHazard';
  static const String soundHazard = 'soundHazard';
}
