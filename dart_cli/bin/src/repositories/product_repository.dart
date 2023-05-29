import 'dart:convert';

import '../models/2_courses.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<Courses> findByName(String name) async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/products?name=$name'));

    if (response.statusCode != 200) {
      throw Exception('Servidor inoperante');
    }
    final responData = jsonDecode(response.body);
    if (responData.isEmpty) {
      throw Exception('Produto não encontrado');
    }
    return Courses.fromMap(responData.first);
  }
}
