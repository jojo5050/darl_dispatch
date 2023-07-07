import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.only(left: 70, right: 70),
      child: const Center(
        child: SpinKitRotatingCircle(
          color: Colors.indigo,
          size: 50,
        ),
      ),
    );
  }
}