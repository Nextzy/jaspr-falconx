# jaspr-falconx

Dart packages for building Jaspr web apps: shared utilities, models, HTTP and WebSocket clients, SEO and theme components, browser storage, monitoring, and server middleware. They need Dart 3.13 or newer.

## Packages

- `jaspr_falconx`: umbrella package. It re-exports every package below except `jaspr_falserver`, and adds the server-data, locale, and domain helpers.
- `jaspr_faltool`: logging, build config, formatters, and the `dart_faltool` extensions.
- `jaspr_falmodel`: component state, `Result`, and the `dart_falmodel` exceptions.
- `jaspr_falconnect`: HTTP, WebSocket, and JSON-RPC clients built on `dart_falconnect`.
- `jaspr_falkit`: SEO head, Schema.org JSON-LD, theme boot script, and speculation rules.
- `jaspr_falstore`: browser key-value storage.
- `jaspr_falmonitor`: Sentry and Umami integration.
- `jaspr_falserver`: server-only shelf middleware and asset versioning. It imports `dart:io` and `package:jaspr/server.dart`, so the `jaspr_falconx` barrel does not re-export it. List it on its own and import it only from server code.

The packages depend on each other, and `jaspr_falconx` lists all of them except `jaspr_falserver`. List the umbrella for a typical app, or list single packages when you want a smaller surface.

## Add a dependency

The packages are not on pub.dev. Add them as git dependencies in `pubspec.yaml`:

```yaml
dependencies:
  jaspr_falconx:                     # or one package from the list above
    git:
      url: https://github.com/Nextzy/jaspr-falconx
      ref: <version>                 # the release tag you want
      path: jaspr_falconx            # jaspr_faltool, jaspr_falserver, ...
environment:
  sdk: ">=3.13.0 <4.0.0"
```

Copy the `url` exactly and use the same `url` and `ref` for every package you list. Then run:

```sh
dart pub get
```

### When you list more than one package

Inside this repository, packages name their siblings with `path: ../<package>`. Pub resolves those paths at the commit your `ref:` points to, not at the tag name. What you write as `ref:` therefore depends on what you list:

- One package, or `jaspr_falconx` alone: the release tag is enough.
- Several packages where none depends on another one you list, such as `jaspr_falconx` with `jaspr_falserver`: the tag works.
- Several packages where one depends on another one you list, such as `jaspr_falconnect` with `jaspr_falmodel`: a tag fails version solving. Use the tag's full 40-character commit hash as `ref:` for every listed package. A short hash fails too.

Read the hash with:

```sh
git ls-remote --tags https://github.com/Nextzy/jaspr-falconx 'refs/tags/<version>' 'refs/tags/<version>^{}'
```

For an annotated tag this prints two lines. Take the hash on the `^{}` line; the other line is the tag object, which fails. A lightweight tag prints one line, and that hash is the commit.

## Agent skills

Each package ships agent skills that tell a coding agent which package to use and how to call it. They install with the Dart [`skills`](https://pub.dev/packages/skills) CLI. The CLI scans only the packages your `pubspec.yaml` lists directly, so you get the skills of the packages you list. If your app lists `jaspr` directly, `get` also installs the skills that `jaspr` ships.

Run this from your project:

```sh
dart run skills@ get
```

Add `--all` to install every skill without prompting.

A skill you copied by hand into `.claude/skills/` is replaced only if your app lists the package that ships that name and you install for Claude; otherwise delete the copy first, then run `get`.

| Package you list   | Skills you get |
|--------------------|----------------|
| `jaspr_falconx`    | `jaspr-falconx-package`, `jaspr-falconx-faltool-utils`, `jaspr-falconx-falmodel-state`, `jaspr-falconx-falconnect-network`, `jaspr-falconx-falkit-components`, `jaspr-falconx-falstore-storage`, `jaspr-falconx-falmonitor-monitoring`, `jaspr-falconx-dart-faltool-utils`, `jaspr-falconx-dart-falmodel-models`, `jaspr-falconx-dart-falconnect-network` |
| `jaspr_faltool`    | `jaspr-faltool-utils`, `jaspr-faltool-dart-faltool-utils` |
| `jaspr_falmodel`   | `jaspr-falmodel-state`, `jaspr-falmodel-dart-falmodel-models` |
| `jaspr_falconnect` | `jaspr-falconnect-network`, `jaspr-falconnect-dart-falconnect-network`, `jaspr-falconnect-falmodel-state`, `jaspr-falconnect-dart-falmodel-models` |
| `jaspr_falkit`     | `jaspr-falkit-components`, `jaspr-falkit-falmodel-state`, `jaspr-falkit-dart-falmodel-models` |
| `jaspr_falstore`   | `jaspr-falstore-storage` |
| `jaspr_falmonitor` | `jaspr-falmonitor-monitoring` |
| `jaspr_falserver`  | `jaspr-falserver-middleware` |

The `jaspr_falconx` skills include generated copies of the skills of every package it re-exports, because the CLI does not follow transitive dependencies. `jaspr_falkit` and the packages that wrap a `dart_fal*` package carry copies of the skills for what their barrels re-export. `jaspr-falconx-package` tells the agent which package to list and how to set up the dependency.
