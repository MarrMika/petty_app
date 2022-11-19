import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HappyShiba extends StatefulWidget {
  const HappyShiba({super.key});

  @override
  State<HappyShiba> createState() => _HappyShibaState();
}

class _HappyShibaState extends State<HappyShiba> with TickerProviderStateMixin {
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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Lottie.asset(
        'assets/happy_shiba.json',
        height: 160,
        controller: _controller,
        onLoaded: (composition) {
          _controller
            ..duration = const Duration(seconds: 4)
            ..repeat(reverse: false);
        },
      ),
    );
  }
}
