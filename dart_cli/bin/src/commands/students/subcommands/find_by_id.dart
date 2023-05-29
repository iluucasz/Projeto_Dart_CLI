import 'package:args/command_runner.dart';
import 'dart:async';
import 'dart:io';
import '../../../models/repositorioJson.dart';
import '../../../repositories/studenty_dio_repository.dart';
import '../../../repositories/studenty_repository.dart';

class FindByIdCommand extends Command {
  final StudentyDioRepository studentRepository;

  @override
  String get description => 'Find Student By ID';

  @override
  String get name => 'byId';

  FindByIdCommand(this.studentRepository) {
    argParser.addOption('id', help: 'Student Id', abbr: 'i');
  }

  @override
  void run() async {
    if (argResults?['id'] == null) {
      print('Por favor envie o ID do aluno com o comando --id=0 ou -i 0');
      return;
    }
    final id = int.parse(argResults?['id']);

    print('Aguarde, buscando dados...');
    final student = await studentRepository.findById(id);
    print('----------------------------------');
    print('Aluno: ${student.name}');
    print('----------------------------------');
    print('ID: ${student.id}');
    print('----------------------------------');
    if (student.age == 0 || student.age == null) {
      print('Idade: idade não informada');
    } else {
      print('Idade: ${student.age}');
    }
    print('----------------------------------');
    print('Curso: ');
    student.nameCourses.forEach(print);
    print('----------------------------------');
    print('Endereço: ');
    print(' ${student.address.street} - ${student.address.zipCode}');
    print('----------------------------------');
  }
}
