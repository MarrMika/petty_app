import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.05,
      upperBound: 0.68,
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
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Lottie.asset(
        'assets/loading.json',
        height: 130,
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
