import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:args/command_runner.dart';

import '../../../repositories/studenty_dio_repository.dart';
import '../../../repositories/studenty_repository.dart';

class FindAllCommand extends Command {
  final StudentyDioRepository repository;

  @override
  String get description => 'Find all Students';

  @override
  String get name => 'findAll';

  FindAllCommand(this.repository);

  @override
  Future<void> run() async {
    print('Aguardando buscar alunos...');
    final students = await repository.findAll();
    print('Apresentar também os Cursos? (S) ou (N)');

    final showCourses = stdin.readLineSync();
    print('Alunos: ');
    for (var student in students) {
      if (showCourses?.toLowerCase() == 's') {
        print(
            '${student.id} - ${student.name} - ${student.courses.where((course) => course.isStudent).map((e) => e.name).toList()}');
      } else {
        print('${student.id} - ${student.name}');
      }
    }
  }
}
