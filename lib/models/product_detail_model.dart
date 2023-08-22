import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailsModel {
  final int id;
  final String title;
  final String brochureUrl;
  late String featuredMediaUrl;

  ProductDetailsModel({
    required this.id,
    required this.title,
    required this.brochureUrl,
  }) {
    // Call the fetchFeaturedMediaUrl method to initialize featuredMediaUrl
    fetchFeaturedMediaUrl();
  }

  Future<void> fetchFeaturedMediaUrl() async {
    final response = await http.get(
      Uri.parse('https://saanvi.conferentousglobal.com/wp-json/wp/v2/media/$id'), // Use the media ID
    );
    final mediaData = json.decode(response.body);
    featuredMediaUrl = mediaData['source_url']; // Extract the URL
  }

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      title: json['title']['rendered'],
      brochureUrl: json['acf']['brochure'],
    );
  }
}


