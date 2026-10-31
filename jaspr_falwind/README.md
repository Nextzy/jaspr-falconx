# 🌬️ TailwindCSS v4 + DaisyUI v5 Integration for Jaspr

[TailwindCSS](https://tailwindcss.com/) is a utility-first CSS framework to rapidly build modern websites, and [DaisyUI](https://daisyui.com/) provides component classes for Tailwind.

This package is a first-class Tailwind integration for [Jaspr](https://github.com/schultek/jaspr), specifically supporting **TailwindCSS v4** and **DaisyUI v5**.

---

## 🔧 Prerequisites

Install the Tailwind CSS v4 CLI and daisyUI v5 with npm in your project root
(recommended):

```sh
npm i -D tailwindcss @tailwindcss/cli daisyui
```

The builder uses `node_modules/.bin/tailwindcss` from your package
(`tailwindcss.cmd` on Windows). Without it, the builder falls back to a
standalone `tailwindcss` v4 binary on your PATH:

```sh
curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-<your-platform>
chmod +x tailwindcss-<your-platform>
mv tailwindcss-<your-platform> /usr/local/bin/tailwindcss
```

Use the npm route when the stylesheet loads `@plugin "daisyui";`: Tailwind
resolves plugins from `node_modules`.

---

## 📦 Setup

1. Add `jaspr_falwind` as a dev dependency.

2. Create a `styles.tw.css` file in your `web/` directory:

```css
@import "tailwindcss";
@plugin "daisyui";
```

Tailwind scans your package for class names from the package root. Relative
`@import` and `@source` paths resolve from the stylesheet's own folder.

### Options

Set options in your project's `build.yaml`:

```yaml
targets:
  $default:
    builders:
      jaspr_falwind:compiler:
        options:
          cli: npx
```

- `cli`: `npx` runs `@tailwindcss/cli` through npx, `standalone` uses
  `tailwindcss` from your PATH, and any other value is the path of a Tailwind
  CLI.
- `tailwindcss`: extra CLI flags, separated by spaces. Release builds pass
  `--minify` by default.

The build fails with a message when no CLI is found, the CLI is Tailwind v3, the
stylesheet uses v3 `@tailwind` directives, the CLI exits with an error, or the
output has no CSS rules.

---

## 🖇️ Link Styles in Your App

### In **static** or **server** mode:

```dart
import 'package:jaspr/server.dart';
import './app.dart';

void main() {
  runApp(Document(
    title: 'My Tailwind Site',
    head: [
      link(href: 'styles.css', rel: 'stylesheet'),
    ],
    body: App(),
  ));
}
```

### In **client** mode:

```html
<!-- web/index.html -->
<html>
  <head>
    <link href="styles.css" rel="stylesheet" />
  </head>
</html>
```

All `.tw.css` files in the `web/` directory will be compiled into corresponding `.css` files.

---

## 🧪 Usage

Use Tailwind and DaisyUI classes directly in Jaspr components:

```dart
import 'package:jaspr/jaspr.dart';

class SimpleCard extends StatelessComponent {
  const SimpleCard({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(classes: 'card bg-base-100 shadow-xl p-4', [
      div(classes: 'card-title text-xl font-bold', [text(title)]),
      div(classes: 'text-content', [text(message)]),
    ]);
  }
}
```

---

## ⚙️ Configuration (Optional)

Tailwind CSS v4 is configured in CSS. Use
[`@theme`](https://tailwindcss.com/docs/theme) for colors and fonts, and
daisyUI's `@plugin "daisyui/theme"` for themes. A legacy `tailwind.config.js`
is read only when the stylesheet loads it with `@config "../tailwind.config.js";`;
the build warns when it finds one that is not loaded.

The CSS is rebuilt when a Dart file in `lib/` or `web/`, a CSS file in `web/`,
or a file in `content/` changes. build_runner sees `content/` only when the
package's `sources` in `build.yaml` include `content/**`.
