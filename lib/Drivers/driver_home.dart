
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:location/location.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../../Models/global_variables.dart';
import '../../Utils/localstorage.dart';
import '../Utils/loaderFadingBlue.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({Key? key}) : super(key: key);

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {

  User? currentuser = FirebaseAuth.instance.currentUser;
  CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");

  List<Map<String, dynamic>>? listOfDeliveredLoads;

  var errmsg;

  @override
  void initState() {
    getUserDetails();
    getDelevered();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Stack(children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/generalDashBoardBg.png"),
                      fit: BoxFit.cover)),),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                                child: profilePic == null ? LoaderFadingBlue():
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(profilePic ?? ""),
                                )),
                            SizedBox(height: 0.5.h,),
                            Text("${userName ?? ""} ", style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.sp),),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Container(
                      //  height: MediaQuery.of(context).size.height / 2,
                      height: 20.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [Colors.red, Colors.yellow],
                                      begin: Alignment.centerLeft, end: Alignment.centerRight
                                  ),
                                  // color: AppColors.driversCardColor,
                                  borderRadius: BorderRadius.circular(25)),
                              width: 80.w,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                                        child: Text(
                                          "Loads Delivered",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w),
                                    child:
                                    listOfDeliveredLoads == null
                                        ? LoaderFadingBlue()
                                        :
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          "${listOfDeliveredLoads!.length ?? ""}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.sp),
                                        ),
                                        Icon(Icons.check_circle,
                                          color: Colors.indigo, size: 25.sp,)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Container(

                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors:
                                  [Colors.indigo, Colors.yellow],
                                      begin: Alignment.centerLeft, end: Alignment.centerRight
                                  ),

                                  borderRadius: BorderRadius.circular(25)),
                              width: 80.w,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                                        child: Text(
                                          "Total CashOut",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\$ 0",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 20.sp),
                                        ),
                                        Container(
                                          child: SvgPicture.asset(
                                              "assets/images/moneyStraightIcon.svg"),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 5.h,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: GridView(gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                        children: [

                          InkWell(onTap: (){
                            Routers.pushNamed(context, '/drAvailableVehicles');

                          },
                            child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),

                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 3.h,),
                                      const Center(child: Icon(Icons.local_shipping, color: Colors.black, size: 40,)),

                                      Text("Vehicles", style: TextStyle(color: Colors.black, fontSize: 14.sp),)

                                    ],
                                  ),
                                )
                            ),
                          ),
                          InkWell(onTap: (){
                            Routers.pushNamed(context, '/driverManagementScreen');

                          },
                            child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),

                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 3.h,),
                                      const Center(
                                          child: Icon(Icons.directions_car, color: Colors.black, size: 40,)),

                                      Text("Drivers", style: TextStyle(color: Colors.black, fontSize: 14.sp),)

                                    ],
                                  ),
                                )
                            ),
                          ),
                          InkWell(onTap: (){
                            Routers.pushNamed(context, '/drLoadAssignedPreview');

                          },
                            child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),

                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 3.h,),
                                      const Center(child: Icon(Icons.assignment, color: Colors.black, size: 40,)),

                                      Text("Loads Assigned", style: TextStyle(color: Colors.black, fontSize: 14.sp),)

                                    ],
                                  ),
                                )
                            ),
                          ),
                          InkWell(onTap: (){
                            Routers.pushNamed(context, '/drCustomDeleveredPreview');

                          },
                            child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),

                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 3.h,),
                                      const Center(child: Icon(Icons.check_circle, color: Colors.black, size: 40,)),

                                      Text("Loads Delivered", style: TextStyle(color: Colors.black, fontSize: 14.sp),)

                                    ],
                                  ),
                                )
                            ),
                          ),
                          InkWell(onTap: (){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              content: Text("work in progress, try again later"),
                              duration: Duration(seconds: 2),));
                          },
                            child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),

                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 3.h,),
                                      const Center(child: Icon(Icons.payments_outlined, color: Colors.black, size: 40,)),

                                      Text("My Pay Roll", style: TextStyle(color: Colors.black, fontSize: 14.sp),)

                                    ],
                                  ),
                                )
                            ),
                          ),
                          InkWell(onTap: (){
                              Routers.pushNamed(context, '/allDispatchers');
                          },
                            child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),

                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 3.h,),
                                      const Center(child: Icon(Icons.group, color: Colors.black, size: 40,)),

                                      Text("Dispatchers", style: TextStyle(color: Colors.black, fontSize: 14.sp),)

                                    ],
                                  ),
                                )
                            ),
                          )

                        ],

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
          )
      );
  }

  void getUserDetails() async {

    dynamic userId = await LocalStorage().fetch("idKey");
    print("userid as $userId");

    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getSingleUserInfo({
        "id": userId.toString()
      });

      if(response != null && response.statusCode == 200){

        var  userdata = response.data;
        print("user data asssssssssss $userdata");

        setState(() {
          userName = userdata["name"];
        });
        setState(() {
          profilePic = userdata["image"];
        });
        setState(() {
          email = userdata["email"];
        });
        setState(() {
          userRole = userdata["role"];
        });
        setState(() {
          telNum = userdata["tel"];
        });
        setState(() {
          accNum = userdata["accountNumber"];
        });
        setState(() {
          bankName = userdata["bankName"];
        });
        setState(() {
          address = userdata["address"];
        });

      }else{
        print("could not retrieve it");

      }

    }catch(e){

    }

  }

  void getCurrentLocation() async {
    Location location = Location();
    LocationData? locationData;
    bool serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Location services are disabled or permission denied
        return;
      }
    }

    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        // Permission denied
        return;
      }
    }
    try{

      locationData = await location.getLocation();
    }catch(e){
      print('Error getting location: $e');
    }

    if (locationData != null) {
      double latitude = locationData.latitude!;
      double longitude = locationData.longitude!;

      print("latitude as ...................$latitude");
      print("longitude as ...................$longitude");

      // Create the user's location document in the user_locations collection
      createUserLocation(latitude, longitude);
    }
  }

  void createUserLocation(double latitude, double longitude) {
    DocumentReference userLocationRef = FirebaseFirestore.instance
        .collection('user_locations')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    userLocationRef.set({
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': DateTime.now(),
    }).then((_) {
      print('User location created successfully');
    }).catchError((error) {
      print('Error creating user location: $error');
    });

  }

  Future<bool> willPopControll() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
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

  void getDelevered() async {
    var driverID = await LocalStorage().fetch('idKey');
    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.drDeliveredLoad({
        "Driver_id": driverID
      });
      print("driver id assssssssssss $driverID");

      if (response != null && response.statusCode == 200 &&
          response.data["status"] == "success") {

        List regLoads = response.data["data"]["docs"];
        List<Map<String, dynamic>> data = [];

        if (regLoads.length > 0) {
          for (int i = 0; i < regLoads.length; i++) {
            Map<String, dynamic> deliveredLoadsList = regLoads[i];
            data.add(deliveredLoadsList);
          }
        }
        setState(() {
          listOfDeliveredLoads = data;
        });

      } else {
        // stopLoader();
        setState(() {
          errmsg = response!.data["message"];
        });

      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }

  }
}
