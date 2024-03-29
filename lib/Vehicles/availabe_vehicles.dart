import 'package:darl_dispatch/Utils/loaderFadingBlue.dart';
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../../ConstantHelper/colors.dart';
import '../../Models/global_variables.dart';

class AvailableVehicles extends StatefulWidget {
  const AvailableVehicles({Key? key}) : super(key: key);

  @override
  _AvailableVehiclesState createState() => _AvailableVehiclesState();
}

class _AvailableVehiclesState extends State<AvailableVehicles> {
  List<Map<String, dynamic>>? listOfVehicles;

  var errMsg;
  @override
  void initState() {
    getRegVehicles();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Registered Vehicles", style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold)),
      ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
              child: Container(
                child: listOfVehicles == null ? Center(child: LoaderFadingBlue()):
                listOfVehicles!.isEmpty ?
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 15.h,),
                      Icon(Icons.question_mark, color: Colors.grey, size: 30.sp,),
                      const Text(
                        "No Registered Vehicles ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                )
                :ListView.builder(
                    itemCount: listOfVehicles!.length,
                    itemBuilder: (context, index){
                    return  Container(
                      height: 20.h,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 1.h,),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "NUMBER PLATE:",
                                          style: TextStyle(
                                              color: AppColors.dashboardtextcolor,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 4.w,),
                                        Text(
                                          "${listOfVehicles![index][ "plateNumber"]}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp, fontWeight: FontWeight.bold
                                              ),
                                        ),

                                      ],
                                    ),
                                    PopupMenuButton(
                                        color: Colors.black,
                                        elevation: 20,
                                        shape: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15)),
                                        icon: const Center(
                                          child: Icon(
                                            Icons.more_vert,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                        ),

                                        onSelected: (val){
                                          switch(val){
                                            case 1: ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                content: Text("work in progress, try again later"),
                                              duration: Duration(seconds: 2),));
                                            break;
                                            case 2: editVehicle(index);
                                            break;
                                            case 3: showPopup(index);
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
                                                      Icons.check_circle,
                                                      color: Colors.green,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      "Assign",
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
                                            value: 3,
                                            child: Container(
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15.sp,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                            ),
                                          ),

                                        ]),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "VEHICLE ID:",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    Text(
                                      "${listOfVehicles![index]["number"]}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 1.h,),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "VEHICLE TYPE:",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 7.w,),
                                    Text(
                                      "${listOfVehicles![index][ "vehicleType"]}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 1.h,),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "VIN:",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 24.w,),
                                    Text(
                                      "${listOfVehicles![index][ "vin"]}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h,),

                              ],
                            ),
                          ),
                        ),
                      ),
                    );

                })
              ),
          ),


      );
  }

  void getRegVehicles() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getAllVehicles();

      if(response != null && response.statusCode == 200 && response.data["status"] == "success"){
        List regVehicles = response.data["data"]["docs"];
        List<Map<String,dynamic>> data = [];

        if(regVehicles.length > 0){
          for(int i = 0; i < regVehicles.length; i++){
            Map<String,dynamic> regVehicleList = regVehicles[i];
            data.add(regVehicleList);
          }
        }
        setState(() {
          listOfVehicles = data;
        });

      }else {

      }

    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");

    }

  }

  void showPopup(index) {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
            backgroundColor: Colors.black87,
            actions: <Widget>[SizedBox(height: 3.h,),
              Center(child: Icon(Icons.warning_amber,
                color: Colors.yellow, size: 35.sp,)),
              SizedBox(height: 5.h,),
              Center(
                child: Text(" Do you want to",
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              Center(
                child: Text(" delete this Vehicle?",
                  style: TextStyle(
                      fontSize: 17.sp, color: Colors.white
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.indigo[500]),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("NO", style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ],
                      )),
                  TextButton(
                    onPressed: () {
                      deleteVehicle(index);
                      Navigator.of(context).pop();
                    },
                    child:
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("YES", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),

            ],
          ),
    );

  }

  void deleteVehicle(index) async {
    var vehicleID = listOfVehicles![index]["id"];
    final AuthRepo authRepo = AuthRepo();

    try{
      Response? response = await authRepo.deletVehicle({
        "id": vehicleID.toString()

      });
      print("print load id assssssssssssss $vehicleID ");

      if(response != null && response.statusCode == 200 && response.data["success"] == 200){
        showSuccessDialog();
        getRegVehicles();

      }else{
        showErr();
        setState(() {
          errMsg = response!.data["message"];
        });

      }
    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }

  }

  void showSuccessDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("Vehicle Deleted Successfuly",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

  }

  void showErr() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("$errMsg",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

  }

  void editVehicle(int index) {
    vehicleID = listOfVehicles![index]["id"];
    Routers.pushNamed(context, '/editVehicle');

  }

}
