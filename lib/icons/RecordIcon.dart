import 'package:flutter/material.dart';

class RecordIcon extends StatefulWidget {
  bool recording;
  VoidCallback onPressed;

  RecordIcon({super.key, this.recording = false, required this.onPressed});

  @override
  State<RecordIcon> createState() => _RecordIconState();
}

class _RecordIconState extends State<RecordIcon> with TickerProviderStateMixin {
  late Animation _animationPrimary;
  late Animation<Color?> _animationPrimaryColor;

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _animationPrimary =
        Tween(begin: 0.0, end: 30.0).animate(_animationController);
    _animationPrimaryColor = ColorTween(
      begin: Color.fromARGB(170, 237, 125, 58),
      end: Color.fromARGB(0, 237, 124, 58),
    ).animate(_animationController);

    _animationController.addListener(() {
      setState(() {});
    });

    // init animation
    this.didUpdateWidget(this.widget);

    super.initState();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    if (widget.recording) {
      _animationController.repeat();
    } else {
      if (_animationController.value != 0) {
        _animationController.forward(from: _animationController.value);
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    IconData icon = widget.recording ? Icons.stop : Icons.mic;

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: _animationPrimaryColor.value ?? Colors.red,
            blurRadius: 0,
            spreadRadius: _animationPrimary.value,
          ),
        ],
      ),
      child: IconButton(
        onPressed: widget.onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
