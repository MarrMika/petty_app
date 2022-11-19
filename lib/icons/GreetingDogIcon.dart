import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GreetingDogIcon extends StatefulWidget {
  const GreetingDogIcon({super.key});

  @override
  State<GreetingDogIcon> createState() => _GreetingDogIconState();
}

class _GreetingDogIconState extends State<GreetingDogIcon>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, lowerBound: 0.5);
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
      child: Container(
        decoration: const BoxDecoration(
          color: const Color(0x559E9E9E),
          shape: BoxShape.circle,
        ),
        child: Lottie.asset(
          'assets/cute_dog.json',
          height: 200,
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = const Duration(milliseconds: 2000)
              ..repeat(reverse: true);
          },
        ),
      ),
    );
  }
}
