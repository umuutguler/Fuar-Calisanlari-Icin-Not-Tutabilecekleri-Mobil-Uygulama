import 'dart:async';

import 'package:bitirme_projesi/fuar/HomePage/HomePage.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LandingPage/LandingPage.dart';
import '../Services/FirebaseOperation.dart';
import '../constants/Constantscolors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ConstantColor constantColor = ConstantColor();
  late StreamSubscription<User?> user;
  FirebaseAuth? users;

  @override
  void initState() {
    super.initState();
    /* users = FirebaseAuth.instance.userChanges().listen((user) {
      if (users == null) {
        print('User is currently signed out!');
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: LandingPage(), type: PageTransitionType.bottomToTop));
      } else {
        print('User is signed in!');
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: HomePage(), type: PageTransitionType.bottomToTop));
      }
    }) as FirebaseAuth?;  */

    Timer(
        const Duration(
          seconds: 1,
        ),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: LandingPage(), type: PageTransitionType.leftToRight)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constantColor.darkColor,
        body: Center(
          child: RichText(
              text: TextSpan(
                  text: "AP",
                  style: TextStyle(
                      color: constantColor.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0),
                  children: <TextSpan>[
                TextSpan(
                  text: "2022-2023",
                  style: TextStyle(
                      color: constantColor.blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 34.0),
                ),
              ])),
        ));
  }
}
