import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Services/Authentication.dart';
import '../../constants/Constantscolors.dart';

class FeedHelper with ChangeNotifier {
  ConstantColor constantColor = ConstantColor();

  /*Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: constantColor.darkColor.withOpacity(0.6),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.camera_alt_outlined),
          onPressed: (){

          },
        )
      ],
      title: RichText(
        text: TextSpan(
            text: 'The',
            style: TextStyle(
              color: constantColor.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Ull',
                style: TextStyle(
                  color: constantColor.blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
            ]),
      ),
    );
  }*/

  Widget feedBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          // ignore: sort_child_properties_last
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("posts").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // ignore: prefer_const_constructors
                return Center(
                  child: const SizedBox(
                    height: 300,
                    width: 400,
                    //child: Lottie.asset("name")
                  ),
                );
              } else {
                return loadPosts(context, snapshot);
              }
              throw "";
            },
          ),
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: constantColor.darkColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0))),
        ),
      ),
    );
  }

  Widget loadPosts(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView(
        children: snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.69,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: Row(
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: constantColor.transparent,
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        documentSnapshot.get("userImage"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Text(
                              documentSnapshot.get("caption"),
                              style: TextStyle(
                                  color: constantColor.greenColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                                child: RichText(
                              text: TextSpan(
                                  text: documentSnapshot.get("username"),
                                  style: TextStyle(
                                      color: constantColor.blueColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' , 12 hours ago',
                                        style: TextStyle(
                                            color: constantColor.lightColor
                                                .withOpacity(0.8)))
                                  ]),
                            )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                documentSnapshot.get("postImage"),
                scale: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  child: Row(
                    children: [
                      /*  GestureDetector(
                        onTap: () {
                          print("Adding Like.......");
                          Provider.of<PostFunction>(context, listen: false)
                              .addLike(
                                  context,
                                  documentSnapshot.get("caption"),
                                  Provider.of<Authentication>(context,
                                          listen: false)
                                      .getUserUid!);
                        },
                        child: Icon(
                          FontAwesomeIcons.heart,
                          color: constantColor.redColor,
                          size: 22,
                        ),
                      ), */
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('posts')
                            .doc(documentSnapshot.get("caption"))
                            .collection("likes")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                snapshot.data!.docs.length.toString(),
                                style: TextStyle(
                                    color: constantColor.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /*  GestureDetector(
                        onTap: () {
                          Provider.of<PostFunction>(context, listen: false)
                              .showCommentsSheet(context, documentSnapshot,
                                  documentSnapshot.get("caption"));
                        },
                        child: Icon(
                          FontAwesomeIcons.comment,
                          color: constantColor.blueColor,
                          size: 22,
                        ),
                      ), */
                      Text(
                        '0',
                        style: TextStyle(
                            color: constantColor.blueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Icon(
                          FontAwesomeIcons.award,
                          color: constantColor.yellowColor,
                          size: 22,
                        ),
                      ),
                      Text(
                        '0',
                        style: TextStyle(
                            color: constantColor.yellowColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Provider.of<Authentication>(context, listen: false)
                            .getUserUid ==
                        documentSnapshot.get("useruid")
                    ? IconButton(
                        icon: Icon(EvaIcons.moreVertical),
                        onPressed: () {},
                      )
                    : Container(
                        width: 0.0,
                        height: 0.0,
                      )
              ],
            ),
            Divider(
              thickness: 1.0,
              color: constantColor.lightBlueColor,
            ),
          ],
        ),
      );
    }).toList());
  }

  Widget AccordionList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Text("Notlar",style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: 24,color: constantColor.blueColor
            ),),
          ),
          GFAccordion(
            collapsedIcon: Icon(Icons.add),
            expandedIcon: Icon(Icons.minimize),
            title: "What is Lorem Ipsum?",
            content:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          ),
          GFAccordion(
            collapsedIcon: Icon(Icons.add),
            expandedIcon: Icon(Icons.minimize),
            title: "Where does it come from?",
            content:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          ),
          GFAccordion(
            collapsedIcon: Icon(Icons.add),
            expandedIcon: Icon(Icons.minimize),
            title: "Why do we use it?",
            content:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          ),
          GFAccordion(
            collapsedIcon: Icon(Icons.add),
            expandedIcon: Icon(Icons.minimize),
            title: "What is Lorem Ipsum?",
            content:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          ),
          GFAccordion(
            collapsedIcon: Icon(Icons.add),
            expandedIcon: Icon(Icons.minimize),
            title: "Where can I get some?",
            content:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          ),
          GFAccordion(
            collapsedIcon: Icon(Icons.add),
            expandedIcon: Icon(Icons.minimize),
            title: "Where can I get some?",
            content:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          ),
          GFAccordion(
            collapsedIcon: Icon(Icons.add),
            expandedIcon: Icon(Icons.minimize),
            title: "Where can I get some?",
            content:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          ),
          GFAccordion(
            collapsedIcon: Icon(Icons.add),
            expandedIcon: Icon(Icons.minimize),
            title: "Where can I get some?",
            content:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          ),
          GFAccordion(
            collapsedIcon: Icon(Icons.add),
            expandedIcon: Icon(Icons.minimize),
            title: "Where can I get some?",
            content:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          ),
          GFAccordion(
            collapsedIcon: Icon(Icons.add),
            expandedIcon: Icon(Icons.minimize),
            title: "Where can I get some?",
            content:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          ),
          
        ],
      ),
    );
  }
}
