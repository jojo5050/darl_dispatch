
import 'package:darl_dispatch/Utils/localstorage.dart';
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../ConstantHelper/colors.dart';

class ManageReports extends StatefulWidget {
  const ManageReports({Key? key}) : super(key: key);

  @override
  _ManageReportsState createState() => _ManageReportsState();
}

class _ManageReportsState extends State<ManageReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Reports",
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
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                      child: InkWell(
                        onTap: () {
                          Routers.pushNamed(context, '/drivers_weekly_reports');
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
                                      Text(
                                        "Driver Weekly PayRoll",
                                        style: TextStyle(
                                            color: AppColors.dashboardtextcolor,
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                  const Icon(
                                    Icons.assessment,
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
                      height: 1.h,
                    ),

                    SizedBox(
                      height: 10.h,
                      child: InkWell(
                        onTap: () {
                          Routers.pushNamed(context, '/staffDue');
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

                                  Text(
                                    "Staffs Due For Payment",
                                    style: TextStyle(
                                        color: AppColors.dashboardtextcolor,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  const Icon(
                                    Icons.payments_outlined,
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
                      height: 1.h,
                    ),
                    SizedBox(
                      height: 10.h,
                      child: InkWell(
                        onTap: () {
                          Routers.pushNamed(context, '/allRegLoadsFromReport');
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
                                  Text(
                                    "Registered loads",
                                    style: TextStyle(
                                        color: AppColors.dashboardtextcolor,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold),
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


  exitApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
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
}

