import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:darl_dispatch/Utils/loaderFadingBlue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../Models/global_variables.dart';
import '../../Utils/localstorage.dart';
import '../../Utils/routers.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({Key? key}) : super(key: key);

  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> with WidgetsBindingObserver{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  List<QueryDocumentSnapshot<Object?>>? usersMap;

  User? currentuser = FirebaseAuth.instance.currentUser;
  CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");

  bool _hasInternet = true;

  Timer? _locationTimer;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    checkInternetConnection();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/generalDashBoardBg.png"),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                         Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Colors.indigo, Colors.lightBlueAccent],
                              begin: Alignment.centerLeft, end: Alignment.centerRight
                          ),
                          //   color: Colors.indigo,
                          borderRadius: BorderRadius.circular(15)),
                      child: PopupMenuButton(
                          color: Colors.black,
                          elevation: 20,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          icon: const Center(
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          onSelected: (value){
                            switch (value){
                              case 1:  Routers.pushNamed(context, '/editProfile');
                              break;
                              case 2: signOut(context);
                              break;
                            }

                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Container(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Edit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Container(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.logout,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "LogOut",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                              ),
                            ),
                          ]),
                    ),
                  ]),
                  SizedBox(height: 3.h,),
                  Container(
                      child: profilePic == null ? LoaderFadingBlue():
                      CircleAvatar(
                        radius: 58,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(profilePic ?? ""),
                      )),


                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text("${userName ?? ""} ", style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.sp),)
                    ],),
                  SizedBox(height: 1.h,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text("${userRole ?? ""}", style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal, fontSize: 15.sp),)
                    ],),
                  SizedBox(height: 3.h,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Colors.lightBlueAccent, Colors.indigo],
                            begin: Alignment.centerLeft, end: Alignment.centerRight
                        ),
                        //  color: Colors.indigo,
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("TEL:", style: TextStyle(color: Colors.black,
                                fontSize: 17.sp, fontWeight: FontWeight.bold),),
                            SizedBox(width: 2.w,),
                            Text("${telNum ?? ""}", style: TextStyle(color: Colors.white,
                                fontSize: 16.sp, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(height: 3.h,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Email:", style: TextStyle(color: Colors.black,
                                fontSize: 17.sp, fontWeight: FontWeight.bold),),
                            SizedBox(width: 2.w,),
                            Text("${email ?? ""}", style: TextStyle(color: Colors.white,
                                fontSize: 16.sp, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(height: 3.h, ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("A/C Number:", style: TextStyle(color: Colors.black,
                                fontSize: 17.sp, fontWeight: FontWeight.bold),),
                            SizedBox(width: 2.w,),
                            Text("${accNum ?? ""}", style: TextStyle(color: Colors.white,
                                fontSize: 16.sp, fontWeight: FontWeight.bold),),
                          ],
                        ),

                        SizedBox(height: 3.h, ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Bank Name:", style: TextStyle(color: Colors.black,
                                fontSize: 17.sp, fontWeight: FontWeight.bold),),
                            SizedBox(width: 2.w,),
                            Text("${bankName ?? ""}", style: TextStyle(color: Colors.white,
                                fontSize: 16.sp, fontWeight: FontWeight.bold),),
                          ],
                        ),

                        SizedBox(height: 3.h, ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Address:", style: TextStyle(color: Colors.black,
                                fontSize: 17.sp, fontWeight: FontWeight.bold),),
                            SizedBox(width: 2.w,),
                            Text("${address ?? ""}", style: TextStyle(color: Colors.white,
                                fontSize: 16.sp, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ],),
                    ),
                  )
                ],

              ),
            ),
          ),
        ),
      );
  }

  void signOut(BuildContext context) async {
    // LocalStorage().store("token", "");
   /* await usersRef.doc(_firebaseAuth.currentUser!.uid).update({
      "status": "Offline"
    });*/
    _firebaseAuth.signOut();
    LocalStorage().delete("token");
    LocalStorage().delete("userData");
    LocalStorage().delete("roleKey");
    LocalStorage().delete("idKey");
    _stopLocationUpdates();

    Routers.replaceAllWithName(context, '/login_page');

  }

  void _updateUserOnlineStatus(bool isOnline) async {
    String currentUser = FirebaseAuth.instance.currentUser!.uid;
    String onlineStatus = isOnline ? "Online" : "Offline";
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser)
        .update({"onlineStatus": onlineStatus});
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _hasInternet = false;
      });
    } else {
      setState(() {
        _hasInternet = true;
      });
    }
  }


  exitApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  Future<bool> willPopControll() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        //  title: new Text('Are you sure?'),
        content: new Text('Do you want to exit the App'),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => exitApp(),
                child: new Text('Yes'),
              ),
            ],
          ),
        ],
      ),
    )) ??
        false;
  }

  void _stopLocationUpdates() {
    _locationTimer?.cancel();
  }

  void getUser() {
    print(";;;;;;;;;;;;;;;$profilePic");
    print(";;;;;;;;;:::::::::;;;;;;$userName");

  }
}
