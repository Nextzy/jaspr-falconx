# Schema.org JSON-LD

`package: jaspr_falkit`. Every schema is a `Schema`, a `StatelessComponent` that renders `<script type="application/ld+json">` with its `schemaData` map (top-level `null` values removed). Place a schema inside `Document.head`, or hand it to `SeoMetaTags` / `SeoDefaults` (see `references/page-head.md`), which group it with the page's other schemas.

Build schemas with the named factories and the helper classes below. The main constructors take every schema.org field the class supports (all optional unless listed), plus `additionalProperties`, a map spread last into `schemaData` that can add or override any key, `@type` included. Use `GenericSchema(data: {...})` only for a type the package lacks.

## Field values: `SchemaDataType`

A field that can hold text, a map, or another schema takes `SchemaDataType<T>({String? str, Map<String, dynamic>? map, T? schema})`; its `value` is the schema's `schemaData`, else `str`, else `map`. List fields take `SchemaListDataType<T>({strList, mapList, schemaList})`.

| You have | Write |
|---|---|
| a string | `'Ada Lovelace'.toSchemaDataType()` |
| a map | `{'@type': 'Organization', 'name': 'Acme'}.toSchemaDataType()` |
| a schema | `SchemaDataType(schema: org)` |

The type argument of the string and map extensions is inferred from the parameter. `org.toSchemaDataType()` on a schema returns `SchemaDataType<Schema>`, which does not compile where `SchemaDataType<OrganizationSchema>` is expected.

```dart
OrganizationSchema acmeOrganization() => OrganizationSchema.corporation(
  name: 'Acme Co.',
  url: 'https://acme.example',
  logo: SchemaDataType(
    schema: ImageSchema.basic(url: 'https://acme.example/logo.png'),
  ),
  sameAs: const ['https://github.com/acme'],
);

PersonSchema acmeAuthor(OrganizationSchema org) =>
    PersonSchemaHelper.professional(
      givenName: 'Ada',
      familyName: 'Lovelace',
      jobTitle: 'Engineer',
      worksFor: SchemaDataType(schema: org),
    );

ArticleSchema launchPost() => ArticleSchema.blogPost(
  headline: 'Shipping islands',
  datePublished: '2026-11-01',
  author: 'Ada Lovelace'.toSchemaDataType(),
  url: 'https://acme.example/en/blog/islands',
);
```

## Groups and generic schemas

| API | Required | Output |
|---|---|---|
| `SchemaGroup({id, required List<Schema> schemas, context = 'https://schema.org'})` | `schemas` | one script with `@graph`; removes `@context` from each member's `schemaData` |
| `SchemaGroup.websiteWithOrganization` | `websiteName`, `websiteUrl`, `organizationName` | Organization (`#organization` id, optional `organizationUrl`, `organizationLogo`, `socialProfiles`) and WebSite (its `publisher`, optional `SearchAction` from `searchUrlTemplate`) |
| `SchemaGroup.articleWithBreadcrumb` | `headline`, `url`, `datePublished`, `author` (map), `breadcrumbItems` | BreadcrumbList and Article |
| `SchemaGroup.blogWithPosts` | `blogName`, `blogUrl`, `publisher` (map), `recentPosts` (maps, each with a `url`) | Blog plus one BlogPosting per post, linked by `#blog` and `#article` ids |
| `GenericSchema({required Map<String, dynamic> data})` | `data` | `data` as is |
| `Schema.createImageObject(String url)` | `url` | `{'@type': 'ImageObject', 'url': url}` |

```dart
Component siteSchemas() => SchemaGroup.websiteWithOrganization(
  websiteName: 'Acme',
  websiteUrl: 'https://acme.example',
  organizationName: 'Acme Co.',
  organizationLogo: 'https://acme.example/logo.png',
  searchUrlTemplate: 'https://acme.example/search?q={search_term_string}',
);
```

## Helper classes

`WebSchemaHelper` (all static):

| Method | Required | Returns |
|---|---|---|
| `createWebSite` | `name`, `url` | `WebSiteSchema`; `WebSiteSchema.withSearch` when `searchUrlTemplate` is set; `inLanguage` defaults to `'en'` |
| `createHomePage` | `name`, `url` | `WebPageSchema` with a `ReadAction`; `organization` becomes `publisher`; `socialProfiles` is ignored |
| `createArticlePage` | `headline`, `url`, `authorName`, `datePublished` | `WebPageSchema.article`; `dateModified` defaults to `datePublished` |
| `createProductPage` | `name`, `url`, `product` (map) | `WebPageSchema` with `product` as `mainEntity` |
| `createContactPage` | `url` | `WebPageSchema` named `Contact Us`; `contactPoint` becomes a `CommunicateAction` |
| `createFAQPage` | `name`, `url`, `faqs` (maps with `question` and `answer`) | `WebPageSchema` whose `mainEntity` is an `FAQPage` |
| `createSearchResultsPage` | `url`, `searchQuery` | `WebPageSchema` with English name and description |
| `createBreadcrumb(List<BreadcrumbItem>)` | the list | BreadcrumbList map with `item` as a bare URL |
| `createAccessibilityProps` | none | `accessibilityFeature`, `accessibilityHazard`, `accessibilitySummary` map |

It also holds string constants for accessibility features (`alternativeText`, `captions`, `transcript`, ...) and hazards (`noFlashingHazard`, `flashingHazard`, ...).

`PersonSchemaHelper` (all static):

| Method | Required | Returns |
|---|---|---|
| `basic` | `name` | `PersonSchema` |
| `professional` | `givenName`, `familyName` | `PersonSchema` with work fields |
| `author` | `name` | `PersonSchema` |
| `detailed` | `givenName`, `familyName` | `PersonSchema` with personal fields; `children` becomes `child` |
| `teamMember` | `name`, `jobTitle` | `PersonSchema` |
| `createAddress`, `createContactPoint` | none | PostalAddress or ContactPoint map |
| `createOrganization` | `name` | `{name, url, description}` with no `@type` |
| `createPersonReference` | `name` | `{name, url}` with no `@type` |
| `createSocialLinks` | none | the non-null URLs plus `others` |

```dart
Component faqSchema() => WebSchemaHelper.createFAQPage(
  name: 'FAQ',
  url: 'https://acme.example/en/faq',
  faqs: const [
    {'question': 'Do you ship abroad?', 'answer': 'Yes, to 40 countries.'},
  ],
);
```

## Typed schemas

Required parameters only; `@type` is in brackets when the class name does not say it.

| Class | Main constructor requires | Factories (required parameters) | Static helpers (required parameters) |
|---|---|---|---|
| `WebSiteSchema` | none | `withSearch` (`name`, `url`, `searchUrlTemplate`), `basic`, `blog`, `ecommerce`, `educational` (`name`, `url`) | `createSearchAction` (`searchUrlTemplate`), `createPublisher` (`name`), `createBreadcrumbList` (`items`), `createAccessibilityInfo`, `createAudience` (`audienceType`), `createAggregateRating` (`ratingValue`, `reviewCount`) |
| `WebPageSchema` | none | `basic` (`name`, `url`), `article` (`headline`, `url`, `datePublished`, `author`) | `createSpeakable`, `createVideo` (`name`, `description`, `thumbnailUrl`, `uploadDate`), `createEntity` (`type`, `name`) |
| `OrganizationSchema` | none | `corporation`, `nonProfit` (`name`, `url`) | `createContactPoint` (`telephone`, `contactType`), `createAddress` (all five address parts), `toMap` (`name`) |
| `EducationalOrganizationSchema` | `name` | `basic`, `university`, `school` (`name`, `url`) | `toMap`, `createAlumni`, `createOfferCatalog`, `createDepartment` (`name`) |
| `PersonSchema` | none | `basic`, `author`, `creative` (`name`); `teamMember` (`name`, `givenName`, `familyName`, `jobTitle`); `professional`, `executive` (those four plus `worksFor`) | `toMap` (`name`), `createSocialProfiles`, `createAlumniOf` (`name`) |
| `ArticleSchema` [`Article`] | none | `newsArticle` (`headline`, `datePublished`, `publisher`); `techArticle`, `blogPost` (`headline`, `datePublished`, `author`); `scholarlyArticle` (those plus `articleBody`) | `createAuthor`, `createPublisher` (`name`), `createVideo` (`name`, `description`, `thumbnailUrl`, `uploadDate`), `createAudio` (`name`, `description`, `contentUrl`), `createSpeakable`, `createCitation` (`name`, `author`) |
| `BlogSchema` | none | `personal` (`name`, `url`, `author`), `corporate` (`name`, `url`, `publisher`) | `createBlogPost` (`headline`, `url`), `createAggregateRating` (`ratingValue`, `reviewCount`), `createReview` (`reviewBody`, `author`, `ratingValue`) |
| `BlogPostingSchema` | none | `personal` (`headline`, `datePublished` as `DateTime`, `author`), `corporate` (those plus `publisher`) | `createAuthor` (`name`), `createBlogReference` (`url`), `createInteractionStatistic` (`interactionType`, `userInteractionCount`) |
| `BreadcrumbListSchema` | `items` (`List<BreadcrumbItem>`) | `fromStrings(List<String>)`, `withUrls(List<Map<String, String>>)` with `name` and `url` keys | none |
| `ImageSchema` [`ImageObject`] | `url` | `basic` (`url`); `thumbnail` (`url`; 150 by 150); `photo` (`url`, `name`); `hero` (`url`, `name`; `representativeOfPage` defaults to `true`) | `toMap` (`url`), `createExifData` |
| `PlaceSchema` | none | `basic` (`name`), `businessLocation`, `eventVenue` (`name`, `address`) | `toMap`, `createGeoCoordinates` (`latitude`, `longitude`), `createOpeningHoursSpecification` (`hours`) |
| `PostalAddressSchema` | none | `usAddress` (`streetAddress`, `addressLocality`, `addressRegion`, `postalCode`; country `US`), `international` (`streetAddress`, `addressLocality`, `addressCountry`), `simple` (`streetAddress`, `city`, `country`), `european` (`streetAddress`, `city`, `postalCode`, `country`) | `toMap`, `formatAddress`, `getCountryCode(String)` |
| `ContactPointSchema` | none | `sales`, `customerService`, `technicalSupport`, `billing`, `reservations`, `emergency` (`telephone`) | `toMap`, `createOpeningHours` (`dayOfWeek`, `opens`, `closes`), `create24x7Hours`, `createBusinessHours`, `createContactPointList`; constants `tollFree`, `hearingImpairedSupported`, `weekdays`, `weekend`, `allDays` |
| `SoftwareApplicationSchema` | `name` | `mobileApp`, `desktopApp` (`name`, `operatingSystem`) | `createOffer` (`price`, `priceCurrency`), `createAggregateRating` (`ratingValue`, `ratingCount`), `createReview` (`reviewBody`, `author`, `ratingValue`) |
| `WebApplicationSchema` | none | `saas` (`name`, `url`; category `BusinessApplication`), `pwa` (`name`, `url`) | none |

Helper value classes: `BreadcrumbItem({required String name, String? url})` and `OpeningHours({required List<String> dayOfWeek, required String opens, required String closes, String? validFrom, String? validThrough})`.

Older aliases still compile and mean the same class: `WebSiteSchemaData`, `WebsiteSchema`, `WebsiteSchemaOrg`, `OrganizationSchemaOrg`, `OrganizationSchemaData`, `ArticleSchemaOrg`, `ArticleSchemaData`, `SeoBlogSchema`, `ImageSchemaData`, `PlaceSchemaData`, `PostalAddressSchemaData`, `ContactPointSchemaData`, `SoftwareApplicationSchemaData`. Write the class names in new code.

## Gotchas

- `ArticleSchema`'s factories all write `@type: Article`. For `NewsArticle` or `TechArticle`, use the main constructor with `additionalProperties: {'@type': 'NewsArticle'}`.
- Some helper maps carry no `@type`: `SoftwareApplicationSchema.createOffer`, `createAggregateRating`, and `createReview`, `OrganizationSchema.createAddress`, and `PersonSchemaHelper.createOrganization` and `createPersonReference`. Add the `@type` yourself when schema.org needs it.
- `PersonSchema.createAlumniOf` accepts `degree`, `startDate`, and `endDate` but writes only `name` and `url`.
- `PostalAddressSchema.european` maps an English country name to its ISO code with `getCountryCode` and falls back to the name it was given; `simple` writes the country as given.
- `BreadcrumbListSchema` writes the URL and name inside an `item` `Thing` and puts `name` on the list item only when there is no URL. `WebSchemaHelper.createBreadcrumb` and `WebSiteSchema.createBreadcrumbList` build other shapes; `SeoMetaTags.breadcrumbItems` uses `BreadcrumbListSchema`.
