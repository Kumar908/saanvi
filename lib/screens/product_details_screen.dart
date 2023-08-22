import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:saanvi/models/product_detail_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDetailsModel productDetails;

  const ProductDetailsScreen({required this.productDetails});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String brochureHtml = ''; // Initialize with an empty string

  @override
  void initState() {
    super.initState();
    fetchBrochureHtml();
  }

  Future<void> fetchBrochureHtml() async {
    final response = await http.get(Uri.parse(widget.productDetails.brochureUrl));
    if (response.statusCode == 200) {
      setState(() {
        brochureHtml = response.body; // Store the fetched HTML content
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productDetails.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.productDetails.featuredMediaUrl), // Use featuredMediaUrl
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final Uri uri = Uri.parse(widget.productDetails.brochureUrl);
              await launchUrl(uri);
            },
            child: Text("View Brochure"),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Product Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Html(
                  data: brochureHtml, // Use the fetched HTML content
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
