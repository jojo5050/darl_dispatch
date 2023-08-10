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

class SelectVehicleIncome extends StatefulWidget {
  const SelectVehicleIncome({Key? key}) : super(key: key);

  @override
  State<SelectVehicleIncome> createState() => _SelectVehicleIncomeState();
}

class _SelectVehicleIncomeState extends State<SelectVehicleIncome>
    with FormValidators {

  var successMssg;
  var resetPassErrorMssg;

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  final GlobalKey<FormState> inputKey = GlobalKey<FormState>();

  bool loading = false;
  bool valChecked = false;

  var rateCon;
  var userId;
  bool checkValue = false;

  List<Map<String, dynamic>>? listOfTrailers;
  List<Map<String, dynamic>>? listOfVehicles;
  List<Map<String, dynamic>>? listOfTrucks;



  String? formatedDate;

  var vehicle_id;
  var vehiclePlateNumber;

  List<Map<String, dynamic>>? listOfIncomes;

  var incomeError;

  @override
  void initState() {
    getAllVehicles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 6.h),
        child: SingleChildScrollView(
          child: Form(
            key: inputKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: Icon(Icons.arrow_back_ios)),
                ),
                SizedBox(
                  height: 3.h,
                ),
                 InkWell(onTap: (){
                   vehiclesModal();
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
                          Text("select vehicle", style: TextStyle(fontSize: 17.sp,
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
                      "${vehiclePlateNumber ?? ""}",
                      style: TextStyle(color: Colors.black, fontSize: 17.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                SizedBox(height: 5.h,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                        Container(
                          width: 45.w,
                          child: TextFormField(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1960),
                                  lastDate: DateTime(2025));
                              if (pickedDate != null) {
                                print("..........................$pickedDate");
                                String formatDate =
                                DateFormat("dd-MM-yyyy").format(pickedDate);
                                setState(() {
                                  endDateController.text = formatDate;
                                });
                              } else {
                                print("...............Date is empty");
                              }
                            },
                            validator: validateDate,
                            controller: endDateController,
                            style: TextStyle(color: Colors.black, fontSize: 18.sp),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(
                                    20.0,
                                  ),
                                  borderSide:
                                  BorderSide(width: 2, color: Colors.pink),
                                ),
                                labelText: 'Start Date'),
                            readOnly: true,
                          ),
                        ),

                        Container(
                          width: 45.w,
                          child: TextFormField(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1960),
                                  lastDate: DateTime(2025));
                              if (pickedDate != null) {
                                print("..........................$pickedDate");
                                String formatDate =
                                DateFormat("dd-MM-yyyy").format(pickedDate);
                                setState(() {
                                  startDateController.text = formatDate;
                                });
                              } else {
                                print("...............Date is empty");
                              }
                            },
                            validator: validateDate,
                            controller: startDateController,
                            style: TextStyle(color: Colors.black, fontSize: 18.sp),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    20.0,
                                  ),
                                  borderSide:
                                  BorderSide(width: 2, color: Colors.pink),
                                ),
                                labelText: 'End Date'),
                            readOnly: true,
                          ),
                        ),
                      ],
                ),
                SizedBox(height: 3.h,),

                SizedBox(
                  height: 30.h,
                ),

                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide.none)),
                    onPressed: (){
                      if(inputKey.currentState!.validate()){
                        setState(() {
                          startLoader();
                          getVehicleIncome();
                        });
                      }



                    },

                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 2.h),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
            ]
          ),
        ),
      ),
    ));
  }

  void getVehicleIncome() async {
    final AuthRepo authRepo = AuthRepo();

    try {
      Response? response = await authRepo.vehicleIncome({
        "vehicle_id": vehicle_id,
        "start_date": startDateController.text,
        "end_date": endDateController.text
      });

      if (response != null && response.statusCode == 200
          && response.data["status"] == 200) {
        stopLoader();
        List vehicleIncome = response.data["data"];
        List<Map<String, dynamic>> data = [];

        if (vehicleIncome.length > 0) {
          for (int i = 0; i < vehicleIncome.length; i++) {
            Map<String, dynamic> incomeList = vehicleIncome[i];
            data.add(incomeList);
          }
        }
        setState(() {
          listOfIncomes = data;
        });
        showIncomeModal();

      } else {
        setState(() {
          incomeError = response?.data["message"];
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
          "$incomeError",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Future getAllVehicles() async {
    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.getAllVehicles();

      if (response != null && response.statusCode == 200) {
        List regVehicles = response.data["data"]["docs"];

        List<Map<String, dynamic>> data = [];

        if (regVehicles.length > 0) {
          for (int i = 0; i < regVehicles.length; i++) {
            Map<String, dynamic> regDriverList = regVehicles[i];
            data.add(regDriverList);
          }
        }
        setState(() {
          listOfVehicles = data;
        });
      } else {
        return;
      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void vehiclesModal() {
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
                      "Registered Vehicles",
                      style: TextStyle(
                          color: AppColors.dashboardtextcolor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40.h,
                      child: listOfVehicles == null
                          ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ))
                          : listOfVehicles!.isEmpty
                          ? Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.question_mark,
                              color: Colors.grey,
                              size: 40.sp,
                            ),
                            const Text(
                              "No Vehicle Found",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      )
                          : ListView.builder(
                          itemCount: listOfVehicles!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                saveVehicleDetails(index);
                              },
                              child: Container(
                                height: 15.h,
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
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Number Plate:", style: TextStyle(color: Colors.indigo,
                                                  fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                              SizedBox(width: 4.w,),
                                              Text(
                                                "${listOfVehicles![index]["plateNumber"]}",
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
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("VIN:", style: TextStyle(color: Colors.indigo,
                                                  fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                              SizedBox(width: 4.w,),
                                              Text(
                                                "${listOfVehicles![index]["vin"]}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 1.h,),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Vehicle Type:", style: TextStyle(color: Colors.indigo,
                                                  fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                              SizedBox(width: 4.w,),
                                              Text(
                                                "${listOfVehicles![index]["vehicleType"]}",
                                                style: TextStyle(
                                                    color: Colors.black,
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

  void saveVehicleDetails(int index) {
    vehicle_id = listOfVehicles![index]["id"];
    Navigator.of(context).pop();
    setState(() {
      vehiclePlateNumber = listOfVehicles![index]["plateNumber"];
    });

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

  void showIncomeModal() {
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
                      " ${startDateController.text} "" -- "" ${endDateController.text}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40.h,
                      child: listOfIncomes == null
                          ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ))
                          : listOfIncomes!.isEmpty
                          ? Center(
                        child: Column(
                          children: [
                            SizedBox(height: 10.h,),
                            Icon(
                              Icons.question_mark,
                              color: Colors.grey,
                              size: 40.sp,
                            ),
                            const Text(
                              "No Record Found",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      )
                          : ListView.builder(
                          itemCount: listOfIncomes!.length,
                          itemBuilder: (context, index) {
                            return Container(
                                height: 15.h,
                                child: Card(
                                  elevation: 2,
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
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Number Plate:", style: TextStyle(color: Colors.indigo,
                                                  fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                              SizedBox(width: 4.w,),
                                              Text(
                                                "${listOfVehicles![index]["plateNumber"]}",
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
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("VIN:", style: TextStyle(color: Colors.indigo,
                                                  fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                              SizedBox(width: 4.w,),
                                              Text(
                                                "${listOfVehicles![index]["vin"]}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 1.h,),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Vehicle Type:", style: TextStyle(color: Colors.indigo,
                                                  fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                              SizedBox(width: 4.w,),
                                              Text(
                                                "${listOfVehicles![index]["vehicleType"]}",
                                                style: TextStyle(
                                                    color: Colors.black,
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

}
