import 'dart:io';
import 'package:bitirme_projesi/fuar/Interview/CompanyInterview.dart';
import 'package:bitirme_projesi/fuar/VoiceRecorder/views/recorded_list_view.dart';
import 'package:bitirme_projesi/fuar/VoiceRecorder/views/recorder_view.dart';
import 'package:bitirme_projesi/fuar/constants/Constantscolors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';

import '../../Screens/Feed/Feed.dart';

class RecorderHomeView extends StatefulWidget {
  final String _title;

  const RecorderHomeView({Key? key, required String title})
      : _title = title,
        super(key: key);

  @override
  _RecorderHomeViewState createState() => _RecorderHomeViewState();
}

class _RecorderHomeViewState extends State<RecorderHomeView> {
  late Directory appDirectory;
  List<String> records = [];
  ConstantColor constantColor = ConstantColor();

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((value) {
      appDirectory = value;
      appDirectory.list().listen((onData) {
        if (onData.path.contains('.aac')) records.add(onData.path);
      }).onDone(() {
        records = records.reversed.toList();
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    appDirectory.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constantColor.darkColor,
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
        title: Text(widget._title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: RecordListView(
              records: records,
            ),
          ),
          Expanded(
            flex: 1,
            child: RecorderView(
              onSaved: _onRecordComplete,
            ),
          ),
        ],
      ),
    );
  }

  _onRecordComplete() {
    records.clear();
    appDirectory.list().listen((onData) {
      if (onData.path.contains('.aac')) records.add(onData.path);
    }).onDone(() {
      records.sort();
      records = records.reversed.toList();
      setState(() {});
    });
  }
}
