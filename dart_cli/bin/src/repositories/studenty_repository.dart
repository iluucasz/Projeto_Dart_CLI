import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/repositorioJson.dart';

class StudentyRepository {
  Future<List<Students>> findAll() async {
    final studentsResult =
        await http.get(Uri.parse('http://localhost:8080/students'));

    final studantsData = jsonDecode(studentsResult.body) as List;

    return studantsData.map<Students>((student) {
      return Students.fromMap(student);
    }).toList();
  }

  Future<Students> findById(int id) async {
    final studentResult =
        await http.get(Uri.parse('http://localhost:8080/students/$id'));
    if (studentResult.body == '{}') {
      throw Exception('Não há arquivos');
    }
    return Students.fromJson(studentResult.body);
  }

  Future<void> insert(Students student) async {
    final response = await http.post(
        Uri.parse('http://localhost:8080/students/'),
        body: student.toJson(),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode != 200) {
      throw Exception('Sistema fora do ar');
    }
  }

  Future<void> update(Students student) async {
    final response = await http.put(
        Uri.parse('http://localhost:8080/students/${student.id}'),
        body: student.toJson(),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode != 200) {
      throw Exception('Sistema fora do ar');
    }
  }

  Future<void> deleteById(int id) async {
    final response =
        await http.delete(Uri.parse('http://localhost:8080/students/$id'));

    if (response.statusCode != 200) {
      throw Exception('Sistema fora do ar');
    }
  }
}
