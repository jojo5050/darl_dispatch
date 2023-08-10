import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderFadingBlue extends StatelessWidget {
  const LoaderFadingBlue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: Colors.indigo,
      size: 20,
    );

    /*Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: const Center(
        child: SpinKitThreeBounce(
          color: Colors.indigo,
          size: 50,
        ),
      ),
    );*/
  }
}