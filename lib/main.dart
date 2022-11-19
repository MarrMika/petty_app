import 'package:flutter/material.dart';
import 'package:petty_app/page/GreetingPage.dart';
import 'package:petty_app/page/RecordingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        primarySwatch: MaterialColor(0xFFF44336, {
          50: const Color.fromRGBO(218, 0, 99, 255),
          100: const Color.fromRGBO(218, 0, 99, .2),
          200: const Color.fromRGBO(218, 0, 99, .3),
          300: const Color.fromRGBO(218, 0, 99, .4),
          400: const Color.fromRGBO(218, 0, 99, .5),
          500: const Color.fromRGBO(218, 0, 99, .6),
          600: const Color.fromRGBO(218, 0, 99, .7),
          700: const Color.fromRGBO(218, 0, 99, .8),
          800: const Color.fromRGBO(218, 0, 99, .9),
          900: const Color.fromRGBO(218, 0, 99, 1),
        }),
      ),
      home: const GreetingPage(),
    );
  }
}
