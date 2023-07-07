import 'package:darl_dispatch/AuthManagers/authRepo.dart';
import 'package:darl_dispatch/LandingPageManagers/dispatcher_landing_page_manager.dart';
import 'package:darl_dispatch/Models/global_variables.dart';
import 'package:darl_dispatch/Utils/form_validators.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../ConstantHelper/colors.dart';
import '../../../Utils/localstorage.dart';
import '../../../Utils/progress_bar.dart';
import '../../../Utils/routers.dart';

class AssignLoadToDriver extends StatefulWidget {
  const AssignLoadToDriver({Key? key}) : super(key: key);

  @override
  State<AssignLoadToDriver> createState() => _AssignLoadToDriverState();
}

class _AssignLoadToDriverState extends State<AssignLoadToDriver>
    with FormValidators {

  var successMssg;
  var resetPassErrorMssg;

  TextEditingController dateAssignController = TextEditingController();

  bool loading = false;
  bool valChecked = false;

  var rateCon;
  var userId;
  bool checkValue = false;

  List<Map<String, dynamic>>? listOfDispatchers;
  List<Map<String, dynamic>>? listOfTrailers;
  List<Map<String, dynamic>>? listOfDrivers;
  List<Map<String, dynamic>>? listOfTrucks;

  var drvName;
  var stfName;
  var driversID;
  var staffsID;
  var trailerNumber;
  var truckNumber;

  var trailerPlateNumber;
  var truckPlateNumber;

  String? formatedDate;


  void allowAssign(){
     startLoader();
      assign();
  }

  @override
  void initState() {
    getTodaysDay();
    getLoadDetails();
    getUser();
    getAllDrivers();
    getDispatcher();
    getTrailers();
    getTrucks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Assign Load",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                SizedBox(
                  height: 0.5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        Text("RC:", style: TextStyle(color: Colors.black,
                            fontSize: 20.sp, fontWeight: FontWeight.bold),),
                       SizedBox(width: 2.w,),
                       Text(
                        "${rateCon ?? ""}",
                        style: TextStyle(
                            color: AppColors.dashboardtextcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            decoration: TextDecoration.none),
                      ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),

                SizedBox(
                  height: 0.5.h,
                ),
                InkWell(onTap: (){
                  driversModal();
                },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 0.7,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),

                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text("Choose a Driver", style: TextStyle(fontSize: 17.sp,
                           fontWeight: FontWeight.bold, color: Colors.white),),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 5.h,
                  width: MediaQuery.of(context).size.width / 0.7,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "${drvName ?? ""}",
                      style: TextStyle(color: Colors.black, fontSize: 17.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(onTap: (){
                  dispatchModal();
                },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 0.7,
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),

                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose A Sub Dispatcher", style: TextStyle(fontSize: 17.sp,
                              fontWeight: FontWeight.bold, color: Colors.white),),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 5.h,
                  width: MediaQuery.of(context).size.width / 0.7,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "${stfName ?? ""}",
                      style: TextStyle(color: Colors.black, fontSize: 17.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                InkWell(onTap: (){
                  trailerModal();
                },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 0.7,
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),

                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose A Trailer", style: TextStyle(fontSize: 17.sp,
                              fontWeight: FontWeight.bold, color: Colors.white),),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 5.h,
                  width: MediaQuery.of(context).size.width / 0.7,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "${trailerPlateNumber ?? ""}",
                      style: TextStyle(color: Colors.black, fontSize: 17.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                SizedBox(
                  height: 2.h,
                ),
                InkWell(onTap: (){
                  truckModal();
                },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 0.7,
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),

                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choose A Truck", style: TextStyle(fontSize: 17.sp,
                              fontWeight: FontWeight.bold, color: Colors.white),),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 5.h,
                  width: MediaQuery.of(context).size.width / 0.7,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "${truckPlateNumber ?? ""}",
                      style: TextStyle(color: Colors.black, fontSize: 17.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                SizedBox(
                  height: 15.h,
                ),

                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Confirm to assign load",
                      style: TextStyle(color: Colors.black, fontSize: 16.sp),),
                    Checkbox(
                      side: BorderSide(
                          color: Colors.black, width: 2),
                      checkColor: Colors.black,
                      activeColor: Colors.green,
                      value: valChecked,
                      onChanged: (value){
                        setState(() {
                          valChecked = value ?? false;
                        });
                      },
                    ),
                  ],
                ),

                loading ? ProgressBar()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide.none)),
                        onPressed:
                          valChecked ? allowAssign: null,

                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 2.h),
                          child: Text(
                            "Assign",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void assign() async {
    final AuthRepo authRepo = AuthRepo();

    try {
      Response? response = await authRepo.assignLoad({
        "load_id": loadIdForAssign.toString(),
        "driver_id": driversID,
        "date_assigned": formatedDate.toString(),
        "assignedBy": userId,
        "subDispatcher": staffsID,
        "trailer": trailerNumber ?? "",
        "truck": truckNumber ?? "",

      });

      if (response != null && response.statusCode == 200) {
        stopLoader();
        showPopUp();
      } else {
        setState(() {
          resetPassErrorMssg = response?.data["message"];
        });

        desplayErromssge();
      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }

    setState(() {
      loading = false;
    });
  }

  void desplayErromssge() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          "$resetPassErrorMssg",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  void showPopUp() {
    loading = false;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
              child: Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 40.sp,
          )),
          SizedBox(
            height: 15,
          ),
          const Center(
            child: Text(
              " Success!",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          const Center(
            child: Text(
              " Load Was Assigned ",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          const Center(
            child: Text(
              "Successfully",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Center(
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/loadsAssignedPreview');
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void getLoadDetails() async {
    final AuthRepo authRepo = AuthRepo();

    print("load id as....................$loadIdForAssign");
    try {
      Response? response =
          await authRepo.fetchSingleLoad({"id": loadIdForAssign.toString()});

      if (response != null && response.statusCode == 200) {
        setState(() {
          rateCon = response.data["Rate ConfirmationID"];
        });
      } else {
        print("could not retreive it");
      }
    } catch (e, str) {
      debugPrint("error $e");
      debugPrint("StackTrace: $str");
    }
  }

  void getUser() async {
    userId = await LocalStorage().fetch("idKey");
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

        print("printing list of vehicles asssssss $listOfTrailers ");
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

  void driversModal() {
    showModalBottomSheet<dynamic>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Wrap(children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.grey,
                      height: 5,
                      thickness: 5,
                      indent: 150,
                      endIndent: 150,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "Registered Drivers",
                      style: TextStyle(
                          color: AppColors.dashboardtextcolor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40.h,
                      child: listOfDrivers == null
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.blue,
                            ))
                          : listOfDrivers!.isEmpty
                              ? Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.question_mark,
                                        color: Colors.grey,
                                        size: 40.sp,
                                      ),
                                      const Text(
                                        "No Registered Pickup Yet",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: listOfDrivers!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        saveDriverDetail(index);
                                      },
                                      child: Container(
                                        height: 8.h,
                                        child: Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 3.w,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const CircleAvatar(
                                                        backgroundColor:
                                                            Colors.green,
                                                        child: Icon(
                                                          Icons.person,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${listOfDrivers![index]["name"]}",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 19.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                    ),
                  ],
                ),
              ),
            ),
          ]);
        });
  }

  void dispatchModal() {
    showModalBottomSheet<dynamic>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Wrap(children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Column(
                  children: [
                    Divider(
                      color: Colors.grey,
                      height: 5,
                      thickness: 5,
                      indent: 150,
                      endIndent: 150,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "Registered Dispatcher",
                      style: TextStyle(
                          color: AppColors.dashboardtextcolor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40.h,
                      child: listOfDispatchers == null
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.blue,
                            ))
                          : listOfDispatchers!.isEmpty
                              ? Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.question_mark,
                                        color: Colors.grey,
                                        size: 40.sp,
                                      ),
                                      const Text(
                                        "No Registered Pickup Yet",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: listOfDispatchers!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        saveStaffDetails(index);
                                        print(
                                            "print index hererrrrrrrr $testname");
                                      },
                                      child: Container(
                                        height: 8.h,
                                        child: Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 3.w,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      CircleAvatar(
                                                        child: Icon(
                                                          Icons.person,
                                                          color: Colors.white,
                                                        ),
                                                        backgroundColor:
                                                            Colors.green,
                                                      ),
                                                      Text(
                                                        "${listOfDispatchers![index]["name"]}",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 19.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                    ),
                  ],
                ),
              ),
            ),
          ]);
        });
  }

  void trailerModal() {
    showModalBottomSheet<dynamic>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Wrap(children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Column(
                  children: [
                    Divider(
                      color: Colors.grey,
                      height: 5,
                      thickness: 5,
                      indent: 150,
                      endIndent: 150,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "Registered Trailers",
                      style: TextStyle(
                          color: AppColors.dashboardtextcolor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40.h,
                      child: listOfTrailers == null
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.blue,
                            ))
                          : listOfTrailers!.isEmpty
                              ? Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.question_mark,
                                        color: Colors.grey,
                                        size: 40.sp,
                                      ),
                                      const Text(
                                        "No Registered Trailer Yet",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: listOfTrailers!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        saveTrailerDetails(index);
                                      },
                                      child: Container(
                                        height: 10.h,
                                        child: Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 3.w,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                     Text("Number Plate:", style: TextStyle(color: Colors.indigo,
                                                     fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                                      SizedBox(width: 4.w,),
                                                          Text(
                                                            "${listOfTrailers![index]["plateNumber"]}",
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 19.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 1.h,),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Text("Trailer Number:", style: TextStyle(color: Colors.indigo,
                                                          fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                                      SizedBox(width: 4.w,),
                                                      Text(
                                                        "${listOfTrailers![index]["number"]}",
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 17.sp,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                    ),
                  ],
                ),
              ),
            ),
          ]);
        });
  }
  void truckModal() {
    showModalBottomSheet<dynamic>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Wrap(children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Column(
                  children: [
                    Divider(
                      color: Colors.grey,
                      height: 5,
                      thickness: 5,
                      indent: 150,
                      endIndent: 150,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "Registered Trucks",
                      style: TextStyle(
                          color: AppColors.dashboardtextcolor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40.h,
                      child: listOfTrucks == null
                          ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ))
                          : listOfTrucks!.isEmpty
                          ? Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.question_mark,
                              color: Colors.grey,
                              size: 40.sp,
                            ),
                            const Text(
                              "No Registered Trucks Yet",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      )
                          : ListView.builder(
                          itemCount: listOfTrucks!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                saveTruckDetails(index);
                              },
                              child: Container(
                                height: 10.h,
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 3.w,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Text("Number Plate:", style: TextStyle(color: Colors.indigo,
                                                  fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                              SizedBox(width: 4.w,),
                                              Text(
                                                "${listOfTrucks![index]["plateNumber"]}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 19.sp,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 1.h,),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Text("Truck Number:", style: TextStyle(color: Colors.indigo,
                                                  fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                              SizedBox(width: 4.w,),
                                              Text(
                                                "${listOfTrucks![index]["number"]}",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 17.sp,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ]);
        });
  }

  void getDispatcher() async {
    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.getAllDispatchers();

      if (response != null && response.statusCode == 200) {
        List dispatchers = response.data["data"]["docs"];

        List<Map<String, dynamic>> data = [];

        if (dispatchers.length > 0) {
          for (int i = 0; i < dispatchers.length; i++) {
            Map<String, dynamic> dispatcherList = dispatchers[i];
            data.add(dispatcherList);
          }
        }
        setState(() {
          listOfDispatchers = data;
        });

        print("printing list of loads asssssss $listOfDispatchers ");
      } else {}
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void saveDriverDetail(int index) {
    driversID = listOfDrivers![index]["id"];
    Navigator.of(context).pop();
    setState(() {
      drvName = listOfDrivers![index]["name"];
    });
    print("drivers id as ...............$driversID");
  }

  void saveStaffDetails(int index) {
    staffsID = listOfDispatchers![index]["id"];
    Navigator.of(context).pop();
    setState(() {
      stfName = listOfDispatchers![index]["name"];
    });
    print("staff id as ...............$staffsID");
  }

  void saveTrailerDetails(int index) {
    trailerNumber = listOfTrailers![index]["number"];
    Navigator.of(context).pop();
    setState(() {
      trailerPlateNumber = listOfTrailers ![index]["plateNumber"];
    });

  }

  void saveTruckDetails(int index) {
    truckNumber = listOfTrucks![index]["number"];
    Navigator.of(context).pop();
    setState(() {
      truckPlateNumber = listOfTrucks![index]["plateNumber"];
    });

  }

  void getTodaysDay() {
     var currentDate = new DateTime.now();
     var formater = new DateFormat("yyyy-MM-dd");
     formatedDate = formater.format(currentDate);
  }

  Future<void> startLoader() async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.white, // can change this to your prefered color
          children: <Widget>[
            Center(
              child: ProgressBar(),
            )
          ],
        );
      },
    );
  }

  Future<void> stopLoader() async {
    Navigator.of(context).pop();
  }

}
