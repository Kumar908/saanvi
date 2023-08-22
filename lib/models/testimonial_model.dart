import 'package:flutter/material.dart';

class TestimonialModel {
  final int id;
  final String name;
  final String title;
  final String content;

  TestimonialModel({
    required this.id,
    required this.name,
    required this.title,
    required this.content,
  });

  factory TestimonialModel.fromJson(Map<String, dynamic> json) {
    return TestimonialModel(
      id: json['id'],
      name: json['acf']['name'],
      title: json['acf']['title'],
      content: json['acf']['content'],
    );
  }
}
