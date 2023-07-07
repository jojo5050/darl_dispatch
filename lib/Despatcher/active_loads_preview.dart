
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../ConstantHelper/colors.dart';

class ActiveLoadPreview extends StatefulWidget {
  const ActiveLoadPreview({Key? key}) : super(key: key);

  @override
  _ActiveLoadPreviewState createState() => _ActiveLoadPreviewState();
}

class _ActiveLoadPreviewState extends State<ActiveLoadPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                  Text("Active Loads",
                    style: TextStyle(
                        color: AppColors.dashboardtextcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        decoration: TextDecoration.none),),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Colors.indigo, Colors.lightBlueAccent],
                            begin: Alignment.centerLeft, end: Alignment.centerRight
                        ),
                        borderRadius: BorderRadius.circular(15)),
                     child: PopupMenuButton(
                          color: Colors.black,
                          elevation: 20,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          icon: const Center(
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Container(
                                child: InkWell(
                                  onTap: () {
                                    Routers.pushNamed(context, '/loadsAssignedPreview');

                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Assigned Loads",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 1,
                              child: Container(
                                child: InkWell(
                                  onTap: () {
                                    Routers.pushNamed(context, '/nonAssignedLoadsPreview');

                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.no_transfer,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "N.A Loads ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                  ),
                ]),

                SizedBox(height: 4.h,),

                Container(
                  height: 12.h,
                  child: InkWell(onTap: (){
                    Routers.pushNamed(context, '/activeLoadsMain');

                  },
                    child: Card(
                      elevation: 10,
                      color: Colors.green,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "T-RT88899W266",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Load Desc:",  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                  SizedBox(width: 2.w,),

                                  Text("Stock Fish",  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                ],

                              ),

                              Row(mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("View Details...",  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                ],

                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 12.h,
                  child: InkWell(onTap: (){
                    /*PersistentNavBarNavigator
                          .pushNewScreen(context, screen: RegisterLoad());*/
                  },
                    child: Card(
                      elevation: 10,
                      color: Colors.green,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "T-RT88899W266",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Load Desc:",  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                  SizedBox(width: 2.w,),

                                  Text("Stock Fish",  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                ],

                              ),

                              Row(mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("View Details...",  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                ],

                              )
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
    );
  }
}
