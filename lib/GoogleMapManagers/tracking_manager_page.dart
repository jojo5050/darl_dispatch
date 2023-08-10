
import 'package:darl_dispatch/Utils/localstorage.dart';
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../ConstantHelper/colors.dart';


class TrackingManagerPage extends StatefulWidget {
  const TrackingManagerPage({Key? key}) : super(key: key);

  @override
  _TrackingManagerPageState createState() => _TrackingManagerPageState();
}

class _TrackingManagerPageState extends State<TrackingManagerPage> {
  var usrRole;
  Location location = Location();


  @override
  void initState() {
    super.initState();
    _requestMapPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Location Tracking",
              style:
              TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp)),
          backgroundColor: Colors.indigo,
        ),
        body: Stack(children: <Widget>[
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/custumBg.png"),
                      fit: BoxFit.cover))),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
              child: Column(
                children: [

                  Container(
                    height: 10.h,
                    child: InkWell(
                      onTap: () {
                        Routers.pushNamed(context, '/usersFromFirebase');
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
                                      "Get User Tracking ID",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      "Select a user for tracking",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.location_history,
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
                        Routers.pushNamed(context, '/deviceTrackingInputField');
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
                                      "Enter Tracking ID",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      "Enter the selected tracking ID to proceed",
                                      style: TextStyle(
                                          color: AppColors.dashboardtextcolor,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.location_searching,
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

  void _requestMapPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Location services are disabled or permission denied
        return;
      }
    }
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        // Permission denied
        return;
      }
    }
  }
}

