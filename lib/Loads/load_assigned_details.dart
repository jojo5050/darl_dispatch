import 'package:darl_dispatch/Utils/routers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../AuthManagers/authRepo.dart';
import '../../../ConstantHelper/colors.dart';
import '../../../Models/global_variables.dart';
import '../Utils/loaderFadingBlue.dart';

class LoadAssignedDetails extends StatefulWidget {
  const LoadAssignedDetails({Key? key}) : super(key: key);

  @override
  _LoadAssignedDetailsState createState() => _LoadAssignedDetailsState();
}

class _LoadAssignedDetailsState extends State<LoadAssignedDetails> {

  var errMsg;
  List<Map<String, dynamic>>? listOfDrops;
  List<Map<String, dynamic>>? listOfPickups;
  var emptyLList;

  var compName;

  var compAddress;

  var compPoBox;

  var compState;

  var compCity;

  var weight;

  var amount;

  var driverTel;

  var driverName;

  var shiperAddres;

  var shiperEmail;

  var brokerTel;

  var brokerEmail;

  var rateConf;

  var brokerName;

  String? pickedStatus;

  @override
  void initState() {
    getCompanyDetails();
    getLoadDetails();
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
            SizedBox(height: 1.h,),
            Align(alignment: Alignment.centerLeft,
                child: Text("Load Details:",
                  style: TextStyle(color: AppColors.dashboardtextcolor,
                  fontWeight: FontWeight.bold, fontSize: 16.sp),)),
            Container(
              height: 47.h,
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

                              Text("${rateConf ?? ""}",  style: TextStyle(
                                  color: AppColors.dashboardtextcolor,
                                  fontSize: 19.sp, fontWeight: FontWeight.bold)),
                            ],

                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Rate:",  style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.sp, fontWeight: FontWeight.bold)),
                              SizedBox(width: 2.w,),

                              Text("${amount ?? ""}",  style: TextStyle(
                                  color: AppColors.dashboardtextcolor,
                                  fontSize: 17.sp,)),
                            ],

                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Weight:",  style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.sp, fontWeight: FontWeight.bold)),
                              SizedBox(width: 2.w,),

                              Text("${weight ?? ""}",  style: TextStyle(
                                  color: AppColors.dashboardtextcolor,
                                  fontSize: 17.sp,)),
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

                              Text("${brokerName ?? ""}",  style: TextStyle(
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

                              Text("${brokerEmail ?? ""}",  style: TextStyle(
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

                              Text("${brokerTel ?? ""}",  style: TextStyle(
                                  color: AppColors.dashboardtextcolor,
                                  fontSize: 17.sp,)),
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

                          Text("${shiperEmail ?? ""}",  style: TextStyle(
                              color: AppColors.dashboardtextcolor,
                              fontSize: 17.sp, )),
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

                          Container(constraints: BoxConstraints(maxWidth: 170),
                            child: Text("${shiperAddres ?? ""}",
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                color: AppColors.dashboardtextcolor,
                                fontSize: 17.sp, )),
                          ),
                        ],

                      ),
                          SizedBox(height: 1.5.h,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Driver Name:",  style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.sp, fontWeight: FontWeight.bold)),
                              SizedBox(width: 2.w,),

                              Text("${driverName ?? ""}",  style: TextStyle(
                                  color: AppColors.dashboardtextcolor,
                                  fontSize: 17.sp, )),
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
                                  fontSize: 17.sp, )),
                            ],

                          ),

                        ],
                      ),
                    ),
                  ),
                ),
            ),

            SizedBox(height: 5.h,),
            Text("Pickups", style: TextStyle(color: Colors.black,
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
              height: 40.h,
              child: listOfPickups == null ? Center(child: LoaderFadingBlue()):
              listOfPickups!.isEmpty ?
              Center(
                child: Column(
                  children: [
                    Icon(Icons.question_mark, color: Colors.grey, size: 30.sp,),
                     Text(
                      "No Pickup Found",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp),
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
                        height: 37.h,
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
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Pickup State:",  style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 4.w,),
                                              Container(
                                                constraints: BoxConstraints(maxWidth: 250),
                                                child: Text("${listOfPickups![index]["state"]}",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                              ),
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
                                          Container(
                                            constraints: BoxConstraints(maxWidth: 250),
                                            child: Text("${listOfPickups![index]["city"]}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          ),
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
                                          Container(constraints: BoxConstraints(maxWidth: 200),
                                            child: Text("${listOfPickups![index]["address"]}",
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          ),

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
            Text("Drops", style: TextStyle(color: Colors.black,
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
              height: 40.h,
              child: listOfDrops == null ? Center(child: LoaderFadingBlue()):
              listOfDrops!.isEmpty ?
              Center(
                child: Column(
                  children: [
                    Icon(Icons.question_mark, color: Colors.grey, size: 30.sp,),
                     Text(
                      "No Registered Drop",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp),
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
                        height: 37.h,
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

                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Drop State:",
                                                    style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 2.w,),
                                              Container(
                                                constraints: BoxConstraints(maxWidth: 250),
                                                child: Text("${listOfDrops![index]["state"]}",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                              ),
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
                                          Container(
                                            constraints: BoxConstraints(maxWidth: 250),
                                            child: Text("${listOfDrops![index]["city"]}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          ),
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
                                          Container(
                                            constraints: BoxConstraints(maxWidth: 200),
                                            child: Text("${listOfDrops![index]["address"]}",
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          ),
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

  void getLoadDetails() async {
    final AuthRepo authRepo = AuthRepo();

    try{
      Response? response = await authRepo.loadAssignedDetails({
        "loadID": loadToBeViewedId.toString()
      });

      if(response != null && response.statusCode == 200){
        var loadDetails = response.data["data"]["docs"];


        setState(() {
          brokerName = loadDetails["Broker Name"];
        });
        setState(() {
          rateConf = loadDetails["Rate ConfirmationID"];
        });
        setState(() {
          brokerEmail = loadDetails["Broker Email"];
        });
        setState(() {
          brokerTel = loadDetails["Broker Number"];
        });
        setState(() {
          shiperEmail = loadDetails["Shipper Email"];
        });
        setState(() {
          shiperAddres = loadDetails["Shipper Address"];
        });
        setState(() {
          driverName = loadDetails["Driver Name"];
        });
        setState(() {
          driverTel = loadDetails["Driver Number"];
        });
        setState(() {
          amount = loadDetails["Load Rate"];
        });
        setState(() {
          weight = loadDetails["weight"];
        });

      }
      else {

      }

    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");

    }

  }

}
