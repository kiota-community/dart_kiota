import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:yaml/yaml.dart';

class PrepareCommand extends Command {
  @override
  final description = "Prepares a package for publishing";

  @override
  final name = "prepare";

  @override
  void run() {
    final package = argResults!.rest.firstOrNull;
    if (package == null) {
      stdout.writeln('No package specified. Running for all packages');

      _runForAllPackages();

      return;
    }

    _runForPackage(package);

    stdout.writeln('Done');
  }

  void _runForAllPackages() {
    for (final package in Directory('packages').listSync()) {
      if (package is Directory) {
        _runForPackage(package.path.split(Platform.pathSeparator).last);
      }
    }
  }

  void _runForPackage(String package) {
    stdout
      ..writeln()
      ..writeln('Preparing $package');

    _runBuildRunner(package);
    _copyLicense(package);

    stdout.writeln('Done');
  }

  bool _packageRequiresBuildRunner(String package) {
    final pubspec = File('packages/$package/pubspec.yaml');
    if (!pubspec.existsSync()) {
      stderr.writeln('No pubspec.yaml found for $package!');

      return false;
    }

    final pubspecContent = pubspec.readAsStringSync();
    final pubspecMap = loadYaml(pubspecContent);
    final buildRunner = pubspecMap['dev_dependencies']['build_runner'];

    return buildRunner != null;
  }

  void _runBuildRunner(String package) {
    if (!_packageRequiresBuildRunner(package)) {
      return;
    }

    stdout.writeln('Running build_runner for $package');

    final result = Process.runSync(
      'dart',
      ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      workingDirectory: 'packages/$package',
    );

    if (result.exitCode != 0) {
      stderr.writeln('Error running build_runner: ${result.stderr}');

      exit(1);
    }
  }

  void _copyLicense(String package) {
    final license = File('LICENSE');
    if (!license.existsSync()) {
      stderr.writeln('No LICENSE file found!');

      return;
    }

    final licenseContent = license.readAsStringSync();

    final licenseFile = File('packages/$package/LICENSE');

    licenseFile.writeAsStringSync(licenseContent);
  }
}
