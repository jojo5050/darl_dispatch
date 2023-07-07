
import 'package:darl_dispatch/Utils/localstorage.dart';
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../ConstantHelper/colors.dart';

class DspManageLoad extends StatefulWidget {
  const DspManageLoad({Key? key}) : super(key: key);

  @override
  _DspManageLoadState createState() => _DspManageLoadState();
}

class _DspManageLoadState extends State<DspManageLoad> {
  var usrRole;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Manage Loads",
              style:
              TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp)),
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

                  Container(
                    height: 10.h,
                    child: InkWell(
                      onTap: () {
                        Routers.pushNamed(context, '/register_load');
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
                                      "Register New Load",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      "Register a new load for assigning",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.my_library_add,
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

                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 10.h,
                    child: InkWell(
                      onTap: () {
                        Routers.pushNamed(context, '/dsp_registered_loads_preview');
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
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
                                      "Newly Registered Loads",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      "Registered Loads with no pick/drops",
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
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 10.h,
                    child: InkWell(
                      onTap: () {
                        Routers.pushNamed(context, '/dsp_reg_loads_with_pd_preview');
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
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
                                       "Loads with Pick/Drops",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      "Registered Loads With Picks/Drops",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.local_shipping,
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
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 10.h,
                    child: InkWell(
                      onTap: () {
                        Routers.pushNamed(context, '/loadsAssignedPreview');
                      },
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
                                      "Loads Assigned",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      "Loads already assigned",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.assignment,
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
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 10.h,
                    child: InkWell(
                      onTap: () {
                        Routers.pushNamed(context, '/dsp_delivered_preview');
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
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
                                      "Load Delivered",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      "Completed Deliveries",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.done_all,
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
                ],
              ),
            ),
          ),
        ]));
  }
}
