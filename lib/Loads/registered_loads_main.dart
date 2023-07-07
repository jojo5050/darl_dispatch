import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../ConstantHelper/colors.dart';


class RegisteredLoadsMain  extends StatefulWidget {
  const RegisteredLoadsMain({Key? key}) : super(key: key);

  @override
  State<RegisteredLoadsMain> createState() => _RegisteredLoadsMainState();
}

class _RegisteredLoadsMainState extends State<RegisteredLoadsMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registered Load", style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
        child: Column(
          children: [
            Container(
              height: 75.h,
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
                              "T-RT88899W266",
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
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: Container(
                                      child: GestureDetector(
                                        onTap: () {
                                          //   Routers.pushNamed(context, "/settings");
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.add_task_outlined,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "Re-Assign",
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
                                ]),

                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Broker:",  style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                            SizedBox(width: 2.w,),

                            Text("LGTI Logistics",  style: TextStyle(
                                color: AppColors.dashboardtextcolor,
                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                          ],

                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Broker Email:",  style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                            SizedBox(width: 2.w,),

                            Text("123456",  style: TextStyle(
                                color: AppColors.dashboardtextcolor,
                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                          ],

                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Broker Tel:",  style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                            SizedBox(width: 2.w,),

                            Text("10222",  style: TextStyle(
                                color: AppColors.dashboardtextcolor,
                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                          ],

                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Amount: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 2.w,),
                            Text(
                              "23345",
                              style: TextStyle(
                                  color: AppColors.dashboardtextcolor,
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Weight: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 2.w,),
                            Text(
                              "344",
                              style: TextStyle(
                                  color: AppColors.dashboardtextcolor,
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Load Desc: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 2.w,),
                            Text(
                              "fish",
                              style: TextStyle(
                                  color: AppColors.dashboardtextcolor,
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Date Registered: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 2.w,),
                            Text(
                              "10:90",
                              style: TextStyle(
                                  color: AppColors.dashboardtextcolor,
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Shipper Email: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 2.w,),
                            Text(
                              "ss@gmail.com",
                              style: TextStyle(
                                  color: AppColors.dashboardtextcolor,
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        const Divider(
                          color: Colors.black,
                          height: 5,
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                        ),

                        SizedBox(
                          height: 2.h,
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
                                    Text("Registered by:", style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                    SizedBox(width: 2.w,),
                                    Text("Pablo", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.sp, fontWeight: FontWeight.bold),)
                                  ],),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
