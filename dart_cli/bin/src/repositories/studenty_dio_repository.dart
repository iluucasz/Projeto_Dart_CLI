import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;

import '../../dart_cli.dart';
import '../models/repositorioJson.dart';

class StudentyDioRepository {
  Future<List<Students>> findAll() async {
    // final studentsResult =
    //     await http.get(Uri.parse('http://localhost:8080/students'));

    //  final studantsData = jsonDecode(studentsResult.body) as List;

    try {
      final studentsResult = await Dio().get('http://localhost:8080/students');

      return studentsResult.data.map<Students>((student) {
        return Students.fromMap(student);
      }).toList();
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<Students> findById(int id) async {
    // final studentResult =
    //   await http.get(Uri.parse('http://localhost:8080/students/$id'));
    try {
      final studentsResult =
          await Dio().get('http://localhost:8080/students/$id');

      if (studentsResult.data == null) {
        throw Exception('Não há arquivos');
      }
      return Students.fromMap(studentsResult.data);
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> insert(Students student) async {
    /*
    final response = await http.post(
        Uri.parse('http://localhost:8080/students/'),
        body: student.toJson(),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode != 200) {
      throw Exception('Sistema fora do ar');
    }
    */
    try {
      await Dio()
          .post('http://localhost:8080/students/', data: student.toMap());
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> update(Students student) async {
    /*
   final response = await http.put(
        Uri.parse('http://localhost:8080/students/${student.id}'),
        body: student.toJson(),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode != 200) {
      throw Exception('Sistema fora do ar');
    }
    */
    try {
      await Dio().put('http://localhost:8080/students/${student.id}',
          data: student.toMap());
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    /*
    final response =
        await http.delete(Uri.parse('http://localhost:8080/students/$id'));

    if (response.statusCode != 200) {
      throw Exception('Sistema fora do ar');
    }
    */
    try {
      await Dio().delete('http://localhost:8080/students/$id}');
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }
}
