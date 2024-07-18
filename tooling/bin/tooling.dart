import 'package:args/command_runner.dart';
import 'package:tooling/tooling.dart';

void main(List<String> args) {
  final runner = CommandRunner("tooling", "Tooling for Dart Kiota")
    ..addCommand(PrepareCommand());

  runner.run(args);
}
