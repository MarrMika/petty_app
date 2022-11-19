import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SadShiba extends StatefulWidget {
  const SadShiba({super.key});

  @override
  State<SadShiba> createState() => _SadShibaState();
}

class _SadShibaState extends State<SadShiba> with TickerProviderStateMixin {
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
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Lottie.asset(
        'assets/sad_shiba.json',
        height: 170,
        controller: _controller,
        onLoaded: (composition) {
          _controller
            ..duration = const Duration(seconds: 3)
            ..repeat(reverse: false);
        },
      ),
    );
  }
}
