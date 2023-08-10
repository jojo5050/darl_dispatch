import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darl_dispatch/ConstantHelper/colors.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../../Models/global_variables.dart';
import '../../Utils/localstorage.dart';
import '../../Utils/routers.dart';
import '../GoogleMapManagers/location_provider.dart';

class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({Key? key}) : super(key: key);

  @override
  _DriverProfilePageState createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {

  User? currentuser = FirebaseAuth.instance.currentUser;
  CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");
  final loc.Location location = loc.Location();
  Location locationCheck = Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  bool shouldAddLocation = false;

  var userPic;

  @override
  void initState() {
     getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
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
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Column(
                      children: [
                        Text("Tracking", style: TextStyle(color: AppColors.dashboardtextcolor,
                        fontWeight: FontWeight.bold, fontSize: 16.sp),),
                        Consumer(
                          builder: (context, value, _) {
                            return FlutterSwitch(
                                value: locationProvider.shouldAddLocation,
                                width: 16.w,
                                height: 4.h,
                                valueFontSize: 15.sp,
                                toggleSize: 22,
                                showOnOff: true,
                                activeTextColor: Colors.white,
                                inactiveTextColor: Colors.blueGrey,
                                onToggle: (val){
                                  setState(() {
                                    shouldAddLocation = val;
                                  });
                                  locationProvider.toggleLocation(val);
                                  if (val) {
                                    getCurrentLocation(); // Call your addLocation function here
                                  } else {
                                    stopLocationUpdate(); // Call your removeLocation function here
                                  }
                                }
                            );
                          },
                        ),
                      ],
                    ),

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
                            switch(value){
                              case 1: Routers.pushNamed(context, '/editProfile');
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
                  SizedBox(height: 1.h,),
                      Container(
                          child: profilePic == null ? CircularProgressIndicator():
                          CircleAvatar(
                        radius: 58,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(profilePic ?? ""),
                      )),
                  SizedBox(height: 2.h,),

                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text("${userName ?? ""} ", style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17.sp),)
                    ],),
                  SizedBox(height: 1.h,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text("${userRole ?? ""}", style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal, fontSize: 16.sp),)
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
                        /* SizedBox(height: 2.h,),
                          Row(
                            children: [
                              Text("A/C Name:", style: TextStyle(color: Colors.black,
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),),
                              SizedBox(width: 2.w,),
                              Text("${accNum ?? ""}", style: TextStyle(color: Colors.white,
                                  fontSize: 18.sp, ),),
                            ],
                          ),*/
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
    LocalStorage().delete("token");
    LocalStorage().delete("userData");
    LocalStorage().delete("roleKey");
    LocalStorage().delete("idKey");

    Routers.replaceAllWithName(context, '/login_page');

  }

  void getUserDetails() async {

    var userPicture = await LocalStorage().fetch("userData");
    print("userdata ...................... as $userPicture");

    setState(() {
      userPic = userPicture["image"];
    });

  }

    getCurrentLocation() async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Location Tracking Enabled",
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 3),
    ));

    bool serviceEnabled = await locationCheck.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await locationCheck.requestService();
      if (!serviceEnabled) {
        // Location services are disabled or permission denied
        return;
      }
    }

    PermissionStatus permissionStatus = await locationCheck.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await locationCheck.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        // Permission denied
        return;
      }
    }
    try{
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection("Locations")
          .doc(FirebaseAuth.instance.currentUser!.uid).set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'timestamp': DateTime.now(),
      }, SetOptions(merge: true));

     _locationSubscription = location.onLocationChanged.handleError((onError){
        print(onError);
        _locationSubscription?.cancel();
        setState(() {
          _locationSubscription = null;
        });

      }).listen((loc.LocationData currentLocation) async {
        await FirebaseFirestore.instance.collection("Locations")
            .doc(FirebaseAuth.instance.currentUser!.uid).set({
          'latitude': currentLocation.latitude,
          'longitude': currentLocation.longitude,
          'timestamp': DateTime.now(),
        }, SetOptions(merge: true));

      });

    }catch(e){
      print('Error getting location: $e');

    }
  }
  void stopLocationUpdate() {
    _locationSubscription?.cancel();
      _locationSubscription = null;

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Location Tracking Disabled",
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 3),
    ));

   /* FirebaseFirestore.instance
        .collection('Locations')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();*/
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

  exitApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }
}
