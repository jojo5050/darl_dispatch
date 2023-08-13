
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../ConstantHelper/colors.dart';
import '../../Utils/routers.dart';

class ManageReport extends StatefulWidget {
  const ManageReport({Key? key}) : super(key: key);

  @override
  _ManageReportState createState() => _ManageReportState();
}

class _ManageReportState extends State<ManageReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Payment Reports",
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.sp)),
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
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
              child: Column(children: [
                Container(
                  height: 10.h,
                  child: InkWell(
                    onTap: () {
                      Routers.pushNamed(context, '/select_vehicle');
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
                                    " Vehicle Income",
                                    style: TextStyle(
                                        color: AppColors.dashboardtextcolor,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    "View income generated at intervals",
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

              ],),
            ),
          )


        ],
      ),

    );

  }
}
