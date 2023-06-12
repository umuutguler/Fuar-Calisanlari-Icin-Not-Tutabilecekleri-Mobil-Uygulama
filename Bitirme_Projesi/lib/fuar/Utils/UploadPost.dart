import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import '../Services/Authentication.dart';
import '../Services/FirebaseOperation.dart';
import '../constants/Constantscolors.dart';


class UploadPost with ChangeNotifier {
  ConstantColor constantColor = ConstantColor();
  TextEditingController captionController = TextEditingController();
  final picker = ImagePicker();
  late File uploadPostImage;
  File get getUploadPostImage => uploadPostImage;
  String? uploadPostImageUrl;
  String? get getUploadPostImageUrl => uploadPostImageUrl;
  UploadTask? imagePostUploadTask;

  Future pickUploadPost(BuildContext context, ImageSource source) async {
    final uploadPostImageVal = await picker.pickImage(source: source);
    uploadPostImageVal == null
        ? print("Select Image")
        : uploadPostImage = File(uploadPostImageVal.path);
    print(uploadPostImageVal!.path);

    uploadPostImage != null
        ? sshowPostImageType(context)
        : print('Image upload error');

    notifyListeners();
  }

  Future uploadPostImageToFirebase() async {
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child('posts/${uploadPostImage.path}/${TimeOfDay.now()}');

    imagePostUploadTask = imageReference.putFile(uploadPostImage);
    await imagePostUploadTask!.whenComplete(() {
      print('Post image uploaded to storage');
    });
    imageReference.getDownloadURL().then((imageUrl) {
      uploadPostImageUrl = imageUrl;
      print(uploadPostImage);
    });
    notifyListeners();
  }

  selectPostImageType(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColor.blueGreyColor,
                borderRadius: BorderRadius.circular(12.0)),
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
                    MaterialButton(
                      color: constantColor.blueColor,
                      child: Text(
                        'Gallery',
                        style: TextStyle(
                            color: constantColor.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      onPressed: () {
                        pickUploadPost(context, ImageSource.gallery);
                      },
                    ),
                    MaterialButton(
                      color: constantColor.blueColor,
                      child: Text(
                        'Camera',
                        style: TextStyle(
                            color: constantColor.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      onPressed: () {
                        pickUploadPost(context, ImageSource.camera);
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  sshowPostImageType(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColor.darkColor,
                borderRadius: BorderRadius.circular(12.0)),
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
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(
                      uploadPostImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Row(
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
                        selectPostImageType(context);
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
                        uploadPostImageToFirebase().whenComplete(() {
                          editPostSheet(context);
                          print("image uploaded");
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  editPostSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
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
                Container(
                  child: Row(children: [
                    Container(
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.image_aspect_ratio,
                              color: constantColor.greenColor,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.fit_screen,
                              color: constantColor.greenColor,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      child: Image.file(
                        uploadPostImage,
                        fit: BoxFit.contain,
                      ),
                    )
                  ]),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: Image.asset("assets/images/login1.jpg"),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 110.0,
                  width: 200,
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    maxLines: 5,
                    inputFormatters: [LengthLimitingTextInputFormatter(100)],
                    maxLength: 100,
                    controller: captionController,
                    style: TextStyle(
                        color: constantColor.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        hintText: "Add A Caption...",
                        hintStyle: TextStyle(
                            color: constantColor.whiteColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                MaterialButton(
                  child: Text(
                    'Share',
                    style: TextStyle(
                        color: constantColor.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  onPressed: () async {
                    Provider.of<FirebaseOperation>(context, listen: false)
                        .uploadPostData(captionController.text, {
                      'postImage':getUploadPostImageUrl,
                      'caption': captionController.text,
                      'username':
                          Provider.of<FirebaseOperation>(context, listen: false)
                              .getInitUserName,
                      'userImage':
                          Provider.of<FirebaseOperation>(context, listen: false)
                              .getInitUserImage,
                      'useruid':
                          Provider.of<Authentication>(context, listen: false)
                              .getUserUid,
                      'time': Timestamp.now(),
                      'useremail':
                          Provider.of<FirebaseOperation>(context, listen: false)
                              .getInitUserEmail
                    }).whenComplete(() {
                      Navigator.pop(context);
                    });
                  },
                  color: constantColor.blueColor,
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColor.blueGreyColor,
                borderRadius: BorderRadius.circular(12.0)),
          );
        });
  }
}
