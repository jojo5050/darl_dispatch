import 'package:darl_dispatch/Onboaarding/second_onboarding.dart';
import 'package:darl_dispatch/Onboaarding/third_onboarding.dart';
import 'package:flutter/material.dart';

import 'first_onboarding.dart';


class OnboardManager extends StatelessWidget {
  OnboardManager({Key? key}) : super(key: key);

  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: PageView(controller: pageController, children:<Widget>[

        OnboardFirst(),
        SecondOnboarding(),
        ThirdOnboardingScreen(),

      ],),

    ),);
  }
}

