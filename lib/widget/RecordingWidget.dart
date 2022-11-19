import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../icons/RecordIcon.dart';

class RecordingWidget extends StatefulWidget {
  void Function(File file) onSend;

  RecordingWidget({super.key, required this.onSend});

  @override
  State<RecordingWidget> createState() => _RecordingWidgetState();
}

class _RecordingWidgetState extends State<RecordingWidget> {
  final fileName = 'audio.aac';
  String recordingTime = '00:00:000';
  bool _recording = false;
  File? _audioFile;

  Future<File> getSoundFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File("${directory.path}/$fileName");
  }

  handleRecordingStarted() async {
    try {
      if (!_recording) {
        var status = await Permission.microphone.request();
        if (status != PermissionStatus.granted) {
          return;
        }

        var fileStatus = await Permission.storage.request();
        if (fileStatus != PermissionStatus.granted) {
          return;
        }
      }

      if (_recording) {
        setState(() {
          _recording = false;
        });

        await Record.stop();

        _audioFile = await getSoundFile();

        setState(() {});

        return;
      }

      await Record.start(path: (await getSoundFile()).path);

      setState(() {
        _audioFile = null;
        _recording = true;
        recordingTime = '00:00:000';
      });
    } catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Can\'t record: $exception"),
      ));
      return;
    }

    final startTime = DateTime.now();
    Timer.periodic(const Duration(milliseconds: 10), (Timer t) {
      var diff = DateTime.now().difference(startTime);

      recordingTime =
          '${(diff.inMinutes).toString().padLeft(2, '0')}:${(diff.inSeconds % 60).toString().padLeft(2, '0')}:${(diff.inMilliseconds % 1000).toString().padLeft(3, '0')}';

      if (!_recording) {
        t.cancel(); //cancel function calling
      }

      setState(() {});
    });
  }

  handleReset() {
    setState(() {
      _audioFile = null;
      _recording = false;
      recordingTime = '00:00:000';
    });
  }

  handleSend() {
    if (_audioFile != null) {
      widget.onSend(_audioFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text(
          'Recording',
          softWrap: true,
          style: TextStyle(
              color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: RecordIcon(
            onPressed: handleRecordingStarted,
            recording: _recording,
          ),
        ),
        Text(
          recordingTime,
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .apply(fontSizeFactor: 3.5),
        ),
        _audioFile != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xEE9E9E9E),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        onPressed: handleReset,
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          child: Text(
                            "Reset",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        onPressed: handleSend,
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          child: Text(
                            "Send",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                constraints: const BoxConstraints(
                  minHeight: 45.0,
                ),
              ),
      ],
    );
  }
}
