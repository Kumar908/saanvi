import 'package:flutter/material.dart';
import 'package:saanvi/components/search_component.dart';
import 'package:saanvi/utils/widgets.dart';

import '../models/services_model.dart';
import '../utils/colors.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({Key? key}) : super(key: key);

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: Text(
          "Search",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.all(8),
              physics: NeverScrollableScrollPhysics(),
              itemCount: serviceProviders.length,
              itemBuilder: (context, index) {
                return SearchComponent(index, servicesModel: serviceProviders[index]);
              },
            )
          ],
        ),
      ),
    );
  }
}
