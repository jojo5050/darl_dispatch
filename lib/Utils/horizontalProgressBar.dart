import 'package:flutter/material.dart';

class HorizontalProgressBar extends StatefulWidget {
  const HorizontalProgressBar({Key? key}) : super(key: key);

  @override
  State<HorizontalProgressBar> createState() => _HorizontalProgressBarState();
}

class _HorizontalProgressBarState extends State<HorizontalProgressBar>
with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: false,);
   // super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(30)),
      child: LinearProgressIndicator(
        backgroundColor: Colors.white,
        value: controller.value,
        color: Colors.green,
        minHeight: 10,
        semanticsLabel: "Linear progress indicator",
      ),

    );
  }
}
