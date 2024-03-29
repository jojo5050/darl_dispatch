import 'package:darl_dispatch/Utils/loaderFadingBlue.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../AuthManagers/authRepo.dart';
import '../../../ConstantHelper/colors.dart';
import '../../../Utils/routers.dart';
import '../Models/global_variables.dart';


class AdAllLoadsFromReport extends StatefulWidget {
  const AdAllLoadsFromReport({Key? key}) : super(key: key);

  @override
  _AdAllLoadsFromReportState createState() => _AdAllLoadsFromReportState();
}

class _AdAllLoadsFromReportState extends State<AdAllLoadsFromReport> {
  List<Map<String, dynamic>>? listOfDeliveredLoads;
  String loadStatus = "3";

  var errmsg;


  @override
  void initState() {
    getAllRegLoads();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                  "assets/images/backarrowicon.svg",
                  height: 25,
                  width: 25,
                ),
              ),
              Text("Registered Loads",
                style: TextStyle(
                    color: AppColors.dashboardtextcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    decoration: TextDecoration.none),),
              Container(height: 0, width: 0)

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
                          "No Registered Loads",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp),
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
                            height: 22.h,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.w,),
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
                                          Row(
                                            children: [
                                              Text("Total Pickups:",  style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 1.w,),
                                              Text("${listOfDeliveredLoads![index]["totalPickups"]}",  style: TextStyle(
                                                color: AppColors.dashboardtextcolor,
                                                fontSize: 16.sp, )),
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
                                                fontSize: 16.sp,)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.h,
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
                                                padding: EdgeInsets.symmetric(horizontal: 2.w,
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
                                                padding: EdgeInsets.symmetric(horizontal: 2.w,
                                                    vertical: 1.h),
                                                child: Text("UPLOADED",  style: TextStyle(
                                                    color: Colors.white,
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

  void getAllRegLoads() async {
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
    Routers.pushNamed(context, '/adminLoadsDeleveredDetails');

    print("print load to be viewed as $loadToBeViewedId");
  }
}
