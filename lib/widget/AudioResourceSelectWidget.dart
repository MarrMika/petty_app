import 'package:flutter/material.dart';

class AudioResourceSelectWidget extends StatefulWidget {
  VoidCallback onRecordingPressed;
  VoidCallback onUploadPressed;

  AudioResourceSelectWidget({
    super.key,
    required this.onRecordingPressed,
    required this.onUploadPressed,
  });

  @override
  State<AudioResourceSelectWidget> createState() =>
      _AudioResourceSelectWidgetState();
}

class _AudioResourceSelectWidgetState extends State<AudioResourceSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 50, top: 20),
          child: Image.asset(
            'assets/waiting_dog.gif',
            height: 180,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            onPressed: widget.onRecordingPressed,
            child: const Text(
              "Recording",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            onPressed: widget.onUploadPressed,
            child: const Text(
              "Upload",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        )
      ],
    );
  }
}
