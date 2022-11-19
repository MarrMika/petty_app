import 'dart:io';

import 'package:flutter/material.dart';

import '../icons/AngryShiba.dart';
import '../icons/HappyShiba.dart';
import '../icons/Loading.dart';
import '../icons/SadShiba.dart';
import '../service/voice.service.dart';
import 'StatisticRowWidget.dart';

class ResultWidget extends StatefulWidget {
  File audioFile;

  ResultWidget({super.key, required this.audioFile});

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  VoiceService _voiceService = VoiceService();
  VoiceResult? _result;
  Object? _error;

  fetchResult() async {
    try {
      _result = await _voiceService.analyzeDogVoice(widget.audioFile);

      setState(() {});
    } catch (error) {
      print('error: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Can\'t record: $error"),
      ));
      _error = error;
      setState(() {});
    }
  }

  @override
  void initState() {
    fetchResult();

    super.initState();
  }

  getIconWithText() {
    var icon;
    var mainText;
    var additionalText;

    final list = _result!.getList();

    final value = list.reduce((value, element) {
      return value.value > element.value ? value : element;
    });

    if (value.name == 'happy') {
      // happy
      icon = HappyShiba();
      mainText = 'Happy';
      additionalText = 'I\'m so excited!';
    } else if (value.name == 'angry') {
      // angry
      icon = Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Image.asset(
          'assets/angry_dog.gif',
          height: 130,
        ),
      );
      mainText = 'Angry';
      additionalText = 'I\'m so annoyed!';
    } else if (value.name == 'sad') {
      // sad
      icon = Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Image.asset(
          'assets/sad_dog.gif',
          height: 130,
        ),
      );
      mainText = 'Sad';
      additionalText = 'I\'m so dejected!';
    } else if (value.name == 'arrogant') {
      // arrogant
      icon = Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Image.asset(
          'assets/arrogant_dog.gif',
          height: 130,
        ),
      );
      mainText = 'Arrogant';
      additionalText = 'I\'m so self-important!';
    } else if (value.name == 'aggressive') {
      // Arrogant
      icon = AngryShiba();
      mainText = 'Aggressive';
      additionalText = 'I\'m so hostile!';
    } else {
      icon = HappyShiba();
      mainText = 'Normal';
      additionalText = 'I\'m am fine!';
    }

    return Column(
      children: [
        icon,
        Text(
          mainText,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .apply(color: Colors.black, fontWeightDelta: 2),
        ),
        Text(
          additionalText,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .apply(color: Colors.black, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: _result == null && _error == null
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween,
      children: _error != null
          ? [
              const Text(
                'Feedback',
                softWrap: true,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 0),
                  child: Image.asset('assets/na_dog.gif', height: 150),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 100),
                    child: Text(
                      'Ooops!\nSomething went wrong!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .apply(color: Colors.black, fontWeightDelta: 2),
                    )),
              ]),
              Container(),
            ]
          : _result == null
              ? [Center(child: const Loading())]
              : [
                  const Text(
                    'Feedback',
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                  getIconWithText(),
                  Column(children: [
                    StatisticRowWidget(
                      text: "Happy",
                      color: Color.fromARGB(255, 47, 190, 47),
                      value: _result!.happy,
                    ),
                    StatisticRowWidget(
                      text: "Sad",
                      color: Color.fromARGB(255, 32, 36, 238),
                      value: _result!.sad,
                    ),
                    StatisticRowWidget(
                      text: "Angry",
                      color: Color.fromARGB(255, 209, 23, 23),
                      value: _result!.angry,
                    ),
                    StatisticRowWidget(
                      text: "Aggressive",
                      color: Color.fromARGB(255, 241, 200, 75),
                      value: _result!.aggressive,
                    ),
                    StatisticRowWidget(
                      text: "Arrogant",
                      color: Color.fromARGB(255, 186, 30, 203),
                      value: _result!.arrogant,
                    ),
                  ]),
                ],
    );
  }
}
