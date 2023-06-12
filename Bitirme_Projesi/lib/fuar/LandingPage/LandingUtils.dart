import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import '../constants/Constantscolors.dart';
import 'LandingServices.dart';

class LandingUtils with ChangeNotifier {
  ConstantColor constantColor = ConstantColor();
  final picker = ImagePicker();
  late File userAvatar;
  File get getUserAvatar => userAvatar;
  String? userAvatarUrl;
  String? get getUserAvatarUrl => userAvatarUrl;

  Future pickUserAvatar(BuildContext context, ImageSource source) async {
    final pickedUserAvatar = await picker.pickImage(source: source);
    pickedUserAvatar == null
        ? print("Select Image")
        : userAvatar = File(pickedUserAvatar.path);
    print(userAvatar.path);

    userAvatar != null
        ? Provider.of<LandingServices>(context, listen: false)
            .showUserAvatar(context)
        : print('Image upload error');

    notifyListeners();
  }

  Future selectAvatarOptionsShhet(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColor.whiteColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: MaterialButton(
                        color: constantColor.blueColor,
                        child: Text(
                          "Gallery",
                          style: TextStyle(
                              color: constantColor.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        onPressed: () {
                          pickUserAvatar(context, ImageSource.gallery)
                              .whenComplete(() {
                            Navigator.pop(context);
                            Provider.of<LandingServices>(context, listen: false)
                                .showUserAvatar(context);
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: MaterialButton(
                        color: constantColor.blueColor,
                        child: Text(
                          "Camera",
                          style: TextStyle(
                              color: constantColor.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        onPressed: () {
                          pickUserAvatar(context, ImageSource.camera)
                              .whenComplete(() {
                            Navigator.pop(context);
                            Provider.of<LandingServices>(context, listen: false)
                                .showUserAvatar(context);
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            height: MediaQuery.of(context).size.width *0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColor.blueGreyColor,
                borderRadius: BorderRadius.circular(12.0)),
          );
        });
  }
}
