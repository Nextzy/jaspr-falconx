import 'dart:convert';
import 'dart:io';

import 'package:build/build.dart';
import 'package:build_modules/build_modules.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;

Builder buildStylesheet(BuilderOptions options) => TailwindBuilder(options);

class TailwindBuilder implements Builder {
  final BuilderOptions options;

  TailwindBuilder(this.options);

  @override
  Future<void> build(BuildStep buildStep) async {
    final scratchSpace = await buildStep.fetchResource(scratchSpaceResource);

    // Ensure input file is copied to scratch space
    await scratchSpace.ensureAssets({buildStep.inputId}, buildStep);

    final outputId = buildStep.inputId.changeExtension('').changeExtension('.css');

    // Check if tailwindcss is available
    final tailwindCheck = await Process.run('which', ['tailwindcss'], runInShell: true);
    if (tailwindCheck.exitCode != 0) {
      log.severe('tailwindcss not found in PATH. Please install it globally: npm install -g tailwindcss');
      return;
    }

    bool foundDaisyui = false;
    String? jasprFalkitPath;
    final packageConfigFile = File('.dart_tool/package_graph.json');
    if (await packageConfigFile.exists()) {
      final configJson = jsonDecode(await packageConfigFile.readAsString());
      final packages = configJson['packages'] as List?;
      if (packages != null) {
        for (final package in packages) {
          if (package['name'] == 'jaspr_daisyui') {
            foundDaisyui = true;
          } else if (package['name'] == 'jaspr_falkit') {
            final rootUri = package['rootUri'] as String?;
            if (rootUri != null) {
              // Convert URI to file path
              if (rootUri.startsWith('file://')) {
                jasprFalkitPath = Uri.parse(rootUri).toFilePath();
              } else if (!rootUri.startsWith('http')) {
                // Relative path
                jasprFalkitPath = p.normalize(p.join(Directory.current.path, '.dart_tool', rootUri));
              }
            }
          }
        }
      }
    }

    if (foundDaisyui == false) {
      log.warning("Cannot find 'jaspr_daisyui' in package config.");
    }

    // DaisyUI
    final daisyPluginInput = AssetId(buildStep.inputId.package, 'web/daisyui.js');
    final hasDaisyPlugin = await buildStep.canRead(daisyPluginInput);
    final daisyThemeInput = AssetId(buildStep.inputId.package, 'web/daisyui-theme.js');
    final hasDaisyTheme = await buildStep.canRead(daisyThemeInput);

    if (hasDaisyPlugin) {
      await scratchSpace.ensureAssets({daisyPluginInput}, buildStep);
    }
    if (hasDaisyTheme) {
      await scratchSpace.ensureAssets({daisyThemeInput}, buildStep);
    }

    // in order to rebuild when source files change
    final assets = await buildStep.findAssets(Glob('{lib,web}/**.dart')).toList();
    await Future.wait(assets.map((a) => buildStep.canRead(a)));

    final configFile = File('tailwind.config.js');
    final hasCustomConfig = await configFile.exists();

    // Get the actual file paths
    final inputPath = scratchSpace.fileFor(buildStep.inputId).path;
    final outputPath = scratchSpace.fileFor(outputId).path;

    // Log the paths for debugging
    log.info('Tailwind input: $inputPath');
    log.info('Tailwind output: $outputPath');
    if (jasprFalkitPath != null) {
      log.info('Including jaspr_falkit from: $jasprFalkitPath');
    }

    // Check if input file exists
    if (!await File(inputPath).exists()) {
      log.severe('Input file does not exist in scratch space: $inputPath');
      return;
    }

    // Build content paths
    final contentPaths = <String>[];

    // Add current project paths
    contentPaths.add(p.join(Directory.current.path, '{lib,web}', '**', '*.dart').toPosix(true));

    // Add jaspr_falkit paths if available
    if (jasprFalkitPath != null) {
      contentPaths.add(p.join(jasprFalkitPath, '{lib,web}', '**', '*.dart').toPosix(true));
    }

    // Join all content paths with comma
    final contentPathsStr = contentPaths.join(',');

    // Run tailwindcss
    final result = await Process.run('tailwindcss', [
      '--input',
      inputPath.toPosix(),
      '--output',
      outputPath.toPosix(),
      if (options.config.containsKey('tailwindcss')) options.config['tailwindcss'] as String,
      if (hasCustomConfig) ...[
        '--config',
        p.join(Directory.current.path, 'tailwind.config.js').toPosix(),
      ] else ...[
        '--content',
        contentPathsStr,
      ],
    ], runInShell: true);

    // Check if the command succeeded
    if (result.exitCode != 0) {
      log.severe('Tailwind CSS failed with exit code ${result.exitCode}');
      log.severe('stdout: ${result.stdout}');
      log.severe('stderr: ${result.stderr}');
      return;
    }

    // Check if output file was created
    final outputFile = File(outputPath);
    if (!await outputFile.exists()) {
      log.severe('Output file was not created: $outputPath');
      log.severe('Tailwind stdout: ${result.stdout}');
      log.severe('Tailwind stderr: ${result.stderr}');
      return;
    }

    // Check if output file has content
    final outputContent = await outputFile.readAsString();
    if (outputContent.isEmpty) {
      log.warning('Output file is empty. Check your Tailwind configuration and input CSS.');
    }

    // Copy the output
    await scratchSpace.copyOutput(outputId, buildStep);
    log.info('Successfully generated ${outputId.path}');
  }

  @override
  Map<String, List<String>> get buildExtensions => {
    'web/{{file}}.tw.css': ['web/{{file}}.css'],
  };
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
