import 'package:bitirme_projesi/fuar/constants/Constantscolors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'NoteScreen.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  TextEditingController? text;
  ConstantColor constantColor = ConstantColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constantColor.darkColor,
        title: Text("Text input"),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: NoteScreen(), type: PageTransitionType.bottomToTop));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Card(
                color: Colors.grey.shade100,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      maxLines: 15,
                      controller: text,
                      decoration: const InputDecoration(
                          hintText: "Yazı girişi",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade200,
                onPrimary: Colors.grey,
                shadowColor: Colors.grey[400],
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              onPressed: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check,
                      size: 30,
                    ),
                    Text(
                      "Kaydet",
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
