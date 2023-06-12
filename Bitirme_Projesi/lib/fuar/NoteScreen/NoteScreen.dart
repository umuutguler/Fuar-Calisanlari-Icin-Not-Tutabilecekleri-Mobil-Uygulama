import 'package:bitirme_projesi/fuar/Interview/CompanyInterview.dart';
import 'package:bitirme_projesi/fuar/NoteScreen/ses_girisi.dart';
import 'package:bitirme_projesi/fuar/NoteScreen/text_girisi.dart';
import 'package:bitirme_projesi/fuar/constants/Constantscolors.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'image_girisi.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  ConstantColor constantColor = ConstantColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constantColor.darkColor,
        title: Text("Not Ekranı"),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: CompanyInterview(),
                    type: PageTransitionType.bottomToTop));
          },
        ),
      ),
      body: Container(
        color: constantColor.blueGreyColor,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: constantColor.greyColor,
                    onPrimary: constantColor.greyColor,
                    shadowColor: Colors.grey[400],
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: SpeechScreen(),
                            type: PageTransitionType.bottomToTop));
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check,
                          size: 30,
                          color: constantColor.lightBlueColor,
                        ),
                        Text(
                          "Sesten Metin Girişi",
                          style: TextStyle(
                              fontSize: 13,
                              color: constantColor.lightBlueColor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: constantColor.greyColor,
                    onPrimary: constantColor.greyColor,
                    shadowColor: Colors.grey[400],
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: TextScreen(),
                            type: PageTransitionType.bottomToTop));
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check,
                          size: 30,
                          color: constantColor.lightBlueColor,
                        ),
                        Text(
                          "Klavye ile Giriş",
                          style: TextStyle(
                              fontSize: 13,
                              color: constantColor.lightBlueColor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: constantColor.greyColor,
                    onPrimary: constantColor.greyColor,
                    shadowColor: Colors.grey[400],
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: ImageGirisi(),
                            type: PageTransitionType.bottomToTop));
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check,
                          size: 30,
                          color: constantColor.lightBlueColor,
                        ),
                        Text(
                          "Görüntüden Metin Girişi",
                          style: TextStyle(
                              fontSize: 13,
                              color: constantColor.lightBlueColor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
