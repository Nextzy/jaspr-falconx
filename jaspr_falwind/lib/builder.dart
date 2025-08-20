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

    // Find workspace root by looking for melos.yaml
    Directory? workspaceRoot;
    final currentDir = Directory.current;

    // Search upwards for melos.yaml to find workspace root
    Directory searchDir = currentDir;
    for (int i = 0; i < 5; i++) {
      // Limit search depth to prevent infinite loops
      final melosFile = File(p.join(searchDir.path, 'melos.yaml'));
      if (await melosFile.exists()) {
        workspaceRoot = searchDir;
        log.info('Found workspace root at: ${workspaceRoot.path}');
        break;
      }
      final parent = searchDir.parent;
      if (parent.path == searchDir.path) break; // Reached filesystem root
      searchDir = parent;
    }

    // Try to find package_config.json in multiple locations
    final possibleConfigPaths = <String>[];

    // Add current package's config
    possibleConfigPaths.add(p.join(currentDir.path, '.dart_tool', 'package_config.json'));

    // Add workspace root's config if found
    if (workspaceRoot != null) {
      possibleConfigPaths.add(p.join(workspaceRoot.path, '.dart_tool', 'package_config.json'));
    }

    // Try to find and read package config
    File? packageConfigFile;
    for (final path in possibleConfigPaths) {
      final file = File(path);
      if (await file.exists()) {
        packageConfigFile = file;
        log.info('Using package config at: ${p.absolute(path)}');
        break;
      }
    }

    if (packageConfigFile != null && await packageConfigFile.exists()) {
      final configJson = jsonDecode(await packageConfigFile.readAsString());
      final packages = configJson['packages'] as List?;
      if (packages != null) {
        for (final package in packages) {
          if (package['name'] == 'jaspr_falwind') {
            foundDaisyui = true;
            log.info('Found jaspr_falwind package');
          }
        }
      }
    } else {
      log.warning(
        'Could not find package_config.json. Searching in: ${possibleConfigPaths.map(p.absolute).join(', ')}',
      );
    }

    if (foundDaisyui == false) {
      log.info('jaspr_falwind not found in package config - this is expected if running from jaspr_falwind itself.');
      // When running from jaspr_falwind package itself, it won't be in its own package config
      // Set foundDaisyui to true if we're in the jaspr_falwind directory
      if (Directory.current.path.contains('jaspr_falwind')) {
        foundDaisyui = true;
        log.info('Running from jaspr_falwind package directly');
      }
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

    // Check if input file exists
    if (!await File(inputPath).exists()) {
      log.severe('Input file does not exist in scratch space: $inputPath');
      return;
    }

    // Build content paths
    final contentPaths = <String>[];

    // Add current project paths
    contentPaths.add(p.join(Directory.current.path, '{lib,web}', '**', '*.dart').toPosix(true));

    // Build the command arguments
    final commandArgs = [
      '--input',
      inputPath.toPosix(),
      '--output',
      outputPath.toPosix(),
      if (options.config.containsKey('tailwindcss')) options.config['tailwindcss'] as String,
      '--cwd',
      workspaceRoot!.path,
    ];

    // Log the full command for debugging
    log.info('Running tailwindcss command:');
    log.info('tailwindcss ${commandArgs.join(' ')}');

    // Run tailwindcss
    final result = await Process.run('tailwindcss', commandArgs, runInShell: true);

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
