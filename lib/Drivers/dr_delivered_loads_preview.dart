import 'package:darl_dispatch/Utils/loaderFadingBlue.dart';
import 'package:darl_dispatch/Utils/localstorage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../AuthManagers/authRepo.dart';
import '../../../ConstantHelper/colors.dart';
import '../../../Utils/routers.dart';
import '../Models/global_variables.dart';


class DrLoadDeliveredPreview extends StatefulWidget {
  const DrLoadDeliveredPreview({Key? key}) : super(key: key);

  @override
  _DrLoadDeliveredPreviewState createState() => _DrLoadDeliveredPreviewState();
}

class _DrLoadDeliveredPreviewState extends State<DrLoadDeliveredPreview> {
  List<Map<String, dynamic>>? listOfDeliveredLoads;

  var errmsg;


  @override
  void initState() {
    getDelevered();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(height: 0, width: 0,),

                Text("Delivered Loads",
                  style: TextStyle(
                      color: AppColors.dashboardtextcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      decoration: TextDecoration.none),),

                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Colors.indigo, Colors.lightBlueAccent],
                          begin: Alignment.centerLeft, end: Alignment.centerRight
                      ),
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
                          case 1: Routers.pushNamed(context, '/drLoadAssignedPreview');
                          break;

                        }
                      },
                      itemBuilder: (context) =>
                      [
                        PopupMenuItem(
                          value: 1,
                          child: Container(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.assignment,
                                  color: Colors.green,
                                  size: 25,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Assigned Loads",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
              ]),

              Expanded(
                child: Container(
                    child: listOfDeliveredLoads == null ? Center(child: LoaderFadingBlue()):
                    listOfDeliveredLoads!.isEmpty ?
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: 20.h,),
                          Icon(Icons.question_mark, color: Colors.grey, size: 30.sp,),
                           Text(
                            "No Delivered Loads",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp),
                          )
                        ],
                      ),
                    ) : ListView.builder(
                        itemCount: listOfDeliveredLoads!.length,
                        itemBuilder: (context, index){
                          var bolStatus = listOfDeliveredLoads![index]["bolStatus"];
                          return GestureDetector( onTap: (){
                            //  loadDetailsModal(index);
                          },
                            child: Container(
                              height: 33.h,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3.w,),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 1.h,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("RC:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.sp),),
                                            SizedBox(width: 2.w,),
                                            Text(
                                              "${listOfDeliveredLoads![index]["rateConfirmationID"]}",
                                              style: TextStyle(
                                                  color: AppColors.dashboardtextcolor,
                                                  fontSize: 19.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 1.h,
                                        ),

                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Description:",  style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                            SizedBox(width: 2.w,),
                                            Text("${listOfDeliveredLoads![index]["loadDescription"]}",  style: TextStyle(
                                                color: AppColors.dashboardtextcolor,
                                                fontSize: 16.sp,)),
                                          ],

                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Broker Name:",  style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                            SizedBox(width: 2.w,),
                                            Text("${listOfDeliveredLoads![index]["brokerName"]}",  style: TextStyle(
                                                color: AppColors.dashboardtextcolor,
                                                fontSize: 16.sp,)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Broker Tel:",  style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                            SizedBox(width: 2.w,),
                                            Text("${listOfDeliveredLoads![index]["brokerNumber"]}",  style: TextStyle(
                                                color: AppColors.dashboardtextcolor,
                                                fontSize: 16.sp, )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text("Total Pickups:",  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                                SizedBox(width: 1.w,),
                                                Text("${listOfDeliveredLoads![index]["totalPickups"]}",  style: TextStyle(
                                                    color: AppColors.dashboardtextcolor,
                                                    fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                Text("Total Drops:",  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                                SizedBox(width: 1.w,),
                                                Text("${listOfDeliveredLoads![index]["totalDrops"]}",  style: TextStyle(
                                                    color: AppColors.dashboardtextcolor,
                                                    fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 1.5.h,
                                        ),

                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("PAPER WORK:",  style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                            if(bolStatus == "0" || bolStatus == null)
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius: BorderRadius
                                                        .circular(10)
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 3.w,
                                                      vertical: 1.h),
                                                  child: Text("PENDING",  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                                ),
                                              )
                                            else
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius: BorderRadius
                                                        .circular(10)
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 3.w,
                                                      vertical: 1.h),
                                                  child: Text("UPLOADED",  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                                ),
                                              ),
                                          ],
                                        ),

                                        TextButton(onPressed: (){
                                          getIdAndView(index);
                                        }, child: Text("view Details.."))

                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ),
                          );

                        })


                ),
              )
            ],
            )

        ),

      );
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
        print("print all loads assssssssssss $regLoads");
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

  void getIdAndView(int index) {
    loadToBeViewedId = listOfDeliveredLoads![index]["id"];
    loadBrokerName = listOfDeliveredLoads![index]["brokerName"];
    loadBrokerNum = listOfDeliveredLoads![index]["brokerNumber"];
    loadBrokerEmail = listOfDeliveredLoads![index]["brokerEmail"];
    loadShipperEmail = listOfDeliveredLoads![index]["shipperEmail"];
    loadShipperAddress = listOfDeliveredLoads![index]["shipperAddress"];
    loadRateCon = listOfDeliveredLoads![index]["rateConfirmationID"];
    loadAmount = listOfDeliveredLoads![index]["rate"];
    loadWeight = listOfDeliveredLoads![index]["weight"];
    loadBolStatus = listOfDeliveredLoads![index]["bolStatus"];
    loadPickups = listOfDeliveredLoads![index]["totalPickups"];
    loadDrops = listOfDeliveredLoads![index]["totalDrops"];
    Routers.pushNamed(context, '/drLoadsDeleveredDetails');

    print("print load to be viewed as $loadToBeViewedId");
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
