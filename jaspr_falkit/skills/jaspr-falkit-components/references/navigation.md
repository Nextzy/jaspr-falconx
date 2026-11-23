# Navigation

`package: jaspr_falkit`: `SpeculationRules`, `speculationRulesJson`, and `NavigationProgress`. Both components are plain server-rendered HTML and script; they need no island and no Jaspr client runtime.

## `SpeculationRules`

Renders `<script type="speculationrules">` so supporting browsers prefetch same-origin links before the visitor clicks. Browsers without the Speculation Rules API ignore it. It does not wrap itself in `Document.head`; place it in one or in the body.

| Parameter | Default | Meaning |
|---|---|---|
| `eagerness` | `'moderate'` | written as is; the API accepts `immediate`, `eager`, `moderate`, and `conservative` |
| `excludePrefixes` | `const ['/_v/']` | paths that start with any prefix are never prefetched |

`speculationRulesJson({required String eagerness, required List<String> excludePrefixes})` returns the same document as a map: one `prefetch` rule with `source: document`, matching `/*` and, for each prefix, `not href_matches '<prefix>*'`. The component encodes it with `<` escaped as `\u003c`.

```dart
Component prefetchHead() => Document.head(
  children: const [
    SpeculationRules(excludePrefixes: ['/_v/', '/logout', '/cart/']),
  ],
);
```

- Passing `excludePrefixes` replaces the default list, so keep `'/_v/'` (versioned asset paths) when you add your own.
- A prefetch is a real `GET`. Exclude every link whose `GET` changes state, such as logout or add-to-cart links.

## `NavigationProgress`

Renders `<div id="fal-nav-progress" aria-hidden="true">`, its `<style>`, and an inline `<script>`: a thin bar fixed to the top of the page while a full page load started by a link click takes longer than `showDelay`. Put it once in the body of the layout, outside islands.

| Parameter | Default | Meaning |
|---|---|---|
| `color` | `'currentColor'` | CSS color of the bar and its glow |
| `height` | `'3px'` | CSS height |
| `showDelay` | 150 ms | how long a navigation runs before the bar shows |
| `zIndex` | `9999` | CSS `z-index` |
| `glow` | `false` | adds a `box-shadow` in `color` |

A click starts the bar only when it is a primary-button click without modifier keys on a same-origin `a[href]` that is not `defaultPrevented`, has no `download`, has no target other than `_self`, and leaves the current path and query (a hash-only change does not count). The bar creeps toward 85%. It resets on `pagehide` and on a `pageshow` from the back/forward cache, and gives up after 10 seconds. With `prefers-reduced-motion: reduce` it does not creep.

```dart
class AppBody extends StatelessComponent {
  const AppBody({required this.child, super.key});

  final Component child;

  @override
  Component build(BuildContext context) => Component.fragment([
    const NavigationProgress(
      color: '#2f6fed',
      showDelay: Duration(milliseconds: 200),
    ),
    child,
  ]);
}
```

## Gotchas

- `NavigationProgress` uses the fixed id `fal-nav-progress`; render it once per page.
- Links handled by a client-side router that calls `preventDefault` do not start the bar, because only full page loads are tracked.
- `color` and `height` lose any `<`, `>`, `{`, `}`, `;`, `\`, or `@`; pass a plain CSS color or length.
- A `script-src` or `style-src` Content-Security-Policy must allow the inline script and style of `NavigationProgress` and the inline speculation rules, for example by hash.
