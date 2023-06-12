// ignore_for_file: prefer_const_constructors

import 'package:bitirme_projesi/fuar/NoteScreen/NoteScreen.dart';
import 'package:bitirme_projesi/fuar/Screens/Feed/Feed.dart';
import 'package:bitirme_projesi/fuar/VoiceRecorder/views/recorder_home_view.dart';
import 'package:bitirme_projesi/fuar/constants/Constantscolors.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CompanyInterview extends StatelessWidget {
  CompanyInterview({Key? key}) : super(key: key);
  ConstantColor constantColor = ConstantColor();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: constantColor.darkColor,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(EvaIcons.arrowBack),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: Feed(),
                  type: PageTransitionType.bottomToTop,
                ),
              );
            },
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Mevcut cari"),
              ),
              Tab(
                child: Text("Yeni cari"),
              ),
            ],
          ),
          title: Text('Şirket Görüşmesi'),
        ),
        body: TabBarView(
          children: [
            Container(
              color: constantColor.blueGreyColor,
              child: GridView.count(
                padding: EdgeInsets.symmetric(
                  vertical: (MediaQuery.of(context).size.height * 0.1),
                ),
                crossAxisSpacing: 1,
                mainAxisSpacing: 2,
                crossAxisCount: 2,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialogMisafirBilgileri(context),
                      );
                    },
                    child: Card(
                      color: constantColor.greyColor,
                      child: Center(
                          child: Text("Misafir bilgileri",
                              style: TextStyle(
                                  color: constantColor.lightBlueColor))),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialogFirmaBilgileri(context),
                      );
                    },
                    child: Card(
                      color: constantColor.greyColor,
                      child: Center(
                          child: Text("Firma bilgileri",
                              style: TextStyle(
                                  color: constantColor.lightBlueColor))),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialogUrunBilgileri(context),
                      );
                    },
                    child: Card(
                      color: constantColor.greyColor,
                      child: Center(
                          child: Text("Ürün bilgileri",
                              style: TextStyle(
                                  color: constantColor.lightBlueColor))),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialogNotGirisi(context),
                      );
                    },
                    child: Card(
                      color: constantColor.greyColor,
                      child: Center(
                          child: Text("Yorum ve notlar",
                              style: TextStyle(
                                  color: constantColor.lightBlueColor))),
                    ),
                  )
                ],
              ),
            ),
            Text("Yeni cari bilgi"),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupDialogNotGirisi(BuildContext context) {
    return AlertDialog(
      backgroundColor: constantColor.blueGreyColor,
      title: Center(
        child: const Text(
          'Yorum ve Notlar',
          style: TextStyle(color: Colors.lightBlue),
        ),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.7,
        child: GridView.count(
          crossAxisSpacing: 1,
          mainAxisSpacing: 2,
          crossAxisCount: 2,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: NoteScreen(),
                    type: PageTransitionType.bottomToTop,
                  ),
                );
              },
              child: Card(
                color: constantColor.greyColor,
                child: Center(
                  child: Text(
                    "Not girişi",
                    style: TextStyle(color: constantColor.lightBlueColor),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: RecorderHomeView(title: "Ses Kaydı Ekranı"),
                    type: PageTransitionType.bottomToTop,
                  ),
                );
              },
              child: Card(
                color: constantColor.greyColor,
                child: Center(
                  child: Text(
                    "Ses kaydı",
                    style: TextStyle(color: constantColor.lightBlueColor),
                  ),
                ),
              ),
            ),
            Card(
              color: constantColor.greyColor,
              child: Center(
                child: Text(
                  "Video kaydı",
                  style: TextStyle(color: constantColor.lightBlueColor),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Card(
                color: constantColor.greyColor,
                child: Center(
                  child: Text(
                    "Resim ve dosya",
                    style: TextStyle(color: constantColor.lightBlueColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      contentPadding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
      ),
    );
  }

  Widget _buildPopupDialogMisafirBilgileri(BuildContext context) {
    return Dialog(
      backgroundColor: constantColor.blueGreyColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Misafir Bilgileri',
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: constantColor.greyColor,
                    child: Center(
                      child: Text(
                        "Misafir Data 1",
                        style: TextStyle(
                          color: constantColor.lightBlueColor,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: constantColor.greyColor,
                    child: Center(
                      child: Text(
                        "Misafir Data 2",
                        style: TextStyle(
                          color: constantColor.lightBlueColor,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: constantColor.greyColor,
                    child: Center(
                      child: Text(
                        "Misafir Data 3",
                        style: TextStyle(
                          color: constantColor.lightBlueColor,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: constantColor.greyColor,
                    child: Center(
                      child: Text(
                        "Misafir Data 4",
                        style: TextStyle(
                          color: constantColor.lightBlueColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupDialogUrunBilgileri(BuildContext context) {
    return Dialog(
      backgroundColor: constantColor.blueGreyColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ürün Bilgileri',
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: constantColor.greyColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Ürün Data 1",
                          style: TextStyle(
                            color: constantColor.lightBlueColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: constantColor.greyColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Ürün Data 2",
                        style: TextStyle(
                          color: constantColor.lightBlueColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: constantColor.greyColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Ürün Data 3",
                        style: TextStyle(
                          color: constantColor.lightBlueColor,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: constantColor.greyColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Ürün Data 4",
                          style: TextStyle(
                            color: constantColor.lightBlueColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupDialogFirmaBilgileri(BuildContext context) {
    return Dialog(
      backgroundColor: constantColor.blueGreyColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Firma Bilgileri',
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: constantColor.greyColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Firma Data 1",
                          style: TextStyle(
                            color: constantColor.lightBlueColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: constantColor.greyColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Firma Data 2",
                        style: TextStyle(
                          color: constantColor.lightBlueColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: constantColor.greyColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Firma Data 3",
                        style: TextStyle(
                          color: constantColor.lightBlueColor,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: constantColor.greyColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Firma Data 4",
                          style: TextStyle(
                            color: constantColor.lightBlueColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
