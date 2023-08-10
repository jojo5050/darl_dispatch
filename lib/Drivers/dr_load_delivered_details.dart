import 'dart:convert';
import 'dart:io';

import 'package:darl_dispatch/Utils/full_bol_view.dart';
import 'package:darl_dispatch/Utils/loaderFadingBlue.dart';
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../AuthManagers/authRepo.dart';
import '../../../ConstantHelper/colors.dart';
import '../../../Models/global_variables.dart';
import '../Utils/bol_picker_manager.dart';
import '../Utils/image_picker_manager.dart';
import '../Utils/localstorage.dart';
import 'package:http/http.dart' as http;

import '../Utils/progress_bar.dart';

class DrLoadDeliveredDetails extends StatefulWidget {
  const DrLoadDeliveredDetails({Key? key}) : super(key: key);

  @override
  _DrLoadDeliveredDetailsState createState() => _DrLoadDeliveredDetailsState();
}

class _DrLoadDeliveredDetailsState extends State<DrLoadDeliveredDetails> {

  var errMsg;
  List<Map<String, dynamic>>? listOfDrops;
  List<Map<String, dynamic>>? listOfPickups;
  var compName;

  var compAddress;

  var compPoBox;

  var compState;

  var compCity;

  var driverTel;

  var driverName;

  BolPickerManager bolPickerManager = BolPickerManager();

  File? profileImage;

  var messageValue;

  bool imageLoading = false;

  var resValue;

  var msgValue;

  var bolImage;


  @override
  void initState() {
    getCompanyDetails();
    getBol();
    getPickup();
    getDrop();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: Column(children: [
            Row(children: [IconButton(onPressed: (){Navigator.of(context).pop();},
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black,))],),
            Column(children: [
              Text("${compName ?? ""}", style: TextStyle(color: Colors.blue,
                  fontSize: 19.sp, fontWeight: FontWeight.bold ),),
              SizedBox(height: 1.h,),
              Text("${compAddress ?? ""}", style: TextStyle(color: Colors.black,
                  fontSize: 17.sp, fontWeight: FontWeight.bold ),),
              SizedBox(height: 1.h,),
              Text("${compPoBox ?? ""}", style: TextStyle(color: Colors.black,
                  fontSize: 17.sp, fontWeight: FontWeight.bold ),),
              Text("${compState ?? ""}", style: TextStyle(color: Colors.black,
                  fontSize: 17.sp, fontWeight: FontWeight.bold ),),
              SizedBox(height: 1.h,),
              Text("${compCity ?? ""}", style: TextStyle(color: Colors.black,
                  fontSize: 17.sp, fontWeight: FontWeight.bold ),),
              SizedBox(height: 1.h,),
            ],),

            const Divider(
              color: Colors.grey,
              height: 2,
              thickness: 2,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(height: 1.h,),
            Container(
              height: 45.h,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 1.h,),

                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("RC:",  style: TextStyle(
                                color: Colors.black,
                                fontSize: 19.sp, fontWeight: FontWeight.bold)),
                            SizedBox(width: 2.w,),

                            Text(loadRateCon ?? "",  style: TextStyle(
                                color: AppColors.dashboardtextcolor,
                                fontSize: 19.sp, fontWeight: FontWeight.bold)),
                          ],

                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Rate \$:",  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                SizedBox(width: 2.w,),
                                Text(loadAmount ?? "",  style: TextStyle(
                                    color: AppColors.dashboardtextcolor,
                                    fontSize: 17.sp,)),
                              ],
                            ),


                            Row(
                              children: [
                                Text("Weight(Kg):",  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                SizedBox(width: 2.w,),

                                Text(loadWeight ?? "",  style: TextStyle(
                                    color: AppColors.dashboardtextcolor,
                                    fontSize: 17.sp, )),
                              ],
                            ),
                          ],

                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Broker Name:",  style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                            SizedBox(width: 2.w,),

                            Text(loadBrokerName?? "",  style: TextStyle(
                                color: AppColors.dashboardtextcolor,
                                fontSize: 17.sp,)),
                          ],

                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Broker Email:",  style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                            SizedBox(width: 2.w,),

                            Text(loadBrokerEmail ?? "",  style: TextStyle(
                                color: AppColors.dashboardtextcolor,
                                fontSize: 17.sp, )),
                          ],

                        ),
                        SizedBox(height: 1.5.h,),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Broker Number:",  style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                            SizedBox(width: 2.w,),

                            Text(loadBrokerNum ?? "",  style: TextStyle(
                                color: AppColors.dashboardtextcolor,
                                fontSize: 17.sp, )),
                          ],

                        ),

                        SizedBox(
                          height: 1.5.h,
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Shipper Email:",  style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                            SizedBox(width: 2.w,),

                            Text(loadShipperEmail ?? "",  style: TextStyle(
                                color: AppColors.dashboardtextcolor,
                                fontSize: 17.sp, )),
                          ],

                        ),

                        /*SizedBox(height: 1.5.h,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Driver Name:",  style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                            SizedBox(width: 2.w,),

                            Text("${driverName ?? ""}",  style: TextStyle(
                                color: AppColors.dashboardtextcolor,
                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                          ],

                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Driver Number:",  style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                            SizedBox(width: 2.w,),

                            Text("${driverTel ?? ""}",  style: TextStyle(
                                color: AppColors.dashboardtextcolor,
                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                          ],

                        ),
*/
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

                                SizedBox(width: 2.w,),
                                Text(loadPickups ?? "",  style: TextStyle(
                                    color: AppColors.dashboardtextcolor,
                                    fontSize: 17.sp,)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Total Drops:",  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                SizedBox(width: 2.w,),

                                Text(loadDrops ?? "",  style: TextStyle(
                                    color: AppColors.dashboardtextcolor,
                                    fontSize: 17.sp,)),
                              ],
                            ),
                          ],

                        ),

                        SizedBox(
                          height: 1.5.h,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Shipper Address:",  style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                            SizedBox(width: 2.w,),

                            Text(loadShipperAddress ?? "",  style: TextStyle(
                                color: AppColors.dashboardtextcolor,
                                fontSize: 17.sp,)),
                          ],

                        ),
                        SizedBox(height: 2.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "PAPER WORK:",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            if (loadBolStatus == "0" || loadBolStatus == null)
                              bolImage == null ? LoaderFadingBlue():
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _getImage(context);
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                                      child: Text(
                                        "PENDING",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              bolImage == null ? LoaderFadingBlue():
                              Row(
                                children: [
                                  InkWell(onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FullBolImage(
                                          url: bolImage,
                                        ),
                                      ),
                                    );

                                  },
                                    child: Container(
                                      height: 7.h, width: 10.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage(bolImage ?? ""))
                                      ),),
                                  ),
                                  SizedBox(width: 1.w,),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                                      child: Text(
                                        "UPLOADED",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 5.h,),
            Text("Pickups", style: TextStyle(color: AppColors.dashboardtextcolor,
                fontSize: 19.sp, fontWeight: FontWeight.bold ),),
            SizedBox(height: 0.5.h,),
            const Divider(
              color: Colors.grey,
              height: 2,
              thickness: 2,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(height: 1.h,),
            Container(
              height: 45.h,
              child: listOfPickups == null ? Center(child: LoaderFadingBlue()):
              listOfPickups!.isEmpty ?
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 10.h,),
                    Icon(Icons.question_mark, color: Colors.grey, size: 40.sp,),
                    const Text(
                      "No Pickup ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
              ) : ListView.builder(
                  itemCount: listOfPickups!.length,
                  itemBuilder: (context, index){

                    var pickStatus = listOfPickups![index]["pickedStatus"];
                    return GestureDetector( onTap: (){

                    },
                      child: Container(
                        height: 36.h,
                        child: Card(
                          color: Colors.green,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3.w,),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 1.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("Pickup State:",  style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 4.w,),
                                              Text("${listOfPickups![index]["state"]}",  style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                            ],

                                          ),
                                         /* PopupMenuButton(
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
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  value: 1,
                                                  child: Container(
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        //  showPopup(index);
                                                      },
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
                                                ),

                                              ]),*/
                                        ],
                                      ),

                                      SizedBox(
                                        height: 1.h,
                                      ),

                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Pickup City:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfPickups![index]["city"]}",  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                        ],

                                      ),

                                      SizedBox(height: 1.5.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Pickup date:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfPickups![index]["date"]}",  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                        ],

                                      ),

                                      SizedBox(height: 1.5.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Pickup Time:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfPickups![index]["time"]}",  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                        ],

                                      ),
                                      SizedBox(height: 1.5.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Pickup ZipCode:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfPickups![index]["stateZipCode"]}",  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                        ],

                                      ),

                                      SizedBox(height: 1.5.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Address",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfPickups![index]["address"]}",  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                        ],

                                      ),
                                      SizedBox(height: 2.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("PICK STATUS:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),

                                          if(pickStatus == "0" || pickStatus == null)
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius
                                                      .circular(10)
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 3.w,
                                                    vertical: 1.h),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius: BorderRadius.circular(15)
                                                  ),
                                                  child: Text("PENDING", style: TextStyle(color: Colors.red,
                                                      fontWeight: FontWeight.bold),),
                                                ),
                                              ),
                                            )
                                          else
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius
                                                      .circular(10)
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 3.w,
                                                    vertical: 1.h),
                                                child: Text("PICKED", style: TextStyle(color: Colors.black,
                                                    fontWeight: FontWeight.bold),),
                                              ),
                                            )
                                        ],

                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ),
                    );

                  }),
            ),
            SizedBox(height: 4.h,),
            Text("Drops", style: TextStyle(color: AppColors.dashboardtextcolor,
                fontSize: 19.sp, fontWeight: FontWeight.bold ),),
            SizedBox(height: 0.5.h,),
            const Divider(
              color: Colors.grey,
              height: 2,
              thickness: 2,
              indent: 0,
              endIndent: 0,
            ),
            SizedBox(height: 1.h,),
            Container(
              height: 45.h,
              child: listOfDrops == null ? Center(child: LoaderFadingBlue()):
              listOfDrops!.isEmpty ?
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 10.h,),
                    Icon(Icons.question_mark, color: Colors.grey, size: 40.sp,),
                    const Text(
                      "No Drop",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
              ) : ListView.builder(
                  itemCount: listOfDrops!.length,
                  itemBuilder: (context, index){
                    var dropStatus = listOfDrops![index]["status"];
                    return GestureDetector( onTap: (){

                    },
                      child: Container(
                        height: 36.h,
                        child: Card(
                          color: Colors.grey,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3.w,),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 1.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Text("Drop State:",  style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 4.w,),
                                              Text("${listOfDrops![index]["state"]}",  style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                            ],

                                          ),
                                         /* PopupMenuButton(
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
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  value: 1,
                                                  child: Container(
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        //  showPopup(index);
                                                      },
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
                                                ),

                                              ]),*/
                                        ],
                                      ),

                                      SizedBox(
                                        height: 1.h,
                                      ),

                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Drop City:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfDrops![index]["city"]}",  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                        ],

                                      ),

                                      SizedBox(height: 1.5.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Drop date:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfDrops![index]["date"]}",  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                        ],

                                      ),

                                      SizedBox(height: 1.5.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Drop Time:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfDrops![index]["time"]}",  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                        ],

                                      ),
                                      SizedBox(height: 1.5.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Drop ZipCode:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfDrops![index]["stateZipCode"]}",  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                        ],

                                      ),

                                      SizedBox(height: 1.5.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Drop Address",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfDrops![index]["address"]}",  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                        ],

                                      ),
                                      SizedBox(height: 2.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("DROP STATUS:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),

                                          if(dropStatus == "0" || dropStatus == null)
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius
                                                      .circular(10)
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 3.w,
                                                    vertical: 1.h),
                                                child: Text("PENDING", style: TextStyle(color: Colors.red,
                                                    fontWeight: FontWeight.bold),),
                                              ),
                                            )
                                          else
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius
                                                      .circular(10)
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 3.w,
                                                    vertical: 1.h),
                                                child: Text("DROPPED", style: TextStyle(color: Colors.black,
                                                    fontWeight: FontWeight.bold),),
                                              ),
                                            )

                                        ],

                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ),
                    );

                  }),
            ),
          ],),
        ),
      ),


    );
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

  void getPickup() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getPickups({
        "loadID": loadToBeViewedId.toString()
      });

      if(response != null && response.statusCode == 200){
        List regPickups = response.data["data"]["docs"];

        print("print pickup asssss${regPickups}");
        List<Map<String,dynamic>> data = [];

        if(regPickups.length > 0){
          for(int i = 0; i < regPickups.length; i++){
            Map<String,dynamic> regLoadList = regPickups[i];
            data.add(regLoadList);
          }
        }
        setState(() {
          listOfPickups = data;
        });

        print("printing list of pickups asssssss $listOfPickups");

      }else  {
        print("Errorrrrrrrrrrr");

      }

    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");

    }

  }

  void getDrop() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getDrops({
        "loadID": loadToBeViewedId.toString()
      });

      if(response != null && response.statusCode == 200){
        List regDrops = response.data["data"]["docs"];

        List<Map<String,dynamic>> data = [];

        if(regDrops.length > 0){
          for(int i = 0; i < regDrops.length; i++){
            Map<String,dynamic> regDropList = regDrops[i];
            data.add(regDropList);
          }
        }
        setState(() {
          listOfDrops = data;
        });
      }
      else {

      }

    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");

    }

  }

  void getCompanyDetails() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.companyDetails();
      if(response != null && response.statusCode == 200
          && response.data["status"] == 200){
        var compInfo = response.data["data"]["docs"];

        setState(() {
          compName = compInfo["Comapny Name"];
        });
        setState(() {
          compAddress = compInfo["Comapny Address"];
        });
        setState(() {
          compPoBox = compInfo["Company PO BOX"];
        });
        setState(() {
          compState = compInfo["Company State"];
        });
        setState(() {
          compCity = compInfo["City"];
        });
      }
      else {

      }

    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");

    }


  }

  void _getImage(BuildContext context) async {
    try{
      bolPickerManager.pickImage(
          context: context,
          file: (file){
            setState(() {
              profileImage = file;
            });
            
            startLoader();
            uploadToApi(imageData: profileImage, );

            
          });

    }catch(e){}

  }

  Future<void> uploadToApi({File? imageData}) async {
      
    var logedUserID = await LocalStorage().fetch("idKey");

    try{
      var request = http.MultipartRequest('POST',
          Uri.parse('https://nieveslogistics.com/api/php-api/drivers/bol/upload_bol.php'));
      request.fields['load_id'] = loadToBeViewedId!;
      request.fields['driver_id'] = logedUserID;

      request.files.add(http.MultipartFile(
        'image',
        imageData!.readAsBytes().asStream(),
        imageData.lengthSync(),
        filename: imageData.path.split('/').last,
      ));

      var response = await request.send();
      if (response.statusCode == 200 ) {
        var responseData = await response.stream.bytesToString();
        var decodedData = jsonDecode(responseData);
        var resStatus = decodedData["status"];
        if(resStatus  == 'success') {
          stopLoader();
          showPopUp();
         /* setState(() {
            msgValue = decodedData["message"];
          });*/

        }else if(resStatus == 400){

          stopLoader();
          setState(() {
            errMsg = decodedData["message"];
          });

          desplayErrorMsg();
        }

      }
      else {
        print("this line.....");
        stopLoader();
        desplayError();
      }
    }catch(e){
      print("error message is $e");
    }


  }

  void desplayUploadSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("$msgValue",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

  }

  void desplayError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("Server is not reachable",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  void desplayErrorMsg() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("$errMsg",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  void showPopUp() {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
            backgroundColor: Colors.black87,
            actions: <Widget>[SizedBox(height: 30,),
              Center(child: Icon(Icons.check_circle_outline,
                color: Colors.green, size: 35.sp,)),
              SizedBox(height: 20,),
               Center(
                child: Text(" Success!",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 30,),
               Center(
                child: Text(" BOL Uploaded",
                  style: TextStyle(
                      fontSize: 16.sp, color: Colors.white
                  ),
                ),
              ), SizedBox(height: 3,),

              Center(
                child: TextButton(
                    onPressed: () {
                      Routers.pushNamed(context, '/drLoadDeliveredPreview');
                      /*   Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return  DispatcherLandingPageManager(key: keyid,);
                      }));*/
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
                        child: Text("OK", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),),
                      ),
                    )),
              ),
              SizedBox(height: 10,),

            ],
          ),
    );
  }

  Future<void> startLoader() async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: const Center(child: ProgressBar(),),
        );
      },
    );
  }

  Future<void> stopLoader() async {
    Navigator.of(context).pop();
  }

  void getBol() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getBol({
        "load_id": loadToBeViewedId.toString()
      });

      if(response != null && response.statusCode == 200){
        var res = response.data["data"]["bol"];
        setState(() {
          bolImage = res;
        });
      }
      else {
        print("unable to get bol");
      }

    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");

    }

  }

}
