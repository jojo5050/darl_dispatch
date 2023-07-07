
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../ConstantHelper/colors.dart';

class DriversManagementScreen extends StatefulWidget {
  const DriversManagementScreen({Key? key}) : super(key: key);

  @override
  _DriversManagementScreenState createState() => _DriversManagementScreenState();
}

class _DriversManagementScreenState extends State<DriversManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Drivers",
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.sp)),
          backgroundColor: Colors.indigo,
        ),
        body: Stack(children: <Widget>[
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/pickupdashbg.png"),
                      fit: BoxFit.cover))),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Column(
                children: [

                  InkWell(onTap: (){
                    Routers.pushNamed(context, '/allDrivers');
                  },
                    child: Container(
                      height: 10.h,
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
                                        "All Drivers",
                                        style: TextStyle(
                                            color: AppColors.dashboardtextcolor,
                                            fontSize: 19.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        "Registered drivers active/non-active",
                                        style: TextStyle(
                                            color: AppColors.dashboardtextcolor,
                                            fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ),
                  ),

                  SizedBox(
                    height: 1.h,
                  ),

                  InkWell(onTap: (){
                    Routers.pushNamed(context, '/activeDrivers');
                  },
                    child: Container(
                      height: 10.h,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 10,
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
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
                                        "Active Drivers",
                                        style: TextStyle(
                                            color: AppColors.dashboardtextcolor,
                                            fontSize: 19.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        "Drivers on with assigned load",
                                        style: TextStyle(
                                            color: AppColors.dashboardtextcolor,
                                            fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  InkWell(onTap: (){Routers.pushNamed(context, '/non_active_active');},
                    child: Container(
                      height: 10.h,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 10,
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
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
                                        "Non Active Drivers",
                                        style: TextStyle(
                                            color: AppColors.dashboardtextcolor,
                                            fontSize: 19.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        "drivers without assigned load",
                                        style: TextStyle(
                                            color: AppColors.dashboardtextcolor,
                                            fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
