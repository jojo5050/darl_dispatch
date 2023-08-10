import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../AuthManagers/authRepo.dart';
import '../ConstantHelper/colors.dart';

class ClientProfilePage extends StatefulWidget {

  final Map<String, dynamic> staffInfo;
  const ClientProfilePage({Key? key, required this.staffInfo}) : super(key: key);

  @override
  State<ClientProfilePage> createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {

  Map<String, dynamic> staffInfo = {};

  var usersRole;

  var driverId;

  List<Map<String, dynamic>>? listOfDeliveredLoads;

  var errmsg;

  var profilePicture;

  @override
  void initState() {
    staffInfo = widget.staffInfo;
    getRole();
    getDeliveredLoads();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/generalDashBoardBg.png"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  },
                      icon: const Icon(Icons.arrow_back_ios, size: 30, color: Colors.black,)),

                ]),
                SizedBox(height: 2.h,),

                 CircleAvatar(
                  backgroundColor: Colors.transparent, radius: 58,
                  backgroundImage: NetworkImage(staffInfo["avatar"] ?? ""),),
                SizedBox(height: 1.h,),

                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text("${staffInfo["name"]}", style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17.sp),)
                  ],),
                SizedBox(height: 1.h,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text("${staffInfo["role"]}", style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic, fontSize: 16.sp),)
                  ],),
                SizedBox(height: 2.h,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 11.h,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Colors.indigo, Colors.lightBlueAccent],
                          begin: Alignment.centerLeft, end: Alignment.centerRight
                      ),
                      //  color: Colors.indigo,
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                    child: Column(children: [
                      Text("${staffInfo["tel"]}",
                        style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.bold),),
                      SizedBox(height: 1.h,),
                      Text("${staffInfo["email"]}",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),),

                    ],),
                  ),
                ),
                SizedBox(height: 2.h,),
                if(usersRole == "Driver")
                  buildDrvContainer(),

                if(usersRole == "Admin")
                  buildAdminContainer(),

               /* if(usersRole == "Despatcher")
                  buildDespContainer(),*/

              ],

            ),
          ),
        ),
      ),
    );
  }

    Widget buildDrvContainer() {

     return Container( height: 60.h,
       child: Column(children: [
       Align(alignment: Alignment.centerLeft,
           child: Row(
             children: [
               Text("Delivered Loads:",
                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
               SizedBox(width: 2.w,),

               Container(
                 child: listOfDeliveredLoads == null ?
                 CircularProgressIndicator(color: Colors.transparent,):
                 Text("${listOfDeliveredLoads!.length ?? ""}",
                   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
               ),
             ],
           )),

         Expanded(
           child: Container(
               child: listOfDeliveredLoads == null ? Center(child: CircularProgressIndicator(color: Colors.green,)):
               listOfDeliveredLoads!.isEmpty ?
               Center(
                 child: Column(
                   children: [
                     SizedBox(height: 10.h,),
                     Icon(Icons.question_mark, color: Colors.grey, size: 35.sp,),
                     const Text(
                       "No Delivered Loads",
                       style: TextStyle(
                           color: Colors.black,
                           fontWeight: FontWeight.bold,
                           fontSize: 17),
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
                         height: 15.h,
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
                                         "RC:",
                                         style: TextStyle(
                                             color: Colors.black,
                                             fontSize: 19.sp,
                                             fontWeight: FontWeight.bold),
                                       ),
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
                                       Text("Load Desc:",  style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                       SizedBox(width: 2.w,),
                                       Text("${listOfDeliveredLoads![index]["loadDescription"]}",  style: TextStyle(
                                           color: AppColors.dashboardtextcolor,
                                           fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                     ],

                                   ),

                                   SizedBox(
                                     height: 1.5.h,
                                   ),
                                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text("PicKup - Drops:",  style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                       SizedBox(width: 2.w,),
                                       Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text("${listOfDeliveredLoads![index]["totalPickups"]}",  style: TextStyle(
                                               color: AppColors.dashboardtextcolor,
                                               fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                           Text("-",  style: TextStyle(
                                               color: Colors.black,
                                               fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                           Text("${listOfDeliveredLoads![index]["totalDrops"]}",  style: TextStyle(
                                               color: AppColors.dashboardtextcolor,
                                               fontSize: 16.sp, fontWeight: FontWeight.bold)),
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
                     );

                   })


           ),
         )
     ],

       ),);
    }

  void getRole() {
    usersRole = staffInfo["role"];
    driverId = staffInfo["id"];
    print("print role asssssssss $usersRole");
    print("print driver id asssssssss $driverId");
  }

  void  getDeliveredLoads() async {

    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.drDeliveredLoad({
        "Driver_id": driverId
      });
      print("driver id assssssssssss $driverId");

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

 Widget buildAdminContainer() {
    return Container( height: 60.h,
      child: Column(children: [
        Align(alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text("Delivered Loads:",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                SizedBox(width: 2.w,),
                /* Text("${listOfDeliveredLoads!.length ?? ""}",
                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),*/
              ],
            )),

        Expanded(
          child: Container(
              child: listOfDeliveredLoads == null ? Center(child: CircularProgressIndicator(color: Colors.green,)):
              listOfDeliveredLoads!.isEmpty ?
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 10.h,),
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
                        height: 15.h,
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
                                        "RC:",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
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
                                      Text("Load Desc:",  style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                      SizedBox(width: 2.w,),
                                      Text("${listOfDeliveredLoads![index]["loadDescription"]}",  style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                    ],

                                  ),

                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("PicKup - Drops:",  style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                      SizedBox(width: 2.w,),
                                      Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${listOfDeliveredLoads![index]["totalPickups"]}",  style: TextStyle(
                                              color: AppColors.dashboardtextcolor,
                                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                          Text("-",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                          Text("${listOfDeliveredLoads![index]["totalDrops"]}",  style: TextStyle(
                                              color: AppColors.dashboardtextcolor,
                                              fontSize: 16.sp, fontWeight: FontWeight.bold)),
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
                    );

                  })


          ),
        )
      ],

      ),);

  }

  buildDespContainer() {}
}
