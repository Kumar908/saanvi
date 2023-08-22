import 'package:flutter/material.dart';

class SliderModel {
  final int id;
  final String title;
  final Map<String, dynamic> acf;

  SliderModel({
    required this.id,
    required this.title,
    required this.acf,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'] ?? '',
      title: json['title']['rendered'] ?? '',
      acf: json['acf'] ?? '',
    );
  }
}
