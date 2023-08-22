import 'package:flutter/material.dart';
import 'package:saanvi/custom_widget/space.dart';
import 'package:saanvi/models/customer_review_model.dart';
import 'package:saanvi/utils/colors.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../models/testimonial_model.dart';
import 'package:provider/provider.dart';
import 'package:saanvi/services/api_service.dart';

class CustomerReviewComponent extends StatelessWidget {
  final TestimonialModel testimonial;

  CustomerReviewComponent({required this.testimonial});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(testimonial.name, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                testimonial.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




