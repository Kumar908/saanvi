import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ProductModel {
  final int id;
  final TitleModel title;
  final int featuredMediaId; // Store the ID of the featured media
  late String featuredMediaUrl; // URL of the featured media

  ProductModel({
    required this.id,
    required this.title,
    required this.featuredMediaId,
  });

  Future<void> fetchFeaturedMediaUrl() async {
    // Fetch the media details using the featuredMediaId
    final response = await http.get(
      Uri.parse('https://saanvi.conferentousglobal.com/wp-json/wp/v2/media/$featuredMediaId'),
    );
    final mediaData = json.decode(response.body);
    featuredMediaUrl = mediaData['source_url']; // Extract the URL
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: TitleModel.fromJson(json['title']),
      featuredMediaId: json['featured_media'],
    );
  }
}

class TitleModel {
  final String rendered;

  TitleModel({
    required this.rendered,
  });

  factory TitleModel.fromJson(Map<String, dynamic> json) {
    return TitleModel(
      rendered: json['rendered'],
    );
  }
}
