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

class ReAssignLoadToDriver extends StatefulWidget {
  const ReAssignLoadToDriver({Key? key}) : super(key: key);

  @override
  State<ReAssignLoadToDriver> createState() => _ReAssignLoadToDriverState();
}

class _ReAssignLoadToDriverState extends State<ReAssignLoadToDriver>
    with FormValidators {

  var successMssg;
  var resetPassErrorMssg;

  bool loading = false;
  bool valChecked = false;
  List<Map<String, dynamic>>? listOfDrivers;


  var drvName;
  var driversID;

  void allowAssign(){
    startLoader();
    reAssign();
  }

  @override
  void initState() {
    getAllDrivers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Re-Assign Load",
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
                      ratconForReassign ?? "",
                      style: TextStyle(
                          color: AppColors.dashboardtextcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          decoration: TextDecoration.none),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
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
                  height: 45.h,
                ),

                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Confirm to re-assign load",
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
                        "Re-Assign",
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

  void reAssign() async {
    final AuthRepo authRepo = AuthRepo();

    try {
      Response? response = await authRepo.reAssignLoad({
        "load_id": loadToBereassignedId.toString(),
        "driver_id": driversID,
      });
         print("load to reassinged iddddddddddddddddd");
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
              " Load has been re-Assigned ",
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

  Future getAllDrivers() async {
    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.nonActiveDrivers();

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

  void saveDriverDetail(int index) {
    driversID = listOfDrivers![index]["id"];
    Navigator.of(context).pop();
    setState(() {
      drvName = listOfDrivers![index]["name"];
    });
    print("drivers id as ...............$driversID");
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
