import 'package:flutter/material.dart';

class StatisticRowWidget extends StatefulWidget {
  String text;
  Color color;
  double value;

  StatisticRowWidget({
    super.key,
    required this.text,
    required this.color,
    required this.value,
  });

  @override
  State<StatisticRowWidget> createState() => _StatisticRowWidgetState();
}

class _StatisticRowWidgetState extends State<StatisticRowWidget>
    with TickerProviderStateMixin {
  late Animation _animationPrimary;

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _animationPrimary =
        Tween(begin: 0.0, end: widget.value).animate(_animationController);

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints: new BoxConstraints(
            minWidth: 100.0,
          ),
          child: Text(
            widget.text,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Container(
              constraints: new BoxConstraints(
                minHeight: 22.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x339f9f9f),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _animationPrimary.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          constraints: new BoxConstraints(
            minWidth: 40.0,
          ),
          child: Text(
            '${(widget.value * 100).floor().toString().padLeft(2, '0')}%',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
