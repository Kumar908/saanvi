import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:saanvi/components/combos_subscriptions_component.dart';
import 'package:saanvi/components/customer_review_component.dart';
import 'package:saanvi/components/home_contruction_component.dart';
import 'package:saanvi/components/home_service_component.dart';
import 'package:saanvi/components/popular_service_component.dart';
import 'package:saanvi/components/renovate_home_component.dart';
import 'package:saanvi/fragments/bookings_fragment.dart';
import 'package:saanvi/models/customer_details_model.dart';
import 'package:saanvi/screens/notification_screen.dart';
import 'package:saanvi/screens/service_providers_screen.dart';
import 'package:saanvi/screens/sign_in_screen.dart';
import 'package:saanvi/utils/images.dart';
import 'package:saanvi/utils/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../custom_widget/space.dart';
import '../main.dart';
import '../models/customer_review_model.dart';
import '../models/services_model.dart';
import '../screens/all_categories_screen.dart';
import '../screens/favourite_services_screen.dart';
import '../screens/my_profile_screen.dart';
import '../utils/colors.dart';

import 'package:saanvi/providers/data_provider.dart';
import '../models/slider_model.dart';
import '../models/testimonial_model.dart';
import '../models/design_ideas_model.dart';
import '../models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:saanvi/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  double aspectRatio = 0.0;
  List<String> bannerList = [banner1, banner2, banner];

  final offerPagesController = PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);
  final reviewPagesController = PageController(viewportFraction: 0.93, keepPage: true, initialPage: 1);

  @override
  void dispose() {
    offerPagesController.dispose();
    reviewPagesController.dispose();
    super.dispose();
  }

  Future<void> _showLogOutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure you want to Logout?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          ),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
  late Future<List<SliderModel>> _dataFuture;
  late Future<List<TestimonialModel>> _dataFuture2;
  late Future<List<DesignIdeasModel>> _designIdeasFuture;
  late Future<List<ProductModel>> _productData;

  @override
  void initState() {
    super.initState();
    _dataFuture = ApiService().getSliderData();
    _dataFuture2 = ApiService().getTestimonialData();
    _designIdeasFuture = ApiService().getDesignIdeasData();
    _productData = ApiService().getProductsData(); // Corrected method call
  }

  @override
  Widget build(BuildContext context) {
    aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transparent,
        iconTheme: IconThemeData(size: 30),
        actions: [
          Observer(
            builder: (context) {
              return Padding(
                padding: EdgeInsets.all(10.0),
                child: Switch(
                  value: appData.isDark,
                  onChanged: (value) {
                    setState(() {
                      appData.toggle();
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              padding: EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 24),
              color: appData.isDark ? Colors.black : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Image.network(
                      'http://saanvi.conferentousglobal.com/wp-content/themes/saanvi/images/resources/logo.png',
                      fit: BoxFit.cover,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  Space(4),
                  Space(4),
                ],
              ),
            ),
            drawerWidget(
              drawerTitle: "My Profile",
              drawerIcon: Icons.person,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfileScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "My Favourites",
              drawerIcon: Icons.favorite,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteProvidersScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "Notifications",
              drawerIcon: Icons.notifications,
              drawerOnTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "My bookings",
              drawerIcon: Icons.calendar_month,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingsFragment(fromProfile: true)),
                );
              },
            ),
            drawerWidget(
              drawerTitle: "Refer and earn",
              drawerIcon: Icons.paid_rounded,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            drawerWidget(
              drawerTitle: "Contact Us",
              drawerIcon: Icons.mail,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            drawerWidget(
              drawerTitle: "Help Center",
              drawerIcon: Icons.question_mark_rounded,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            drawerWidget(
              drawerTitle: "Logout",
              drawerIcon: Icons.logout,
              drawerOnTap: () {
                Navigator.pop(context);
                _showLogOutDialog();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Space(16),
            SizedBox(
              height: 170,
              child: FutureBuilder<List<SliderModel>>(
                future: _dataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Text('No data available.');
                  } else {
                    List<SliderModel> sliderList = snapshot.data!;

                    return PageView.builder(
                      controller: offerPagesController,
                      itemCount: sliderList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(sliderList[index].acf['slide'], fit: BoxFit.cover), // Using the slide URL from acf
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),


            ),
            SmoothPageIndicator(
              controller: offerPagesController,
              count: 3,
              effect: ExpandingDotsEffect(
                dotHeight: 7,
                dotWidth: 8,
                activeDotColor: appData.isDark ? Colors.white : Colors.black,
                expansionFactor: 2.2,
              ),
            ),


            Space(24),
            FutureBuilder<List<DesignIdeasModel>>(
              future: _designIdeasFuture,
              builder: (context, designIdeasSnapshot) {
                if (designIdeasSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (designIdeasSnapshot.hasError) {
                  return Text('Error: ${designIdeasSnapshot.error}');
                } else if (!designIdeasSnapshot.hasData ) {
                  return Text('No design ideas available.');
                } else {
                  List<DesignIdeasModel> designIdeasList = designIdeasSnapshot.data ?? [];
                  return Column(
                    children: [
                      homeTitleWidget(
                        titleText: "Design Ideas",
                        onAllTap: () async {
                          final url = 'https://in.pinterest.com/SaanviAVS/'; // Replace with your desired URL

                          try {
                            final Uri uri = Uri.parse(url);
                            await launchUrl(uri);
                          } catch (e) {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                      Space(4),
                      RenovateHomeComponent(designIdeas: designIdeasList),
                      // Pass the designIdeasList to your component
                    ],
                  );
                }
              },
            ),

            Space(24),

            FutureBuilder<List<ProductModel>>(
              future: _productData,
              builder: (context, productSnapshot) {
                if (productSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (productSnapshot.hasError) {
                  return Text('Error: ${productSnapshot.error}');
                } else if (!productSnapshot.hasData || productSnapshot.data!.isEmpty) {
                  return Text('No products available.');
                } else {
                  List<ProductModel> productList = productSnapshot.data!;

                  return Column(
                    children: [
                      homeTitleWidget(
                        titleText: "Our Products",
                        onAllTap: () async {
                          final url = 'https://saanviavs.com/'; // Replace with your desired URL

                          try {
                            final Uri uri = Uri.parse(url);
                            await launchUrl(uri);
                          } catch (e) {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                      Space(4),
                      CombosSubscriptionsComponent(products: productList),
                      // Pass the productList to your component
                    ],
                  );
                }
              },
            ),

            Space(32),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "What our customers say",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
              ),
            ),
            Space(16),
            SizedBox(
              height: 117,
              child: FutureBuilder<List<TestimonialModel>>(
                future: ApiService().getTestimonialData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Display a loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No testimonials available.');
                  } else {
                    List<TestimonialModel> testimonialList = snapshot.data!;

                    return PageView.builder(
                      controller: reviewPagesController,
                      itemCount: testimonialList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CustomerReviewComponent(
                          testimonial: testimonialList[index], // Pass the testimonial for the current index
                        );
                      },
                    );
                  }
                },
              ),
            ),


            Space(16),
            SmoothPageIndicator(
              controller: reviewPagesController,
              count: customerReviews.length,
              effect: ScaleEffect(
                dotHeight: 7,
                dotWidth: 7,
                activeDotColor: appData.isDark ? Colors.white : activeDotColor,
                dotColor: Colors.grey.withOpacity(0.2),
              ),
            ),
            Space(16),
          ],
        ),
      ),
    );
  }
}
