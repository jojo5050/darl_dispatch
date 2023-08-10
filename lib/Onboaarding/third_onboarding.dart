import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Authentication/login_page.dart';
import '../Utils/routers.dart';


class ThirdOnboardingScreen extends StatefulWidget {
  const ThirdOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<ThirdOnboardingScreen> createState() => _ThirdOnboardingScreenState();
}

class _ThirdOnboardingScreenState extends State<ThirdOnboardingScreen> {

  @override
  void initState() {
     super.initState();
    //  navigateToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Column(
        children: [
          /*SizedBox(height: 5.h,),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: (){Routers.pushNamed(context, '/login_page');},
                  child: Text("Skip to Login")),
              IconButton(onPressed: (){Routers.pushNamed(context, '/login_page');},
                  icon: Icon(Icons.arrow_forward_ios))
            ],),*/
          SizedBox(height: 15.h),
          Center(
            child: Image.asset(
              "assets/images/delivery.png",
              height: 200,
              width: 500,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          const Text(
            "And Seamless Communication",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16, fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          const Text(
            "For A Smoother Transportation Experience",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 19.h,
          ),
          Container(
            alignment: Alignment.center,
            child: const Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 5,
                  ),
                  SizedBox(
                    width: 5,
                  ),
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
                ]
            ),
          ),

          SizedBox(height: 10.h,),

          InkWell(onTap: () {Routers.pushNamed(context, '/login_page');},
            child: Center(
              child: Container(height: 5.h, width: 35.w,
                decoration: BoxDecoration(color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none, fontWeight: FontWeight.bold,
                        fontSize: 17.sp),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToNextPage() async {
    Timer( Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginPage()
    )) );

  }
}