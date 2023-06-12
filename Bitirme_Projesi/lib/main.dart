import 'dart:convert';
import 'package:bitirme_projesi/webview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'fuar/HomePage/HomePageHelpers.dart';
import 'fuar/LandingPage/LandingHelpers.dart';
import 'fuar/LandingPage/LandingServices.dart';
import 'fuar/LandingPage/LandingUtils.dart';
import 'fuar/Screens/Feed/FeedHelpers.dart';
import 'fuar/Services/FirebaseOperation.dart';
import 'fuar/Utils/UploadPost.dart';
import 'webview.dart';
import 'home.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LandingUtils()),
        ChangeNotifierProvider(create: (_) => FirebaseOperation()),
        ChangeNotifierProvider(create: (_) => LandingServices()),
        ChangeNotifierProvider(create: (_) => LandingHelpers()),
        ChangeNotifierProvider(create: (_) => HomePageHelpers()),
        ChangeNotifierProvider(create: (_) => UploadPost()),
        ChangeNotifierProvider(create: (_) => FeedHelper()),
        ChangeNotifierProvider(create: (_) => UploadPost()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white38,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
            contentPadding: EdgeInsets.symmetric(
                vertical: defpaultPadding * 1.2, horizontal: defpaultPadding),
          ),
        ),
        home: Home(),
      ),
    );
  }
}
