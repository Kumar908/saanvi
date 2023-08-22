import 'package:flutter/material.dart';
import 'package:saanvi/custom_widget/space.dart';
import 'package:saanvi/models/renovate_services_model.dart';
import 'package:saanvi/screens/service_screen.dart';
import 'package:saanvi/models/design_ideas_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RenovateHomeComponent extends StatelessWidget {
  final List<DesignIdeasModel> designIdeas;

  RenovateHomeComponent({required this.designIdeas});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: designIdeas.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              final pinterestLink = designIdeas[index].pinterestLink;

              try {
                final Uri uri = Uri.parse(pinterestLink);
                await launchUrl(uri);
              } catch (e) {
                throw 'Could not launch $pinterestLink';
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: 160,
                      height: 100,
                      child: Image.network(designIdeas[index].image, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    designIdeas[index].title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

