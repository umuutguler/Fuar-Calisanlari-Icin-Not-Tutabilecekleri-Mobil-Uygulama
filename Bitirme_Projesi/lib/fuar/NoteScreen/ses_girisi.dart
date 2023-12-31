import 'package:bitirme_projesi/fuar/constants/Constantscolors.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:page_transition/page_transition.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'NoteScreen.dart';

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  ConstantColor constantColor = ConstantColor();

  final Map<String, HighlightedWord> _highlights = {
    'özge': HighlightedWord(
      onTap: () => print('flutter'),
      /* textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ), */
    ),
    'erdem': HighlightedWord(
      onTap: () => print('voice'),
      /*  textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ), */
    ),
    'dilan': HighlightedWord(
      onTap: () => print('subscribe'),
      /* textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ), */
    ),
    'umut': HighlightedWord(
      onTap: () => print('like'),
      /* textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ), */
    ),
    'köpek': HighlightedWord(
      onTap: () => print('comment'),
      /* textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ), */
    ),
  };

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    _speech = stt.SpeechToText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constantColor.darkColor,
        centerTitle: true,
        title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: NoteScreen(), type: PageTransitionType.bottomToTop));
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 2000),
        repeat: true,
        child: Row(
          children: [
            FloatingActionButton(
              backgroundColor: Colors.grey.shade400,
              onPressed: _listen,
              child: Icon(_isListening ? Icons.mic : Icons.mic_none),
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade400,
                  onPrimary: Colors.grey,
                  shadowColor: Colors.grey[400],
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                onPressed: () {},
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: TextHighlight(
            text: _text,
            words: _highlights,
            textStyle: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    try {
      if (!_isListening) {
        bool available = await _speech.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => print('onError: $val'),
        );
        if (available) {
          setState(() => _isListening = true);
          _speech.listen(
            onResult: (val) => setState(() {
              _text = val.recognizedWords;
              if (val.hasConfidenceRating && val.confidence > 0) {
                _confidence = val.confidence;
              }
            }),
          );
        }
      } else {
        setState(() => _isListening = false);
        _speech.stop();
      }
    } on PlatformException catch (e) {
      print("Hata Mesajı: ${e.message}");
    }
  }
}
