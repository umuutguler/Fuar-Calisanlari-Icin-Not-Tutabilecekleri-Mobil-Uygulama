import 'package:bitirme_projesi/fuar/Interview/CompanyInterview.dart';
import 'package:bitirme_projesi/home.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../Utils/UploadPost.dart';
import '../../constants/Constantscolors.dart';
import 'FeedHelpers.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConstantColor constantColor = ConstantColor();
    return Scaffold(
        backgroundColor: constantColor.blueGreyColor,
        body: Provider.of<FeedHelper>(context, listen: false).AccordionList(),
        drawer: Drawer(
          backgroundColor: constantColor.blueGreyColor,
          child: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                DrawerHeader(
                  child: Center(
                    child: RichText(
                        text: TextSpan(
                            text: "AP",
                            style: TextStyle(
                                color: constantColor.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                            children: <TextSpan>[
                          TextSpan(
                            text: "2022-2023",
                            style: TextStyle(
                                color: constantColor.blueColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          ),
                        ])),
                  ),
                  decoration: BoxDecoration(color: constantColor.darkColor),
                ),
                ExpansionTile(
                  title: Text("Fuar görüşmesi"),
                  leading: Icon(Icons.person), //add icon
                  childrenPadding: EdgeInsets.only(left: 60), //children padding
                  children: [
                    ListTile(
                      title: Text("Şahıs görüşmesi"),
                      onTap: () {
                        //action on press
                      },
                    ),

                    ListTile(
                      title: Text("Şirket Görüşmesi"),
                      onTap: () {
                        //action on press
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: CompanyInterview(),
                                type: PageTransitionType.bottomToTop));
                      },
                    ),
                    ListTile(
                      title: Text("Diğer"),
                      onTap: () {
                        //action on press
                      },
                    ),

                    //more child menu
                  ],
                ),
                ExpansionTile(
                  title: Text("İş görüşmesi"),
                  leading: Icon(Icons.person), //add icon
                  childrenPadding: EdgeInsets.only(left: 60), //children padding
                  children: [
                    ListTile(
                      title: Text("Cari giriş"),
                      onTap: () {
                        //action on press
                      },
                    ),

                    ListTile(
                      title: Text("Not alma"),
                      onTap: () {
                        //action on press
                      },
                    ),

                    //more child menu
                  ],
                ),
                ExpansionTile(
                  title: Text("Banka görüşmesi"),
                  leading: Icon(Icons.person), //add icon
                  childrenPadding: EdgeInsets.only(left: 60), //children padding
                  children: [
                    ListTile(
                      title: Text("Cari giriş"),
                      onTap: () {
                        //action on press
                      },
                    ),

                    ListTile(
                      title: Text("Not alma"),
                      onTap: () {
                        //action on press
                      },
                    ),

                    //more child menu
                  ],
                ),
                ExpansionTile(
                  title: Text("Emlak görüşmesi"),
                  leading: Icon(Icons.person), //add icon
                  childrenPadding: EdgeInsets.only(left: 60), //children padding
                  children: [
                    ListTile(
                      title: Text("Cari giriş"),
                      onTap: () {
                        //action on press
                      },
                    ),

                    ListTile(
                      title: Text("Not alma"),
                      onTap: () {
                        //action on press
                      },
                    ),

                    //more child menu
                  ],
                ),
                ExpansionTile(
                  title: Text("Lojistik görüşmesi"),
                  leading: Icon(Icons.person), //add icon
                  childrenPadding: EdgeInsets.only(left: 60), //children padding
                  children: [
                    ListTile(
                      title: Text("Cari giriş"),
                      onTap: () {
                        //action on press
                      },
                    ),

                    ListTile(
                      title: Text("Not alma"),
                      onTap: () {
                        //action on press
                      },
                    ),

                    //more child menu
                  ],
                ),
                ExpansionTile(
                  title: Text("Tedarik görüşmesi"),
                  leading: Icon(Icons.person), //add icon
                  childrenPadding: EdgeInsets.only(left: 60), //children padding
                  children: [
                    ListTile(
                      title: Text("Cari giriş"),
                      onTap: () {
                        //action on press
                      },
                    ),

                    ListTile(
                      title: Text("Not alma"),
                      onTap: () {
                        //action on press
                      },
                    ),

                    //more child menu
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                )
              ],
            ),
          )),
        ),
        appBar: AppBar(
          backgroundColor: constantColor.darkColor.withOpacity(0.6),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.camera_alt_outlined),
              onPressed: () {
                Provider.of<UploadPost>(context, listen: false)
                    .selectPostImageType(context);
              },
            )
          ],
          title: RichText(
            text: TextSpan(
                text: 'AP',
                style: TextStyle(
                  color: constantColor.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '2022-2023',
                    style: TextStyle(
                      color: constantColor.blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                ]),
          ),
        ));
  }
}
