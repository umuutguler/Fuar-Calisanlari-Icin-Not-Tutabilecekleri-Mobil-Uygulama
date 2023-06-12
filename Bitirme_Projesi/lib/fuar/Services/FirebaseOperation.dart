import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../LandingPage/LandingUtils.dart';
import 'Authentication.dart';

class FirebaseOperation with ChangeNotifier {
  UploadTask? imageUploadTask;
  String? initUserName, initUserEmail, initUserImage;
  String? get getInitUserName => initUserName;
  String? get getInitUserEmail => initUserEmail;
  String get getInitUserImage => initUserImage =
      "https://firebasestorage.googleapis.com/v0/b/ap-2022-23.appspot.com/o/userProfileAvatar%2Fdata%2Fuser%2F0%2Fcom.example.ap_2022_23%2Fcache%2Fimage_picker995746518570874218.jpg%2FTimeOfDay(10%3A42)?alt=media&token=696b03c7-6d51-4a31-b0a5-a69792df6ca0";

  Future uploadUserAvatar(BuildContext context) async {
    Reference imageRefrence = FirebaseStorage.instance.ref().child(
        'userProfileAvatar/${Provider.of<LandingUtils>(context, listen: false).getUserAvatar.path}/${TimeOfDay.now()}');

    imageUploadTask = imageRefrence.putFile(
        Provider.of<LandingUtils>(context, listen: false).getUserAvatar);

    await imageUploadTask?.whenComplete(() {
      print('Image Uploaded');
    });

    imageRefrence.getDownloadURL().then((url) {
      Provider.of<LandingUtils>(context, listen: false).userAvatarUrl =
          url.toString();
      print(
          "The user profile avatar url =>${Provider.of<LandingUtils>(context, listen: false).userAvatarUrl}");
      notifyListeners();
    });
  }

  Future createUserCollection(BuildContext buildContext, dynamic data) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(
            Provider.of<Authentication>(buildContext, listen: false).getUserUid)
        .set(data);
  }

  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection("posts").doc(postId).set(data);
  }

  Future deleteUserData(String useruid) {
    return FirebaseFirestore.instance.collection("users").doc(useruid).delete();
  }
}
