import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../AuthManagers/authRepo.dart';
import '../../../ConstantHelper/colors.dart';
import '../../../Utils/routers.dart';
import '../../Utils/localstorage.dart';


class DspLoadDeliveredPreview extends StatefulWidget {
  const DspLoadDeliveredPreview({Key? key}) : super(key: key);

  @override
  _DspLoadDeliveredPreviewState createState() => _DspLoadDeliveredPreviewState();
}

class _DspLoadDeliveredPreviewState extends State<DspLoadDeliveredPreview> {
  List<Map<String, dynamic>>? listOfDeliveredLoads;

  var errmsg;


  @override
  void initState() {
    getDelivered();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(onTap: () {
                Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                 "assets/images/backarrowicon.svg",
                 height: 25,
                 width: 25,
                ),
              ),
              Text("Delivered Loads",
                style: TextStyle(
                    color: AppColors.dashboardtextcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    decoration: TextDecoration.none),),

              Container(
                height: 0,
                width: 0,
              ),
            ]),

            Expanded(
              child: Container(
                  child: listOfDeliveredLoads == null ? Center(child: CircularProgressIndicator(color: Colors.green,)):
                  listOfDeliveredLoads!.isEmpty ?
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: 20.h,),
                        Icon(Icons.question_mark, color: Colors.grey, size: 40.sp,),
                        const Text(
                          "No Delivered Loads",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  ) : ListView.builder(
                      itemCount: listOfDeliveredLoads!.length,
                      itemBuilder: (context, index){
                        return GestureDetector( onTap: (){
                          //  loadDetailsModal(index);
                        },
                          child: Container(
                            height: 40.h,
                            child: Card(
                              elevation: 10,
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
                                          Text(
                                            "${listOfDeliveredLoads![index]["rateConfirmationID"]}",
                                            style: TextStyle(
                                                color: AppColors.dashboardtextcolor,
                                                fontSize: 19.sp,
                                                fontWeight: FontWeight.bold),
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
                                              onSelected: (value){
                                                /* switch (value){
                                                      case 1: loadDetailsModal(index);
                                                      break;
                                                      case 2: getIDandPush(index);
                                                      break;
                                                    }*/

                                              },
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  value: 1,
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.remove_red_eye_outlined,
                                                          color: Colors.green,
                                                          size: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          "View",
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
                                          Text("Load Desc:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 2.w,),
                                          Text("${listOfDeliveredLoads![index]["loadDescription"]}",  style: TextStyle(
                                              color: Colors.indigo,
                                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
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
                                              color: Colors.indigo,
                                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
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
                                              color: Colors.indigo,
                                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total Pickups:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 2.w,),
                                          Text("${listOfDeliveredLoads![index]["totalPickups"]}",  style: TextStyle(
                                              color: Colors.indigo,
                                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total Drops:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 2.w,),
                                          Text("${listOfDeliveredLoads![index]["totalDrops"]}",  style: TextStyle(
                                              color: Colors.indigo,
                                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      Card(
                                        color: Colors.blueAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        elevation: 15,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                                          child: Column(
                                            children: [
                                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text("Delivered by:", style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                                  SizedBox(width: 2.w,),
                                                  Container(
                                                    constraints: BoxConstraints(maxWidth: 150),
                                                    child: Text("${listOfDeliveredLoads![index]["driver_id"]}",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17.sp, fontWeight: FontWeight.bold),),
                                                  )
                                                ],),

                                            ],
                                          ),
                                        ),
                                      ),

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

  void getDelivered() async {
    var despatcherID = await LocalStorage().fetch("idKey");
    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.dspAssignedLoad({
        "Despatcher_id": despatcherID.toString()
      });

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