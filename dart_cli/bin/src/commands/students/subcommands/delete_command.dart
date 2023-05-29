import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../repositories/studenty_dio_repository.dart';
import '../../../repositories/studenty_repository.dart';

class DeleteCommand extends Command {
  StudentyDioRepository repository;

  DeleteCommand(this.repository) {
    argParser.addOption('id', help: 'Student id', abbr: 'i');
  }

  @override
  String get description => 'Delete Student By ID';

  @override
  String get name => 'delete';

  Future<void> run() async {
    final id = int.tryParse(argResults?['id']);
    if (id == null) {
      print('Por favor informe o ID do Aluno com o comando --id=1 ou -i 1');
      return;
    }

    print('Aguarde...');
    final student = await repository.findById(id);

    print('Confirma a exclusão do aluno ${student.name}? (S ou N)');

    final confirmDeletee = stdin.readLineSync();
    if (confirmDeletee?.toLowerCase() == 's') {
      await repository.deleteById(id);
      print('----------------------------');
      print('Aluno Deletado com Suceesso');
    } else {
      print('----------------------------');
      print('Operação de (Delete) Cancelada!');
      print('----------------------------');
    }
  }
}
