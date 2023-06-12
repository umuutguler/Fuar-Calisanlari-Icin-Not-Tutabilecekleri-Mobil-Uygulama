import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomePage/HomePage.dart';
import '../LandingPage/LandingPage.dart';

class Authentication with ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String? userUid;
  String? get getUserUid => userUid;

  Future logInToAccount(
      String email, String password, BuildContext context) async {
        
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);


    /*  if (email.isEmpty||password.isEmpty) {
     Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    } else {
      Navigator.pushReplacement(
            context,
            PageTransition(
                child: HomePage(), type: PageTransitionType.bottomToTop));
    }  */

    /* firebaseAuth.authStateChanges().listen((firebaseAuth) {
      if (firebaseAuth == null) {
        print('User is currently signed out!');
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: LandingPage(), type: PageTransitionType.bottomToTop));
      } else {
        print('User is signed in!');
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: HomePage(), type: PageTransitionType.bottomToTop));
      }
     }) as FirebaseAuth;     
 */

    User? user = userCredential.user;
    userUid = user?.uid;
    print(userUid);
    notifyListeners();
  }

  Future logOutViaEmail() async {
    return firebaseAuth.signOut();
  }

  Future createAccount(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;
    userUid = user?.uid;
    print("Created user Uid => $userUid");
    notifyListeners();
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken);
    final UserCredential userCredential =
        await firebaseAuth.signInWithCredential(authCredential);
    final User? user = userCredential.user;
    assert(user?.uid != null);

    userUid = user?.uid;
    print('Google User uid => $userUid');
    notifyListeners();
  }

  Future signOutWithGoogle() async {
    return googleSignIn.signOut();
  }

  /* void navigateUser(BuildContext context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var status = prefs.getBool('isLoggedIn') ?? true;
      print(status);
      if (status) {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: const HomePage(), type: PageTransitionType.bottomToTop));
      } else {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: LandingPage(), type: PageTransitionType.bottomToTop));
      }
    } */
}
