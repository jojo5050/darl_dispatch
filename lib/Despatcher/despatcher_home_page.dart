import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../../Models/global_variables.dart';
import '../../Utils/localstorage.dart';
import '../../Utils/routers.dart';
import '../Utils/loaderFadingBlue.dart';

class DespatcherHomePage extends StatefulWidget {
  const DespatcherHomePage({Key? key}) : super(key: key);

  @override
  _DespatcherHomePageState createState() => _DespatcherHomePageState();
}

class _DespatcherHomePageState extends State<DespatcherHomePage> with WidgetsBindingObserver {

  List<Map<String, dynamic>>? listOfLoads;
  List<Map<String, dynamic>>? listOfStaffs;
  List<Map<String, dynamic>>? listOfDrivers;
  List<Map<String, dynamic>>? listOfTrucks;
  List<Map<String, dynamic>>? listOfTrailers;

  User? currentuser = FirebaseAuth.instance.currentUser;
  CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");

  bool _hasInternet = true;

  List<Map<String, dynamic>>? listOfDeliveredLoads;

  var errmsg;

  @override
  void initState() {
   // WidgetsBinding.instance.addObserver(this);
    checkInternetConnection();
    getUserDetails();
    getAllStaffs();
    getDelevered();
    getAllDrivers();
    getTrucks();
    getTrailers();
    super.initState();
    getRegLoads();
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
                    height: 3.h,
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      left: 3.w, right: 5, top: 3.h
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                                child: profilePic == null ?
                                LoaderFadingBlue():
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
                  Container(
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
                                        "Employees",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child:
                                  listOfStaffs == null ?
                                  LoaderFadingBlue():
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${listOfStaffs!.length ?? ""}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18.sp),
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
                                            fontSize: 18.sp),
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
                                [Colors.deepOrangeAccent, Colors.lightGreen],
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
                                        "Registered Loads",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child:
                                  listOfLoads == null ? LoaderFadingBlue():
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${listOfLoads!.length ?? ""}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18.sp),
                                      ),
                                      Icon(Icons.done_all, color: Colors.indigo, size: 25.sp,)
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
                                        "Drivers",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child:
                                  listOfDrivers == null ? LoaderFadingBlue():
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${listOfDrivers!.length ?? ""}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18.sp),
                                      ),
                                      Icon(Icons.directions_car, color: Colors.indigo, size: 25.sp,)
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
                                        "Truck",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child:
                                  listOfTrucks == null ? LoaderFadingBlue():
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${listOfTrucks!.length ?? ""}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18.sp),
                                      ),
                                      Icon(Icons.local_shipping, color: Colors.indigo, size: 25.sp,)
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
                                gradient: const LinearGradient(colors: [Colors.red, Colors.yellow],
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
                                        "Trailers",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child:
                                  listOfTrailers == null ? LoaderFadingBlue():
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${listOfTrailers!.length ?? ""}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18.sp),
                                      ),
                                      Icon(Icons.train, color: Colors.indigo, size: 25.sp,)
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
                                            color: Colors.white, fontSize: 18.sp),
                                      ),
                                      Icon(Icons.money, color: Colors.indigo, size: 25.sp,)
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
                          InkWell(onTap: () {
                            Routers.pushNamed(context, '/dsp_manage_loads');
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
                                      const Center(child: Icon(Icons.my_library_add_rounded, color: Colors.black, size: 40,)),

                                      Text("Load Management", style: TextStyle(color: Colors.black, fontSize: 14.sp),)

                                    ],
                                  ),
                                )
                            ),
                          ),
                          InkWell(onTap: (){
                            Routers.pushNamed(context, '/vehicles');

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
                            Routers.pushNamed(context, '/loadsAssignedPreview');

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

                            Routers.pushNamed(context, '/dspDeliveredLoadsManager');

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
                                      const Center(child: Icon(Icons.location_on_rounded, color: Colors.black, size: 40,)),

                                      Text("Location Tracking", style: TextStyle(color: Colors.black, fontSize: 14.sp),)

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
          ): buildNoInternetPopup()

      );
  }

  void getUserDetails() async {
    if (!_hasInternet) {
      return;
    }

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
      setState(() {
        _hasInternet = false;
      });
    }

  }

  Future<void> getRegLoads() async {
     var despatcherID = await LocalStorage().fetch("idKey");
    final AuthRepo authRepo = AuthRepo();

    try{
      Response? response = await authRepo.dspRegLoad({
        "Despatcher_id": despatcherID.toString() });

      if(response != null && response.statusCode == 200
          && response.data["status"] == "success" && response.data["code"] == 200){
        print("print this lineeeeeeeeeeeee eeeeeeeeeeeeeeeeee");
        List regLoads = response.data["data"]["docs"];
        print("print this lineeeeeeeeeeeee eeeeeeeeeeeeeeeeee $despatcherID");
        print("print loadssssssss asssss${regLoads}");
        List<Map<String,dynamic>> data = [];

        if(regLoads.length > 0){
          for(int i = 0; i < regLoads.length; i++){
            Map<String,dynamic> regLoadList = regLoads[i];
            data.add(regLoadList);
          }
        }
        setState(() {
          listOfLoads = data;
        });

        print("printing list of loads asssssss $listOfLoads");

      }else {
        throw Exception("Invalid API response");
      }

    }catch(e, str){
      print("Error occurred: $e");
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");

    }

  }

  void getAllStaffs() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getAllUsers();

      if(response != null && response.statusCode == 200){
        List staffs = response.data["data"]["docs"];

        List<Map<String,dynamic>> data = [];

        if(staffs.length > 0){
          for(int i = 0; i < staffs.length; i++){
            Map<String,dynamic> staffList = staffs[i];
            data.add(staffList);
          }
        }
        setState(() {
          listOfStaffs = data;
        });
      }else {

      }

    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");

    }

  }

  Future getAllDrivers() async {
    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.allDrivers();

      if (response != null && response.statusCode == 200) {
        List regDrivers = response.data["data"]["docs"];

        List<Map<String, dynamic>> data = [];

        if (regDrivers.length > 0) {
          for (int i = 0; i < regDrivers.length; i++) {
            Map<String, dynamic> regDriverList = regDrivers[i];
            data.add(regDriverList);
          }
        }
        setState(() {
          listOfDrivers = data;
        });
      } else {}
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void getTrucks() async {
    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.getAllTrucks();

      if (response != null && response.statusCode == 200) {
        List trucks = response.data["data"]["docs"];

        List<Map<String, dynamic>> data = [];

        if (trucks.length > 0) {
          for (int i = 0; i < trucks.length; i++) {
            Map<String, dynamic> truckList = trucks[i];
            data.add(truckList);
          }
        }
        setState(() {
          listOfTrucks = data;
        });

        print("printing list of vehicles asssssss $listOfTrucks");
      } else {}
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void getTrailers() async {
    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.getAllTrailers();

      if (response != null && response.statusCode == 200) {
        List trailers = response.data["data"]["docs"];

        List<Map<String, dynamic>> data = [];

        if (trailers.length > 0) {
          for (int i = 0; i < trailers.length; i++) {
            Map<String, dynamic> trailerList = trailers[i];
            data.add(trailerList);
          }
        }
        setState(() {
          listOfTrailers = data;
        });

      } else {}
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
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
              SizedBox(height: 1.h,),
              const Center(child: Text("Re-Connect and try again",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
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

  void getDelevered() async {
    var dispatcherID = await LocalStorage().fetch('idKey');
    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.dspDeliveredLoads({
        "Despatcher_id": dispatcherID
      });
      print("dsp id assssssssssss $dispatcherID");

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
