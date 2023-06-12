// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomePage/HomePage.dart';
import '../Services/Authentication.dart';
import '../Services/FirebaseOperation.dart';
import '../constants/Constantscolors.dart';
import 'LandingUtils.dart';

class LandingServices with ChangeNotifier {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  ConstantColor constantColor = ConstantColor();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  showUserAvatar(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 40,
            width: MediaQuery.of(context).size.width,
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
                CircleAvatar(
                  radius: 80.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: FileImage(
                      Provider.of<LandingUtils>(context, listen: false)
                          .userAvatar),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        child: Text(
                          "Reselect",
                          style: TextStyle(
                              color: constantColor.whiteColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: constantColor.whiteColor),
                        ),
                        onPressed: () {
                          Provider.of<LandingUtils>(context, listen: false)
                              .pickUserAvatar(context, ImageSource.gallery);
                        },
                      ),
                      MaterialButton(
                        color: constantColor.blueColor,
                        child: Text(
                          "Confirm Image ",
                          style: TextStyle(
                            color: constantColor.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Provider.of<FirebaseOperation>(context, listen: false)
                              .uploadUserAvatar(context)
                              .whenComplete(() {
                            signInSheet(context);
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: constantColor.blueGreyColor,
                borderRadius: BorderRadius.circular(15.0)),
          );
        });
  }

  Widget passwordLessSignIn(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot<Object> documentSnapshot) {
                return ListTile(
                  trailing: Container(
                    width:
                        120, //Buraya mutlaka bak responsive değillllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll!!!!!!!!!!!!!!!!!!!!
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.check,
                            color: constantColor.blueColor,
                          ),
                          onPressed: () {
                            Provider.of<Authentication>(context, listen: false)
                                .logInToAccount(
                                    //documentSnapshot.get("useruid"),
                                    documentSnapshot.get("username"),
                                    documentSnapshot.get("userpassword"),
                                    context)
                                .whenComplete(() {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: HomePage(),
                                      type: PageTransitionType.leftToRight));
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.trashCan,
                            color: constantColor.redColor,
                          ),
                          onPressed: () {
                            Provider.of<FirebaseOperation>(context,
                                    listen: false)
                                .deleteUserData(
                                    documentSnapshot.get("useruid"));
                          },
                        ),
                      ],
                    ),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: constantColor.darkColor,
                      backgroundImage: NetworkImage(
                          (documentSnapshot.data() as dynamic)["userImage"])),
                  subtitle: Text(
                    (documentSnapshot.data() as dynamic)["useremail"],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: constantColor.whiteColor,
                        fontSize: 12.0),
                  ),
                  title: Text(
                    (documentSnapshot.data() as dynamic)["username"],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: constantColor.greenColor),
                  ),
                );
              }).toList());
            }

            // throw "Tarihin en iyi flutter kodları";
          }),
    );
  }

  logInSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.50,
                width: MediaQuery.of(context).size.width,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        controller: userEmailController,
                        decoration: InputDecoration(
                          hintText: "enter email...",
                          hintStyle: TextStyle(
                              color: constantColor.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        style: TextStyle(
                            color: constantColor.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        controller: userPasswordController,
                        decoration: InputDecoration(
                          hintText: "enter password...",
                          hintStyle: TextStyle(
                              color: constantColor.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        style: TextStyle(
                            color: constantColor.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: constantColor.blueColor,
                      child: Icon(
                        FontAwesomeIcons.check,
                        color: constantColor.whiteColor,
                      ),
                      onPressed: () async {
                        if (userEmailController.text.isNotEmpty) {
                          Provider.of<Authentication>(context, listen: false)
                              .logInToAccount(userEmailController.text,
                                  userPasswordController.text,context)
                              .whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: HomePage(),
                                    type: PageTransitionType.bottomToTop));
                          });
                        } else {
                          warningText(context, 'Fill all the data!');
                        } },
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: constantColor.blueGreyColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0)))),
          );
        });
  }

  signInSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: constantColor.blueGreyColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: constantColor.whiteColor,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: FileImage(
                        Provider.of<LandingUtils>(context, listen: false)
                            .getUserAvatar),
                    backgroundColor: constantColor.redColor,
                    radius: 60.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        hintText: "enter name...",
                        hintStyle: TextStyle(
                            color: constantColor.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                        ),
                      style: TextStyle(
                          color: constantColor.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: userEmailController,
                      decoration: InputDecoration(
                        hintText: "enter email...",
                        hintStyle: TextStyle(
                            color: constantColor.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      style: TextStyle(
                          color: constantColor.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: userPasswordController,
                      decoration: InputDecoration(
                        hintText: "enter password...",
                        hintStyle: TextStyle(
                            color: constantColor.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      style: TextStyle(
                          color: constantColor.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: FloatingActionButton(
                      backgroundColor: constantColor.redColor,
                      child: Icon(
                        FontAwesomeIcons.check,
                        color: constantColor.whiteColor,
                      ),
                      onPressed: () {
                        if (userEmailController.text.isNotEmpty) {
                          Provider.of<Authentication>(context, listen: false)
                              .createAccount(userEmailController.text,
                                  userPasswordController.text)
                              .whenComplete(() {
                            print("Creating Collection");
                            Provider.of<FirebaseOperation>(context,
                                    listen: false)
                                .createUserCollection(context, {
                              'useruid': Provider.of<Authentication>(context,
                                      listen: false)
                                  .getUserUid,
                              'useremail': userEmailController.text,
                              'username': userNameController.text,
                              'userImage': Provider.of<LandingUtils>(context,
                                      listen: false)
                                  .getUserAvatarUrl
                            });
                          }).whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: HomePage(),
                                    type: PageTransitionType.bottomToTop));
                          });
                        } else {
                          warningText(context, 'Fill all the data!');
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  warningText(BuildContext context, String warning) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: constantColor.darkColor,
                borderRadius: BorderRadius.circular(15.0)),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                warning,
                style: TextStyle(
                    color: constantColor.whiteColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        });
  }
}
