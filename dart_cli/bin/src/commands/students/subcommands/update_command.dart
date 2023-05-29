import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import '../../../models/3_address.dart';
import '../../../models/4_phone.dart';
import '../../../models/5_city.dart';
import '../../../models/repositorioJson.dart';
import '../../../repositories/product_dio_repository.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/studenty_dio_repository.dart';
import '../../../repositories/studenty_repository.dart';

class UpdateCommand extends Command {
  StudentyDioRepository studentyRepository;
  final productRepository = ProductDioRepository();

  UpdateCommand(this.studentyRepository) {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
    argParser.addOption('id', help: 'Student ID', abbr: 'i');
  }

  @override
  String get description => 'update Student';

  @override
  String get name => 'update';

  @override
  void run() async {
    print('aguarde...');
    final filePath = argResults?['file'];
    final id = argResults?['id'];
    if (id == null) {
      print('Por favor informe o ID do Aluno com o comando: --id=0 ou -i 0');
      return;
    }

    final students = File(filePath).readAsLinesSync(encoding: latin1);
    print('Atualizando dados do aluno, Por favor aguarde...');
    print('--------------------------');

    if (students.length > 1) {
      print('Por favor informe Somente UM aluno no arquivo: $filePath');
    } else if (students.isEmpty) {
      print('Por favor informe um Aluno no arquivo $filePath');
      return;
    }

    var student = students.first;

    final studentData = student.split(';');
    final courseCsv = studentData[2].split(',').map((e) => e.trim()).toList();

    final courseFutures = courseCsv.map((e) async {
      final course = await productRepository.findByName(e);
      course.isStudent = true;
      return course;
    }).toList();

    final courses = await Future.wait(courseFutures);
    final studentModel = Students(
      id: int.parse(id),
      name: studentData[0],
      age: int.tryParse(studentData[1]),
      nameCourses: courseCsv,
      courses: courses,
      address: Address(
          street: studentData[3],
          number: int.parse(studentData[4]),
          zipCode: studentData[5],
          city: City(id: 1, name: studentData[6]),
          phone: Phone(ddd: int.parse(studentData[7]), phone: studentData[8])),
      phone: Phone(ddd: int.parse(studentData[7]), phone: studentData[8]),
    );
    await studentyRepository.update(studentModel);

    print('Aluno Atualizado com Sucesso!');
    print('-----------------------------------');
  }
}
