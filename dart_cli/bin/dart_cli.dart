import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'src/commands/students/students_commands.dart';

void main(List<String> args) {
  // final argParser = ArgParser();
  // argParser.addFlag('data', abbr: 'd');
  // argParser.addOption('name', abbr: 'n');
  // argParser.addOption('template', abbr: 't');
  // final argResult = argParser.parse(args);
  // print('${argResult['data']}');
  // print('${argResult['name']}');
  // print('${argResult['template']}');

  /*
class ExemploComand extends Command {
  ExemploComand() {
    argParser.addOption('template', abbr: 't');
  }

  @override
  String get description => 'Apenas um exemplo';

  @override
  String get name => 'exemplo';

  @override
  void run() {
    print('Executar o que eu quiser');
  }}*/

  CommandRunner('ADF CLI', 'ADF CLI DESCRIPTION')
    ..addCommand(StudentsCommands())
    ..run(args);
}
