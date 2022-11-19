import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:petty_app/widget/GreetingWidget.dart';

import '../widget/AudioResourceSelectWidget.dart';
import 'RecordingPage.dart';
import 'ResultPage.dart';

class GreetingPage extends StatefulWidget {
  const GreetingPage({super.key});

  @override
  State<GreetingPage> createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
  bool showWelcomePage = true;

  handleOnGonPressed() {
    showWelcomePage = false;
    setState(() {});
  }

  handleOnRecordingPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RecordingPage(),
      ),
    );
  }

  handleOnUploadPressed() async {
    try {
      final filePath = await FilePicker.getFilePath(
        type: FileType.any,
        // onFileLoading: (FilePickerStatus status) => print(status),
        // allowedExtensions: ['aac'],
      );

      if (filePath == null) {
        return;
      }

      final file = File(filePath);

      print(file.path);

      final fileExtension = file.path.split('.').last;

      if (fileExtension == 'aac') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResultPage(
              audioFile: file,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Only .aac files supported"),
        ));
      }
    } catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: $exception"),
      ));
    }
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
            child: Image.asset(
              'assets/logo2.png',
              height: 55,
              width: 55,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: showWelcomePage
            ? GreetingWidget(
                onGoOnPressed: handleOnGonPressed,
              )
            : AudioResourceSelectWidget(
                onRecordingPressed: handleOnRecordingPressed,
                onUploadPressed: handleOnUploadPressed,
              ),
      ),
    );
  }
}
