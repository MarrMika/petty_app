import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petty_app/widget/ResultWidget.dart';

class ResultPage extends StatefulWidget {
  File audioFile;

  ResultPage({super.key, required this.audioFile});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  handleBackPressed() {
    Navigator.of(context).pop();
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
        padding: const EdgeInsets.only(
          top: 60,
          left: 20,
          right: 20,
          bottom: 80,
        ),
        child: ResultWidget(
          audioFile: widget.audioFile,
        ),
      ),
    );
  }
}
