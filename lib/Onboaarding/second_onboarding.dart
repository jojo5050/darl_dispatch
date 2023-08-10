import 'dart:async';

import 'package:darl_dispatch/Onboaarding/third_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Utils/routers.dart';

class SecondOnboarding extends StatefulWidget {
  const SecondOnboarding({Key? key}) : super(key: key);

  @override
  State<SecondOnboarding> createState() => _SecondOnboardingState();
}

class _SecondOnboardingState extends State<SecondOnboarding> {

  /*@override
  void initState() {
    super.initState();
    navigateToNextPage();
  }*/


  @override
  Widget build(BuildContext context) {
    final TextStyle heading1 = Theme.of(context).textTheme.titleLarge!;
    return Scaffold(backgroundColor: Colors.white,
      body: Column(
        children: [
           /*      SizedBox(height: 7.h,),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
              TextButton(onPressed: (){Routers.pushNamed(context, '/login_page');},
                  child: Text("Skip to Login")),
              IconButton(onPressed: (){Routers.pushNamed(context, '/login_page');},
                  icon: Icon(Icons.arrow_forward_ios))
            ],),*/

          SizedBox(height: 16.h,),
          Center(
            child: Image.asset(
              "assets/images/logistics.jpg",
              height: 200,
              width: 500,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          const Text(
            "Providing Efficient Routes,",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16, fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          const Text(
            "Real-time Tracking,",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16, fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 25.h,
          ),
             Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [Container(height: 0, width: 0,),
                const Row(children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 5,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 5,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 5,
                  ),

                ]
                ),

              ],
            ),
        ],
      ),
    );
  }

  void navigateToNextPage() async {
    Timer( Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => ThirdOnboardingScreen()
    )) );

  }
}
