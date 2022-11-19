import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petty_app/widget/RecordingWidget.dart';

import 'ResultPage.dart';

class RecordingPage extends StatefulWidget {
  const RecordingPage({super.key});

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  handleBackPressed() {
    Navigator.of(context).pop();
  }

  handleFileSend(File file) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultPage(audioFile: file),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leadingWidth: 85,
        toolbarHeight: 85,
        leading: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFe6e6e6),
            ),
            child: IconButton(
              onPressed: handleBackPressed,
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: RecordingWidget(
          onSend: handleFileSend,
        ),
      ),
    );
  }
}
