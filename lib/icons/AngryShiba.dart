import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AngryShiba extends StatefulWidget {
  const AngryShiba({super.key});

  @override
  State<AngryShiba> createState() => _AngryShibaState();
}

class _AngryShibaState extends State<AngryShiba> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.00,
      upperBound: 1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Lottie.asset(
        'assets/angry_shiba.json',
        height: 130,
        controller: _controller,
        onLoaded: (composition) {
          _controller
            ..duration = const Duration(seconds: 2)
            ..repeat(reverse: false);
        },
      ),
    );
  }
}
