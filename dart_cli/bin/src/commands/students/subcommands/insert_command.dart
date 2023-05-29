import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import '../../../models/3_address.dart';
import '../../../models/4_phone.dart';
import '../../../models/5_city.dart';
import '../../../models/repositorioJson.dart';
import '../../../repositories/product_dio_repository.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/studenty_dio_repository.dart';
import '../../../repositories/studenty_repository.dart';

class InsertCommand extends Command {
  final StudentyDioRepository studentyRepository;
  final productRepository = ProductDioRepository();
  @override
  String get description => 'Insert Student';

  @override
  String get name => 'insert';

  InsertCommand(this.studentyRepository) {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
  }

  Future<void> run() async {
    print('aguarde...');
    final filePath = argResults?['file'];
    final students = File(filePath).readAsLinesSync(encoding: latin1);
    print('--------------------------');
    for (var student in students) {
      final studentData = student.split(';');
      final courseCsv = studentData[2].split(',').map((e) => e.trim()).toList();

      final courseFutures = courseCsv.map((e) async {
        final course = await productRepository.findByName(e);
        course.isStudent = true;
        return course;
      }).toList();

      final courses = await Future.wait(courseFutures);
      final studentModel = Students(
        name: studentData[0],
        age: int.tryParse(studentData[1]),
        nameCourses: courseCsv,
        courses: courses,
        address: Address(
            street: studentData[3],
            number: int.parse(studentData[4]),
            zipCode: studentData[5],
            city: City(id: 1, name: studentData[6]),
            phone:
                Phone(ddd: int.parse(studentData[7]), phone: studentData[8])),
        phone: Phone(ddd: int.parse(studentData[7]), phone: studentData[8]),
      );
      await studentyRepository.insert(studentModel);
    }
    print('Alunos adicionados com sucesso');
    print('-----------------------------------');
  }
}
