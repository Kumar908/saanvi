import 'package:flutter/material.dart';

class DesignIdeasModel {
  final int id;
  final String title;
  final String image;
  final String pinterestLink;

  DesignIdeasModel({
    required this.id,
    required this.title,
    required this.image,
    required this.pinterestLink,
  });

  factory DesignIdeasModel.fromJson(Map<String, dynamic> json) {
    return DesignIdeasModel(
      id: json['id'],
      title: json['title']['rendered'],
      image: json['acf']['image'],
      pinterestLink: json['acf']['pinterest_link'],
    );
  }
}

