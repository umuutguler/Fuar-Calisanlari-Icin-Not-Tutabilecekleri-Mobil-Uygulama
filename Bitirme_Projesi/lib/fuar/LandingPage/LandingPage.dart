import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/Constantscolors.dart';
import 'LandingHelpers.dart';

class LandingPage extends StatelessWidget {
   LandingPage({super.key});

  ConstantColor constantColor = ConstantColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColor.whiteColor,
      body: Stack(
        children: [
          bodyColor(),
          Provider.of<LandingHelpers>(context, listen: false).bodyImage(context),
          Provider.of<LandingHelpers>(context, listen: false).mainButton(context),
          Provider.of<LandingHelpers>(context, listen: false).privacyText(context)
        ],
      ),
    );
  }


   bodyColor() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
            0.5,
            0.9
          ],
              colors: [
            constantColor.darkColor,
            constantColor.blueGreyColor,
          ])),
    );
  }
}