import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/2_courses.dart';

class ProductDioRepository {
  Future<Courses> findByName(String name) async {
    //  final response =
    //    await http.get(Uri.parse('http://localhost:8080/products?name=$name'));
    try {
      final response = await Dio().get('http://localhost:8080/products',
          queryParameters: {"name": name});

      //final responData = jsonDecode(response.body);

      if (response.data.isEmpty) {
        throw Exception('Produto não encontrado');
      }
      return Courses.fromMap(response.data.first);
    } on DioError {
      throw Exception();
    }
  }
}
