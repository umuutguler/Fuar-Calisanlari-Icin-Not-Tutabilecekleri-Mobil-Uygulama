import 'dart:io';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Services/FirebaseOperation.dart';
import '../constants/Constantscolors.dart';

class HomePageHelpers with ChangeNotifier {
  ConstantColor constantColor = ConstantColor();

  Widget bottomNavBar(
      BuildContext context, int index, PageController pageController) {
    return CustomNavigationBar(
      currentIndex: index,
      bubbleCurve: Curves.bounceIn,
      scaleCurve: Curves.decelerate,
      selectedColor: constantColor.blueColor,
      unSelectedColor: constantColor.whiteColor,
      strokeColor: constantColor.blueColor,
      scaleFactor: 0.5,
      iconSize: 30.0,
      onTap: (val) {
        index = val;
        pageController.jumpToPage(val);
        notifyListeners();
      },
      backgroundColor: Colors.black54,
      items: [
        CustomNavigationBarItem(icon: Icon(EvaIcons.home)),
        CustomNavigationBarItem(
            icon: CircleAvatar(
          radius: 35.0,
          backgroundColor: constantColor.blueGreyColor,
          backgroundImage: NetworkImage(
              Provider.of<FirebaseOperation>(context, listen: false)
                  .getInitUserImage),
        )),
      ],
    );
  }
}
