import 'dart:convert';
import 'package:bitirme_projesi/constants.dart';
import 'package:flutter/material.dart';
import 'webview.dart';
import 'chrometab.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bitirme_projesi/fuar/HomePage/HomePage.dart';

class LoginPage extends StatefulWidget {
  final String yetki;
  const LoginPage({Key? key, required this.yetki});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _yetki;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _yetki = widget.yetki;
  }

///// Giriş yapıldı mı Bilgisini tutmak için
  Future<void> saveLoginStatus(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> saveCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final data = {
      'username': _usernameController.text.trim(),
      'password': _passwordController.text.trim(),
    };
    saveCredentials(_usernameController.text.trim(),
        _passwordController.text.trim()); // username ve kullanıcı adını kaydet

    try {
      final response = await http.post(
        Uri.parse('http://api-cbn.edu.ciloglunet.com/login'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: data,
      );
      final responseData = json.decode(response.body);
      
      print(responseData);
      print(responseData.runtimeType);

      List<dynamic> dataArray = responseData.values.toList();
      print(dataArray[0]);
      print(dataArray.runtimeType);
      print(dataArray[0].runtimeType);

      if (dataArray[0] == true) {
        if (_yetki == 'Fuar') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Webview(),
            ),
          );
          ///// Giriş yapıldı olarak ayarla
          saveLoginStatus(false); // ---------------- >    true olarak deiştir
        }
      } else {
        throw ('Giriş bilgileri eksik ya da yanlış girdiniz');
      }
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Kullanıcı Adı',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Şifre',
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Giriş'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
