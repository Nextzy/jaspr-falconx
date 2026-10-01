import 'dart:io';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:scratch_space/scratch_space.dart';

/// Creates the [TailwindBuilder] that `build.yaml` registers.
Builder buildStylesheet(BuilderOptions options) => TailwindBuilder(options);

/// One scratch space per build, shared across build steps and deleted when the
/// build ends. Replaces `scratchSpaceResource` from the discontinued
/// `build_modules` package; Tailwind needs no `package_config.json` in it.
final _scratchSpaceResource = Resource<ScratchSpace>(
  ScratchSpace.new,
  dispose: (scratchSpace) => scratchSpace.delete(),
);

/// Builds CSS from `web/*.tw.css` entrypoints using Tailwind CSS v4 + daisyUI v5.
///
/// daisyUI v5 is configured entirely from CSS via `@plugin "daisyui";` in the
/// input file — there is no `tailwind.config.js`, no `daisyui.js` plugin file,
/// and no `daisyui-theme.js`. This builder therefore only needs to:
///   1. resolve which Tailwind CLI to invoke
///   2. ensure the input asset is in the scratch space
///   3. run the CLI
///   4. copy the generated CSS back as a build output
class TailwindBuilder implements Builder {
  /// Creates a builder configured by [options].
  new(this.options);

  /// Options from `build.yaml`.
  final BuilderOptions options;

  @override
  Future<void> build(BuildStep buildStep) async {
    final scratchSpace = await buildStep.fetchResource(_scratchSpaceResource);
    await scratchSpace.ensureAssets({buildStep.inputId}, buildStep);

    final outputId = buildStep.inputId.changeExtension('').changeExtension('.css');

    final (executable, leadingArgs) = _resolveTailwindCli(options);
    if (executable == null) {
      log.severe(
        'Tailwind CLI not found. Install one of:\n'
        '  • npm i -D tailwindcss @tailwindcss/cli daisyui   (recommended)\n'
        '  • the standalone `tailwindcss` binary on your PATH\n'
        'Or set `cli: <path>` in build.yaml options for jaspr_falwind:buildStylesheet.',
      );
      return;
    }

    // Trigger rebuilds when any Dart source changes (Tailwind scans these for class usage).
    final assets = await buildStep.findAssets(Glob('{lib,web}/**.dart')).toList();
    await Future.wait(assets.map((a) => buildStep.canRead(a)));

    final inputPath = scratchSpace.fileFor(buildStep.inputId).path;
    final outputPath = scratchSpace.fileFor(outputId).path;

    if (!File(inputPath).existsSync()) {
      log.severe('Input file does not exist in scratch space: $inputPath');
      return;
    }

    // Make `@plugin "daisyui"` (and any other bare-module @plugins) resolvable.
    // build_runner uses a hermetic scratch space that contains no node_modules,
    // so Tailwind v4's module resolution (which walks up from the CSS file's
    // directory) will fail with `Can't resolve 'daisyui'`. Symlink the
    // project's node_modules into the scratch root so resolution succeeds
    // without copying hundreds of megabytes.
    _bridgeNodeModulesIntoScratch(inputPath);

    final commandArgs = <String>[
      ...leadingArgs,
      '--input',
      inputPath.toPosix(),
      '--output',
      outputPath.toPosix(),
      if (options.config.containsKey('tailwindcss')) options.config['tailwindcss'] as String,
      '--cwd',
      Directory.current.path,
    ];

    log.info('Running: $executable ${commandArgs.join(' ')}');
    final result = await Process.run(executable, commandArgs, runInShell: true);

    if (result.exitCode != 0) {
      log
        ..severe('Tailwind CSS failed with exit code ${result.exitCode}')
        ..severe('stdout: ${result.stdout}')
        ..severe('stderr: ${result.stderr}');
      return;
    }

    final outputFile = File(outputPath);
    if (!outputFile.existsSync()) {
      log
        ..severe('Output file was not created: $outputPath')
        ..severe('Tailwind stdout: ${result.stdout}')
        ..severe('Tailwind stderr: ${result.stderr}');
      return;
    }

    if ((await outputFile.readAsString()).isEmpty) {
      log.warning('Output file is empty. Check your Tailwind input CSS and @source globs.');
    }

    await scratchSpace.copyOutput(outputId, buildStep);
    log.info('Successfully generated ${outputId.path}');
  }

  @override
  Map<String, List<String>> get buildExtensions => {
    'web/{{file}}.tw.css': ['web/{{file}}.css'],
  };
}

/// Resolves which Tailwind CLI to invoke.
///
/// Returns `(executable, leadingArgs)` where `leadingArgs` are prepended before
/// `--input` / `--output`. Returns `(null, [])` if no CLI can be located.
///
/// Strategy (in order):
///   1. Explicit `cli` option in build.yaml — accepts `npx`, `standalone`,
///      or an absolute path to a binary.
///   2. Local `node_modules/.bin/tailwindcss` (Tailwind v4 + daisyUI v5 — preferred,
///      because `@plugin "daisyui"` resolves through node_modules).
///   3. Standalone `tailwindcss` binary on PATH (legacy fallback).
(String?, List<String>) _resolveTailwindCli(BuilderOptions options) {
  final override = options.config['cli'] as String?;
  if (override != null) {
    switch (override) {
      case 'npx':
        return ('npx', ['--yes', '@tailwindcss/cli']);
      case 'standalone':
        return _which('tailwindcss') ? ('tailwindcss', <String>[]) : (null, <String>[]);
      default:
        return (override, <String>[]);
    }
  }

  final localBin = File(
    '${Directory.current.path}/node_modules/.bin/tailwindcss${Platform.isWindows ? '.cmd' : ''}',
  );
  if (localBin.existsSync()) {
    return (localBin.path, <String>[]);
  }

  if (_which('tailwindcss')) {
    return ('tailwindcss', <String>[]);
  }

  return (null, <String>[]);
}

/// Symlinks `<project>/node_modules` into the scratch space root so that
/// Tailwind v4's `@plugin "<bare-module>"` resolution succeeds.
///
/// The scratch space layout for an input at `web/styles.tw.css` looks like
/// `<scratch>/web/styles.tw.css`, so the symlink target is `<scratch>/node_modules`.
///
/// Skips silently if:
///   • the project has no `node_modules` (nothing to bridge)
///   • a node_modules entry already exists at the target (idempotent)
///   • symlink creation fails (e.g. Windows without dev mode) — logged as a
///     warning so users see why bare-module @plugins still fail.
void _bridgeNodeModulesIntoScratch(String inputPath) {
  final realNodeModules = Directory('${Directory.current.path}/node_modules');
  if (!realNodeModules.existsSync()) return;

  // <scratch>/web/styles.tw.css → parent.parent = <scratch>
  final scratchRoot = File(inputPath).parent.parent;
  final linkPath = '${scratchRoot.path}/node_modules';

  if (Link(linkPath).existsSync() || Directory(linkPath).existsSync()) return;

  try {
    Link(linkPath).createSync(realNodeModules.absolute.path);
  } on Object catch (e) {
    log.warning(
      'jaspr_falwind: failed to symlink node_modules into scratch space '
      '($linkPath -> ${realNodeModules.absolute.path}): $e\n'
      'Bare-module `@plugin "<name>"` directives will fail to resolve. '
      'On Windows, enable Developer Mode or run as Administrator.',
    );
  }
}

bool _which(String binary) {
  final result = Process.runSync(
    Platform.isWindows ? 'where' : 'which',
    [binary],
    runInShell: true,
  );
  return result.exitCode == 0;
}

/// Converts Windows paths to the forward-slash form Tailwind expects.
extension POSIXPath on String {
  /// Returns this path with `/` separators on Windows, wrapped in single
  /// quotes when [quoted] is true; other platforms get the path unchanged.
  String toPosix({bool quoted = false}) {
    if (Platform.isWindows) {
      final result = replaceAll(r'\', '/');
      return quoted ? "'$result'" : result;
    }
    return this;
  }
}
