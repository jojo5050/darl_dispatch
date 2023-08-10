import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../AuthManagers/auth_checker.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    delayAndNavigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors:
        [Colors.white, Colors.indigo],
            begin: Alignment.topCenter, end: Alignment.bottomCenter),),
    //  color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 10.h,),
          Center(child: Container(child: Image.asset("assets/images/darllogo.png"),)),

          SizedBox(height: 10.h,),

          Center(
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText("SMART",
                    textStyle: TextStyle(color: Colors.black, fontSize: 25.sp,
                        decoration: TextDecoration.none,
                        fontFamily: "Customfont") ),
                TypewriterAnimatedText("LOGISTICS",
                    textStyle: TextStyle(color: Colors.black, fontSize: 25.sp,
                        decoration: TextDecoration.none,
                        fontFamily: "Customfont") )

              ],
            ),
          )


        ],
      ),
    );

  }

  void delayAndNavigate() {

    Timer(const Duration(seconds: 3), ()=> Navigator
        .pushReplacement(context, MaterialPageRoute(builder: (context){
      return const AuthChecker();
    })));
  }

}
