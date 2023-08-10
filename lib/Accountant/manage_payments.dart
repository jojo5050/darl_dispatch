
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../ConstantHelper/colors.dart';
import '../../Utils/routers.dart';

class ManagePayment extends StatefulWidget {
  const ManagePayment({Key? key}) : super(key: key);

  @override
  _ManagePaymentState createState() => _ManagePaymentState();
}

class _ManagePaymentState extends State<ManagePayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Successful Payments",
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.sp)),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.lightGreenAccent,
      body: Stack(
        children: <Widget>[
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/pickupdashbg.png"),
                      fit: BoxFit.cover))),

          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Column(children: [
                Container(
                  height: 10.h,
                  child: InkWell(
                    onTap: () {
                      Routers.pushNamed(context, '/staffsPaid');
                    },
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Staffs Paid",
                                    style: TextStyle(
                                        color: AppColors.dashboardtextcolor,
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Staffs Successfully paid",
                                    style: TextStyle(
                                        color: AppColors.dashboardtextcolor,
                                        fontSize: 15.sp),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.group,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 1.h,),
                Container(
                  height: 10.h,
                  child: InkWell(
                    onTap: () {
                      Routers.pushNamed(context, '/driversPaid');
                    },
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Drivers paid",
                                    style: TextStyle(
                                        color: AppColors.dashboardtextcolor,
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    "Successfully paid drivers",
                                    style: TextStyle(
                                        color: AppColors.dashboardtextcolor,
                                        fontSize: 15.sp),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.drive_eta_rounded,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.h,),
                /* Container(
                      height: 10.h,
                      child: InkWell(
                        onTap: () {
                         // Routers.pushNamed(context, '/register_load');
                        },
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        "Assigned Vehicles",
                                        style: TextStyle(
                                            color: AppColors.dashboardtextcolor,
                                            fontSize: 19.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        "View all assigned V ehicles",
                                        style: TextStyle(
                                            color: AppColors.dashboardtextcolor,
                                            fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),*/

              ],),
            ),
          )


        ],
      ),

    );

  }
}
