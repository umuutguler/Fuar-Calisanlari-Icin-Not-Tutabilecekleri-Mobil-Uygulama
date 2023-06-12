import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../HomePage/HomePage.dart';
import '../Services/Authentication.dart';
import '../constants/Constantscolors.dart';

import 'LandingServices.dart';
import 'LandingUtils.dart';

class LandingHelpers with ChangeNotifier {
  ConstantColor constantColor = ConstantColor();

  Widget bodyImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,

      /*decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage("assets/images/login1.jpg"))), */
    );
  }

  Widget mainButton(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.35,
      child: Container(
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.,
          children: [
            GestureDetector(
              onTap: () {
                emailAuthSheet(context);
              },
              child: Container(
                child: Icon(
                  EvaIcons.emailOutline,
                  color: constantColor.yellowColor,
                ),
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: constantColor.yellowColor),
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            Padding(padding: EdgeInsets.all(50.0)),
            GestureDetector(
              onTap: () {
                print("Signing with google");
                Provider.of<Authentication>(context, listen: false)
                    .signInWithGoogle()
                    .whenComplete(() {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: HomePage(),
                          type: PageTransitionType.leftToRight));
                });
              },
              child: Container(
                child: Icon(
                  FontAwesomeIcons.google,
                  color: constantColor.redColor,
                ),
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: constantColor.redColor),
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            Padding(padding: EdgeInsets.all(50.0)),
            GestureDetector(
              child: Container(
                child: Icon(
                  FontAwesomeIcons.facebook,
                  color: constantColor.blueColor,
                ),
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: constantColor.blueColor),
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            Padding(padding: EdgeInsets.all(50.0)),
          ],
        ),
      ),
    );
  }

  Widget privacyText(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.90,
      left: 20.0,
      right: 20,
      child: Container(
        child: Column(
          children: [
            Text(
              "By continuing you agree Ull's Terms of",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12.0),
            ),
            Text(
              "Services & Privacy Policy",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }

  emailAuthSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            // ignore: sort_child_properties_last
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColor.whiteColor,
                  ),
                ),
                Provider.of<LandingServices>(context, listen: false)
                    .passwordLessSignIn(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      color: constantColor.blueColor,
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            color: constantColor.whiteColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {

                        
                        Provider.of<LandingServices>(context, listen: false)
                            .logInSheet(context);
                      },
                    ),
                    MaterialButton(
                      color: constantColor.redColor,
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            color: constantColor.whiteColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Provider.of<LandingUtils>(context, listen: false)
                            .selectAvatarOptionsShhet(context);
                      },
                    ),
                  ],
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColor.blueGreyColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
          );
        });
  }
}
