
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../../Models/global_variables.dart';
import '../../Utils/localstorage.dart';
import '../../Utils/routers.dart';
import '../Utils/loaderFadingBlue.dart';

class AccountantHomePage extends StatefulWidget {
  const AccountantHomePage({Key? key}) : super(key: key);

  @override
  _AccountantHomePageState createState() => _AccountantHomePageState();
}

class _AccountantHomePageState extends State<AccountantHomePage> with WidgetsBindingObserver {

  List<Map<String, dynamic>>? listOfLoads;
  List<Map<String, dynamic>>? listOfStaffs;
  List<Map<String, dynamic>>? listOfDrivers;
  List<Map<String, dynamic>>? listOfTrucks;
  List<Map<String, dynamic>>? listOfTrailers;

  User? currentuser = FirebaseAuth.instance.currentUser;
  CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");

  bool _hasInternet = true;

  final int _locationUpdateInterval = 10;

  LocationData? _currentLocation;

  Timer? timer;

  List<LocationData> _locationList = [];

  String? _currentUserID;

  Timer? _firestoreUpdateTime;

  int _firestoreUpdateInterval = 60;

  List<Map<String, dynamic>>? listOfDeliveredLoads;
  String loadStatus = "3";

  var errmsg;

  var gross;

  var net;

  @override
  void initState() {
  //  WidgetsBinding.instance.addObserver(this);
    checkInternetConnection();
    getUserDetails();
    getAllStaffs();
    getDelevered();
  //  getRegLoads();
    getCompanyIncome();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      checkInternetConnection();
    }
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: _hasInternet ?
          Stack(children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/generalDashBoardBg.png"),
                      fit: BoxFit.cover)),),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
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
                    height: 0.5.h,
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
                                  gradient: const LinearGradient(colors:
                                  [Colors.lightBlueAccent, Colors.greenAccent],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          "Employees",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w),
                                    child:
                                    listOfStaffs == null
                                        ? LoaderFadingBlue()
                                        :
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          "${listOfStaffs!.length ?? ""}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp),
                                        ),
                                        const Icon(
                                          Icons.group,
                                          color: Colors.indigo,
                                          size: 25,
                                        )
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
                                  [Colors.lightBlueAccent, Colors.greenAccent],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          "Completed Loads",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
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
                                              fontSize: 18.sp),
                                        ),
                                        const Icon(
                                          Icons.check_circle,
                                          color: Colors.indigo,
                                          size: 25,
                                        )
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
                                  [Colors.lightBlueAccent, Colors.greenAccent],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          "Vehicle Income",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          "\$ 0",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp),
                                        ),
                                        Icon(Icons.credit_card, color: Colors.indigo,
                                          size: 25.sp,)
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
                                  gradient: const LinearGradient(
                                      colors: [Colors.red, Colors.yellow],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight
                                  ),

                                  borderRadius: BorderRadius.circular(25)),
                              width: 80.w,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Company Income",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold),
                                              ),

                                              Icon(Icons.payments_outlined, color: Colors.indigo,
                                                size: 25.sp,)
                                            ],
                                          ),
                                        ),

                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          "GROSS \$: ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${gross ?? ""}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold),
                                        ),


                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          "NET \$: ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${net ?? ""}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold),
                                        ),


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
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          "Staff PayOut",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          "\$ 0",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp),
                                        ),
                                        Icon(Icons.monetization_on, color: Colors.indigo,
                                          size: 25.sp,)
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
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 2,
                      child: GridView(gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                        children: [
                          InkWell(onTap: () {
                            Routers.pushNamed(context, '/staffDue');
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
                                      const Center(child: Icon(
                                        Icons.group,
                                        color: Colors.black, size: 40,)),

                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                                        child: Column(
                                          children: [
                                            Text("Staffs Due", style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp),),
                                            Text("For Payment", style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp),),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                )
                            ),
                          ),
                          InkWell(onTap: () {
                            Routers.pushNamed(context, '/driversDue');
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
                                      const Center(child: Icon(
                                        Icons.directions_car,
                                        color: Colors.black, size: 40,)),

                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                                        child: Column(
                                          children: [
                                            Text("Drivers Due", style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp),),
                                            Text("For Payment", style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp),),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                )
                            ),
                          ),
                          InkWell(onTap: () {
                            Routers.pushNamed(context, '/managePayment');
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
                                          child: Icon(Icons.credit_card,
                                            color: Colors.black, size: 40,)),

                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                                        child: Column(
                                          children: [
                                            Text("Successful", style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp),),
                                            Text("Payments", style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp),),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ),
                          ),
                          InkWell(onTap: () {
                            Routers.pushNamed(context, '/paid_loads');
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
                                      const Center(child: Icon(
                                        Icons.monetization_on, color: Colors.black,
                                        size: 40,)),

                                      Text("Paid Loads", style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp),)

                                    ],
                                  ),
                                )
                            ),
                          ),
                          InkWell(onTap: () {
                            Routers.pushNamed(
                                context, '/adminLoadDeliveredPreview');
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
                                      const Center(child: Icon(
                                        Icons.check_circle, color: Colors.black,
                                        size: 40,)),

                                      Text("Loads Delivered", style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp),)

                                    ],
                                  ),
                                )
                            ),
                          ),
                          InkWell(onTap: () {
                            Routers.pushNamed(context, '/trackingManagerPage');
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
                                      const Center(child: Icon(
                                        Icons.location_on_rounded,
                                        color: Colors.black, size: 40,)),

                                      Text("Location Tracking",
                                        style: TextStyle(color: Colors.black,
                                            fontSize: 14.sp),)

                                    ],
                                  ),
                                )
                            ),
                          ),
                        ],

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
          ) : buildNoInternetPopup()

      );
  }

  void getUserDetails() async {
    if (!_hasInternet) {
      return;
    }
    dynamic userId = await LocalStorage().fetch("idKey");
    print("userid as $userId");

    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.getSingleUserInfo({
        "id": userId.toString()
      });

      if (response != null && response.statusCode == 200) {
        var userdata = response.data;
        print("user data asssssssssss $userdata");

        setState(() {
          userName = userdata["name"];
        });

        var pic = userdata["picture"];
        var avatar = userdata["image"];

        if(pic != null){
          setState(() {
            profilePic = pic;
          });
        }else{
          setState(() {
            profilePic = avatar;
          });
        }

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
      } else {
        print("could not retrieve it");
      }
    } catch (e) {
      setState(() {
        _hasInternet = false;
      });
    }
  }

  void getRegLoads() async {
    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.fetchAllRegLoads();

      if (response != null && response.statusCode == 200) {
        List regLoads = response.data["data"]["docs"];

        print("print loadssssssss asssss${regLoads}");
        List<Map<String, dynamic>> data = [];

        if (regLoads.length > 0) {
          for (int i = 0; i < regLoads.length; i++) {
            Map<String, dynamic> regLoadList = regLoads[i];
            data.add(regLoadList);
          }
        }
        setState(() {
          listOfLoads = data;
        });

        print("printing list of loads asssssss $listOfLoads");
      } else {

      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  Widget buildNoInternetPopup() {
    return Center(
      child: Container(
        height: 23.h,
        child: Dialog(
          backgroundColor: Colors.grey,
          child: Column(
            children: [
              SizedBox(height: 2.h,),
              const Center(child: Text("No Internet access Detected",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),)),
              SizedBox(height: 1.h,),
              const Center(child: Text("Re-Connect and try again",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),)),
              //  SizedBox(height: 2.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        exitApp();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 5.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Exit", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),),
                        ),
                      )),

                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/splash_screen');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 5.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Reload", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),),
                        ),
                      )),

                ],)
            ],
          ),
        ),
      ),
    );
  }

  exitApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
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


  void getDelevered() async {
    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.fetchAllRegLoads();
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
          listOfDeliveredLoads = data.where((element)
          => element["totalDrops"] != 0
              && element["totalDrops"]
                  == element["totalLoadDropped"] ).toList();
        });

      } else {
        setState(() {
          errmsg = response!.data["message"];
        });

      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }

  }

  void getAllStaffs() async {
    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.getAllUsers();

      if (response != null && response.statusCode == 200) {
        List staffs = response.data["data"]["docs"];

        List<Map<String, dynamic>> data = [];

        if (staffs.length > 0) {
          for (int i = 0; i < staffs.length; i++) {
            Map<String, dynamic> staffList = staffs[i];
            data.add(staffList);
          }
        }
        setState(() {
          listOfStaffs = data;
        });
      } else {

      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void getCompanyIncome() async {
    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.getCompanyIncome();

      if (response != null && response.statusCode == 200 && response.data["status"] == 200) {
        var res = response.data["data"];

        setState(() {
          gross = res["gross_income"];
        });

        setState(() {
          net = res["net_income"];
        });


      } else {

      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }

  }
}