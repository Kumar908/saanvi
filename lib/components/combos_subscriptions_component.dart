import 'package:flutter/material.dart';
import 'package:saanvi/custom_widget/space.dart';
import 'package:saanvi/models/combos_services_model.dart';
import 'package:saanvi/screens/service_screen.dart';
import 'package:saanvi/models/product_model.dart';
import 'package:saanvi/models/product_detail_model.dart';
import 'package:saanvi/services/api_service.dart';
import 'package:saanvi/screens/product_details_screen.dart';

class CombosSubscriptionsComponent extends StatelessWidget {
  final List<ProductModel> products;

  CombosSubscriptionsComponent({required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        children: List.generate(
          products.length,
              (index) => FutureBuilder(
            future: products[index].fetchFeaturedMediaUrl(), // Fetch the featured media URL
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Display a loading indicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // Once the featured media URL is fetched, build the UI
                return GestureDetector(
                  onTap: () async {
                    // Fetch the product details using the product ID
                    ProductDetailsModel productDetails = await ApiService().getSingleProductDetails(products[index].id);

                    // Navigate to the product details page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductDetailsScreen(productDetails: productDetails)),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox(
                            width: 170,
                            height: 100,
                            child: Image.network(products[index].featuredMediaUrl, fit: BoxFit.cover),
                          ),
                        ),
                        Space(8),
                        Text(
                          products[index].title.rendered,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}






