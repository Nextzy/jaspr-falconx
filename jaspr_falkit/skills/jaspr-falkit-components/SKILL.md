---
name: jaspr-falkit-components
description: Use when calling `jaspr_falkit` APIs such as `PageHead` with `PageSeoContext`, `SeoDefaults`, `SeoMetaTags`, the default, OpenGraph, Twitter, Apple, Microsoft, Pinterest, and alternate-language meta components, Schema.org JSON-LD schemas built with their factories and the `WebSchemaHelper` and `PersonSchemaHelper` helpers, `ThemeBootScript` with `setThemePreference`, `SpeculationRules`, or `NavigationProgress`, or before writing page-head meta tags, JSON-LD structured data, a theme boot script, a prefetch script, or a page-load progress bar of your own, since jaspr_falkit also re-exports jaspr_falmodel.
---

# jaspr_falkit components

Answers "does jaspr_falkit already provide this?" here and routes "how do I call it?" to one file under `references/`. `package: jaspr_falkit`; its barrel also re-exports `jaspr_falmodel` (and through it `dart_falmodel`), so `ThemeMode`, `ComponentState`, `Locale`, and `Result` come with it. See the skill shipped for `jaspr_falmodel` (installed with this package) for those types. The barrel does not re-export `jaspr` itself (`Component`, `Document`, `@client`).

Everything here renders on the server. The one browser API is `setThemePreference`, which a `@client` island calls.

## Capability map

| Need | Use | Ref |
|---|---|---|
| `<html lang>`, canonical URL, `hreflang` alternates, and breadcrumbs derived from the route | `PageHead`, `PageSeoContext` | `references/page-head.md` |
| Site-wide SEO defaults (favicon, brand, image, Twitter, Organization) | `SeoDefaults` (an `InheritedComponent`), `SeoDefaults.of` | `references/page-head.md` |
| Every meta tag plus the JSON-LD group for one page | `SeoMetaTags` | `references/page-head.md` |
| Title, description, keywords, robots, canonical, icons, manifest | `DefaultMeta` | `references/meta-tags.md` |
| OpenGraph and article OpenGraph | `DefaultOpenGraphMeta`, `ArticleOpenGraphMeta`, `OgType` | `references/meta-tags.md` |
| Twitter card, Apple web app, Microsoft tile, Pinterest | `TwitterMeta`, `AppleMeta`, `MicrosoftMeta`, `PinterestMeta` | `references/meta-tags.md` |
| `hreflang` links | `AlternateLanguageMeta`, `AlternateLanguageTag` | `references/meta-tags.md` |
| One `<meta>` or `<link>` that a later head can replace | `Meta`, `LinkHeader` | `references/meta-tags.md` |
| JSON-LD base, `@graph` group, untyped schema | `Schema`, `SchemaGroup` (`websiteWithOrganization`, `articleWithBreadcrumb`, `blogWithPosts`), `GenericSchema` | `references/schema.md` |
| Schema field values | `SchemaDataType`, `SchemaListDataType`, the `toSchemaDataType()` extensions | `references/schema.md` |
| Typed schemas with named factories | `WebSiteSchema`, `WebPageSchema`, `OrganizationSchema`, `EducationalOrganizationSchema`, `PersonSchema`, `ArticleSchema`, `BlogSchema`, `BlogPostingSchema`, `BreadcrumbListSchema` with `BreadcrumbItem`, `ImageSchema`, `PlaceSchema` with `OpeningHours`, `PostalAddressSchema`, `ContactPointSchema`, `SoftwareApplicationSchema`, `WebApplicationSchema` | `references/schema.md` |
| Page and person schemas from a few fields | `WebSchemaHelper`, `PersonSchemaHelper` | `references/schema.md` |
| Light, dark, or system theme painted before first paint | `ThemeBootScript`, `themeStorageKey`, `nextThemeMode`, `setThemePreference` | `references/theme.md` |
| Prefetch same-origin links | `SpeculationRules`, `speculationRulesJson` | `references/navigation.md` |
| Progress bar while a clicked link loads | `NavigationProgress` | `references/navigation.md` |
| `ThemeMode`, `ComponentState`, `Locale` | the re-exported `jaspr_falmodel` API | the skill shipped for `jaspr_falmodel` |

## Do not reinvent

- Before writing head tags, JSON-LD, a theme script, a speculation-rules script, or a progress bar, scan the map above.
- When this package's barrel is imported, do not also import `jaspr_falmodel` or `dart_falmodel`; their symbols are already in scope.
- Build schemas with the named factories (`OrganizationSchema.corporation`, `ArticleSchema.blogPost`, ...) and the helper classes (`WebSchemaHelper`, `PersonSchemaHelper`) rather than raw `schemaData` maps. Use `GenericSchema` only for a type the package lacks.
- Give a page its tags through `PageHead` and `SeoMetaTags`, and put values shared by every page in one `SeoDefaults` above them.
- Do not write your own inline script that reads localStorage and sets the theme class; use `ThemeBootScript`.

## Gotchas

- Render `PageHead`, `SeoMetaTags`, the meta components, schemas, `ThemeBootScript`, `SpeculationRules`, and `NavigationProgress` in the server-rendered tree, never inside a `@client` island. `PageHead` writes through `Document.head`, which must not run during client hydration.
- `setThemePreference` belongs in a `@client` island and needs `ThemeBootScript` in the document head. On the server it does nothing; in the browser it throws a `StateError` when the boot script is missing. See `references/theme.md`.
- `ThemeBootScript`, `SpeculationRules`, `Meta`, `LinkHeader`, and the schemas do not wrap themselves in `Document.head`; put them inside one. The other meta components and `SeoMetaTags` add their own `Document.head`.
- `<title>` is written as raw HTML, while meta `content` attributes are escaped. Strip `<` from an untrusted title. JSON-LD strings are not escaped either, so keep untrusted text containing `</script` out of schema fields.
- `SeoMetaTags` rebuilds `schemaWebSite` and `schemaBlogPosting` from a fixed list of fields, so `potentialAction` (the search box), `sameAs`, and other fields you set are dropped. It renders `schemaBlogPosting` only when `type` (or `openGraph.type`) is `OgType.article`. See `references/page-head.md`.
- `SeoMetaTags` always emits `msvalidate.01` with the placeholder `verification_token`, and a `MicrosoftMeta` placed beside `PageHead` does not replace it. It also always adds `AppleMeta`'s inline script, which loads a splash library from `unpkg.com` on iOS.
- A `script-src` Content-Security-Policy must allow the inline scripts of `ThemeBootScript`, `NavigationProgress`, `SpeculationRules`, and `AppleMeta` (by hash), and `unpkg.com` for `AppleMeta`.
- `someSchema.toSchemaDataType()` returns `SchemaDataType<Schema>`, which does not compile where a parameter expects `SchemaDataType<OrganizationSchema>`. Write `SchemaDataType(schema: someSchema)`. On strings and maps, `toSchemaDataType()` infers the type and is fine.
- These throw `JsonUnsupportedObjectError` when the page renders: `SchemaListDataType(schemaList: ...)` and `BlogSchema` with `dateCreated` or `dateModified`. Inside `SchemaGroup`, a schema built from a `const` map throws `UnsupportedError`. See `references/schema.md`.
- `LinkHeader` defaults to `unique: true` with an `id` hashed from `id`, `rel`, `type`, `as`, and `attributes`, not `href`. Two preload links that differ only in `href` collapse to the last one; pass `unique: false` or distinct `id`s.
- `PageHead` treats the first path segment as a language code only when it is exactly two characters (`/en/...`). A path such as `/zh-TW/...` gets no language swap in its alternates.
- Code that reaches the browser (`@client` islands and anything they import) never imports `dart:io`, `package:jaspr/server.dart`, or `jaspr_falserver`. Server code may use `dart:io`.
- Listing `jaspr_falstore` (for `KeyValueStorage`) beside `jaspr_falkit`, which depends on it, as git dependencies fails `dart pub get` at a tag `ref:`. Use the tag's full 40-character commit hash as `ref:` for every listed `jaspr_fal*` package; see the "When you list more than one package" section of the `jaspr-falconx` README. An app that lists `jaspr_falconx` already has `jaspr_falstore`.
- Write constructors with the type name (`const Foo(...)`, `Foo._()`), never `new(...)`: consuming apps run jaspr_builder 0.23.5, which rejects primary constructors.

## Out of scope

`ThemeMode`, `ComponentState`, `Locale`, and the `dart_falmodel` types (see the skill shipped for `jaspr_falmodel`), localStorage access (`jaspr_falstore`), server middleware, sitemaps, and response headers, and package internals.
