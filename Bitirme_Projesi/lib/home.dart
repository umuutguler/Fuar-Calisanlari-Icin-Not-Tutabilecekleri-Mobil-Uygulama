import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'webview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bitirme_projesi/fuar/HomePage/HomePage.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Future<void> saveLoginStatus(bool isLoggedIn) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', isLoggedIn);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    children: [
                      Text(
                        "Uygulamalar",
                        style: TextStyle(
                            fontSize: 40,
                            color: Color.fromARGB(192, 48, 48, 48)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: size.width / 3,
                        width: size.width / 3,
                        child: Image.asset('assets/icon.png'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Aşağıda hesabınıza tanımlı olan uygulamalar ile şimdi çalışmaya başlayabilirsiniz.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(210, 110, 110, 110),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )),
              ),

              /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              Container(
                //1
                height: size.width / 2,
                width: size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Module(
                      imagePath: 'assets/fuar.svg',
                      text: 'Fuar',
                      size: size,
                      key: key,
                      destination: HomePage(),
                    ),
                    Module(
                      imagePath: 'assets/coban.svg',
                      text: 'Çoban',
                      size: size,
                      key: key,
                      destination: Webview(),
                    ),
                  ],
                ),
              ),
              Container(
                //2
                height: size.width / 2,
                width: size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Module(
                      imagePath: 'assets/mera.svg',
                      text: 'Mera',
                      size: size,
                      key: key,
                      destination: Webview(),
                    ),
                    Module(
                      imagePath: 'assets/biber.svg',
                      text: 'Biber',
                      size: size,
                      key: key,
                      destination: Webview(),
                    ),
                  ],
                ),
              ),
              Container(
                //3
                height: size.width / 2,
                width: size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Module(
                      imagePath: 'assets/tohum.svg',
                      text: 'Tohum',
                      size: size,
                      key: key,
                      destination: Webview(),
                    ),
                    Module(
                      imagePath: 'assets/ihatek.svg',
                      text: 'Ihatek',
                      size: size,
                      destination: Webview(),
                    ),
                  ],
                ),
              ),
              Container(
                //4
                height: size.width / 2,
                width: size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Module(
                      imagePath: 'assets/petek.svg',
                      text: 'Petek',
                      size: size,
                      destination: Webview(),
                    ),
                    Module(
                      imagePath: 'assets/marktech.svg',
                      text: 'MarkTech',
                      size: size,
                      destination: Webview(),
                    ),
                  ],
                ),
              ),
              Container(
                //5
                height: size.width / 2,
                width: size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Module(
                      imagePath: 'assets/blank.svg',
                      text: 'Selftech',
                      size: size,
                      destination: Webview(),
                    ),
                    Module(
                      imagePath: 'assets/blank.svg',
                      text: '8K',
                      size: size,
                      destination: Webview(),
                    ),
                  ],
                ),
              ),
              Container(
                //6
                height: size.width / 2,
                width: size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Module(
                      imagePath: 'assets/fafactor.svg',
                      text: 'Fa Factor',
                      size: size,
                      destination: Webview(),
                    ),
                    Module(
                      imagePath: 'assets/gumruk.svg',
                      text: 'Gümrük',
                      size: size,
                      destination: Webview(),
                    ),
                  ],
                ),
              ),
              Container(
                //7
                height: size.width / 2,
                width: size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Module(
                      imagePath: 'assets/rapor.svg',
                      text: 'Rapor',
                      size: size,
                      destination: Webview(),
                    ),
                    Module(
                      imagePath: 'assets/blank.svg',
                      text: 'Meeting',
                      size: size,
                      destination: Webview(),
                    ),
                  ],
                ),
              ),
              Container(
                //8
                height: size.width / 2,
                width: size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Module(
                      imagePath: 'assets/mobivisor.svg',
                      text: 'MobiVisor',
                      size: size,
                      destination: Webview(),
                    ),
                    Module(
                      imagePath: 'assets/blank.svg',
                      text: 'Lojistik',
                      size: size,
                      destination: Webview(),
                    ),
                  ],
                ),
              ),
              Container(
                //8
                height: size.width / 2,
                width: size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Module(
                      imagePath: 'assets/blank.svg',
                      text: 'Ekin',
                      size: size,
                      destination: Webview(),
                    ),
                    Module(
                      imagePath: 'assets/blank.svg',
                      text: 'World Etiket',
                      size: size,
                      destination: LoginPage(yetki: ''),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Module extends StatelessWidget {
  final String imagePath;
  final String text;
  final Size size;
  final Widget destination; // Eklenen destination parametresi

  const Module({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.size,
    required this.destination, // Eklenen destination parametresi
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imagePath,
              height: size.width / 4.5,
              width: size.width / 4.5,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(183, 44, 44, 44)),
            )
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
                width: 1.0, color: Color.fromARGB(255, 190, 190, 190)),
          ),
          elevation: 0.0,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
      ),
    ));
  }
}
