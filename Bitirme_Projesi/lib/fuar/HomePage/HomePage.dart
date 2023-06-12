import 'package:bitirme_projesi/fuar/Screens/Search/Search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LandingPage/LandingPage.dart';
import '../Screens/Feed/Feed.dart';
import '../Screens/Profile/Profile.dart';
import '../Services/FirebaseOperation.dart';
import '../constants/Constantscolors.dart';
import 'HomePageHelpers.dart';

class HomePage extends StatefulWidget {
  const HomePage({key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConstantColor constantColor = ConstantColor();
  final PageController homepageController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constantColor.blueGreyColor,
        body: PageView(
          controller: homepageController,
          children: [
            Feed(),
            Profile(),
          ],
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              pageIndex = page;
            });
          },
        ),
        bottomNavigationBar:
            Provider.of<HomePageHelpers>(context, listen: false)
                .bottomNavBar(context, pageIndex, homepageController));
  }
}
