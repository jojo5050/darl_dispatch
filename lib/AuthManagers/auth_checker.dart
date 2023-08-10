

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../LandingPageManagers/accountant_landing_page_manager.dart';
import '../LandingPageManagers/admin_landing_page_manager.dart';
import '../LandingPageManagers/dispatcher_landing_page_manager.dart';
import '../LandingPageManagers/driver_landing_manager.dart';
import '../Models/user.dart';
import '../Onboaarding/onboarding_manager.dart';
import '../Onboaarding/onboarding_page.dart';
import '../Providers/authProvider.dart';
import '../Utils/loader_fading_circle.dart';
import '../Utils/localstorage.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {

  bool internetAccess = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: fetchConfirmationData(context),
        builder: (builContext, snapShot){

             if(snapShot.hasData){
               if(snapShot.data["token"] != null){
                 if (checkAuthenticatedDispatcher(snapShot.data)) {
                   return const DispatcherLandingPageManager();
                 }
                 if (checkAuthenticatedDriver(snapShot.data)) {
                   return const DriverLandingManager();
                 }
                 if (checkAuthenticatedAccountant(snapShot.data)) {
                   return AccountantLandingPageManager();
                 }
                 if (checkAuthenticatedAdmin(snapShot.data)) {
                   return const AdminLandingPageManager();
                 }
               }
               return OnboardManager();
             }

             return  Container(
                 color: Colors.indigo,
                 child:
                  const Center(
                     child:
                     LoaderFadingCircle()
                    /* Text("Retrieving Data...",
                       style: TextStyle(
                           decoration: TextDecoration.none,
                           color: Colors.white,
                           fontWeight: FontWeight.bold,
                       fontSize: 16.sp),)*/));


        });
  }

  Future<Map<String, dynamic>> fetchConfirmationData(
      BuildContext context) async {
    return await Future.delayed(const Duration(seconds: 3), () async {
      String? accessToken = "";
      String uRole = "";
      bool isAuthenticated = false;
      User user = User();

      try {
        dynamic _userinfo = await LocalStorage().fetch("userData");
        accessToken = await (LocalStorage().fetch("token")) ?? "";
        uRole = await (LocalStorage().fetch("roleKey")) ?? "";

        if (_userinfo != null) {
          user = User.fromJson(Map<String, dynamic>.from(_userinfo));
          context.read<AuthProvider>().user =
          Map<String, dynamic>.from(_userinfo);
        }
      } catch (e, str) {
        debugPrint("$e");
        debugPrint("StackTrace$str");
      }

      return {"token": accessToken, "user": user, "roleKey": uRole};
    });
  }

  bool checkAuthenticatedDispatcher(data) {
    if (data["token"] != null &&
        data["user"] != null &&
        data["roleKey"] == "Despatcher" &&
        data["token"] != "" &&
        data["user"] != "") return true;

    return false;

  }

  bool checkAuthenticatedDriver(data) {
    if (data["token"] != null &&
        data["user"] != null &&
        data["roleKey"] == "Driver" &&
        data["token"] != "" &&
        data["user"] != "") return true;

    return false;

  }

  bool checkAuthenticatedAccountant(data) {
    if (data["token"] != null &&
        data["user"] != null &&
        data["roleKey"] == "Accountant" &&
        data["token"] != "" &&
        data["user"] != "") return true;

    return false;

  }

  bool checkAuthenticatedAdmin(data) {
    if (data["token"] != null &&
        data["user"] != null &&
        data["roleKey"] == "Admin" &&
        data["token"] != "" &&
        data["user"] != "") return true;

    return false;

  }

}
