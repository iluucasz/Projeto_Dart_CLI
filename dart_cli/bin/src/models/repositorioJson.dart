// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '2_courses.dart';
import '3_address.dart';
import '4_phone.dart';

class Students {
  final int? id;
  final String name;
  final int? age;
  final List<String> nameCourses;
  final List<Courses> courses;
  final Address address;
  final Phone phone;
  Students({
    this.id,
    required this.name,
    this.age,
    required this.nameCourses,
    required this.courses,
    required this.address,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'nameCourses': nameCourses,
      'courses': courses.map((e) => e.toMap()).toList(),
      'address': address.toMap(),
      'phone': phone.toMap(),
    };
    if (age != null) {
      map["age"] = age;
    }
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Students.fromMap(Map<String, dynamic> map) {
    return Students(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      nameCourses: List<String>.from((map['nameCourses'] ?? {})),
      courses: List<Courses>.from(
          (map['courses'] ?? {}).map((e) => Courses.fromMap(e))),
      address: Address.fromMap(map['address'] ?? {}),
      phone: Phone.fromMap(map['phone'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory Students.fromJson(String source) =>
      Students.fromMap(json.decode(source) ?? Map<String, dynamic>);
}
