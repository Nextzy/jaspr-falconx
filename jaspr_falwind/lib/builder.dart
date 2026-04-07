import 'dart:io';

import 'package:build/build.dart';
import 'package:build_modules/build_modules.dart';
import 'package:glob/glob.dart';

Builder buildStylesheet(BuilderOptions options) => TailwindBuilder(options);

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
  TailwindBuilder(this.options);

  final BuilderOptions options;

  @override
  Future<void> build(BuildStep buildStep) async {
    final scratchSpace = await buildStep.fetchResource(scratchSpaceResource);
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

    if (!await File(inputPath).exists()) {
      log.severe('Input file does not exist in scratch space: $inputPath');
      return;
    }

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
      log.severe('Tailwind CSS failed with exit code ${result.exitCode}');
      log.severe('stdout: ${result.stdout}');
      log.severe('stderr: ${result.stderr}');
      return;
    }

    final outputFile = File(outputPath);
    if (!await outputFile.exists()) {
      log.severe('Output file was not created: $outputPath');
      log.severe('Tailwind stdout: ${result.stdout}');
      log.severe('Tailwind stderr: ${result.stderr}');
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

bool _which(String binary) {
  final result = Process.runSync(
    Platform.isWindows ? 'where' : 'which',
    [binary],
    runInShell: true,
  );
  return result.exitCode == 0;
}

extension POSIXPath on String {
  String toPosix([bool quoted = false]) {
    if (Platform.isWindows) {
      final result = replaceAll('\\', '/');
      return quoted ? "'$result'" : result;
    }
    return this;
  }
}
