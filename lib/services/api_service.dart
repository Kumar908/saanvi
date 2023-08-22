import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:saanvi/models/slider_model.dart';
import 'package:saanvi/models/testimonial_model.dart';
import 'package:saanvi/models/design_ideas_model.dart';
import 'package:saanvi/models/product_model.dart';
import 'package:saanvi/models/product_detail_model.dart';
import 'package:saanvi/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Replace 'your_laravel_api_url' with the base URL of your Laravel API.
  final String _baseUrl = 'https://saanvi.conferentousglobal.com/wp-json/wp/v2';


  Future<List<SliderModel>> getSliderData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/app_slider?acf_format=standard'));
      print('Response:');
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse is List) {
          return jsonResponse.map((item) => SliderModel.fromJson(item)).toList();
        } else {
          throw Exception('Invalid data format. Expected a List.');
        }
      } else {
        throw Exception('Failed to fetch user data. Please try again.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<TestimonialModel>> getTestimonialData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/testimonial?acf_format=standard'));
      print('Response:');
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse is List) {
          return jsonResponse.map((item) => TestimonialModel.fromJson(item)).toList();
        } else {
          throw Exception('Invalid data format. Expected a List.');
        }
      } else {
        throw Exception('Failed to fetch user data. Please try again.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<DesignIdeasModel>> getDesignIdeasData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/design_idea?acf_format=standard'));
      print('Response:');
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse is List) {
          return jsonResponse.map((item) => DesignIdeasModel.fromJson(item)).toList();
        } else {
          throw Exception('Invalid data format. Expected a List.');
        }
      } else {
        throw Exception('Failed to fetch user data. Please try again.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ProductModel>> getProductsData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/product?acf_format=standard'));
      print('Response:');
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse is List) {
          return jsonResponse.map((item) => ProductModel.fromJson(item)).toList();
        } else {
          throw Exception('Invalid data format. Expected a List.');
        }
      } else {
        throw Exception('Failed to fetch product data. Please try again.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ProductDetailsModel> getSingleProductDetails(int productId) async {
    try {
      final response = await http.get(
        Uri.parse('https://saanvi.conferentousglobal.com/wp-json/wp/v2/product/$productId'),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ProductDetailsModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch product details. Please try again.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}

