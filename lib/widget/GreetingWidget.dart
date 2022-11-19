import 'package:flutter/material.dart';
import 'package:petty_app/icons/GreetingDogIcon.dart';

class GreetingWidget extends StatefulWidget {
  VoidCallback onGoOnPressed;

  GreetingWidget({super.key, required this.onGoOnPressed});

  @override
  State<GreetingWidget> createState() => _GreetingWidgetState();
}

class _GreetingWidgetState extends State<GreetingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Hi there!',
          softWrap: true,
          style: TextStyle(
              color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        const GreetingDogIcon(),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Welcome to '),
                  TextSpan(text: 'Petty', style: TextStyle(color: Colors.red)),
                  TextSpan(
                    text:
                        '. In order for you to get understand your dog better, we would like to know your dog\'s voice by recording it. ',
                  ),
                  TextSpan(text: 'Don\'t worry, we\'ll walk you through it!'),
                ],
              ),
            )),
        Padding(
          padding: EdgeInsets.all(20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            onPressed: widget.onGoOnPressed,
            child: const Text(
              "Go on",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        )
      ],
    );
  }
}
