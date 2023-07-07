import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../ConstantHelper/colors.dart';

class PreviewLoadsToBeRegistered extends StatefulWidget {
  const PreviewLoadsToBeRegistered({Key? key}) : super(key: key);

  @override
  State<PreviewLoadsToBeRegistered> createState() => _PreviewLoadsToBeRegisteredState();
}

class _PreviewLoadsToBeRegisteredState extends State<PreviewLoadsToBeRegistered> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    "assets/images/backarrowicon.svg",
                    height: 25,
                    width: 25,
                  ),
                ),
                Text(
                  "Preview Details",
                  style: TextStyle(
                      color: AppColors.dashboardtextcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      decoration: TextDecoration.none),
                ),
                Container(
                  height: 0,
                  width: 0,
                ),
              ]),

              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Load Information",
                    style: TextStyle(
                        color: AppColors.dashboardtextcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 4,
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 1.h,),
                              Text(
                                "Rate",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Confirmation",
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
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Text(
                            "F-RT88899W266",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 4,
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Text(
                            "Rate",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Text(
                            "12345",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 4,
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 1.h,),
                              Text(
                                "Date",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Registered",
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
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Text(
                            "2023-01-23",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 4,
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 1.h,),
                              Text(
                                "Load",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Description",
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
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Text(
                            "Iron Rod",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 4,
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Text(
                            "Weight",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Text(
                            "200 kg",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Broker Information",
                    style: TextStyle(
                        color: AppColors.dashboardtextcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
              SizedBox(height: 1.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 4,
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 1.h,),
                              Text(
                                "Broke",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Name",
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
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Text(
                            "Gix Logistics",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 4,
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 1.h,),
                              Text(
                                "Broker",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Email",
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
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Text(
                            "example@gmail.com",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 4,
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 1.h,),
                              Text(
                                "Broker",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Address",
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
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Text(
                            "123, New York",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 4,
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 1.h,),
                              Text(
                                "Broker",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Phone",
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
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                        ),
                        child: Center(
                          child: Text(
                            "0123456789",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
                 SizedBox(height: 5.h,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo[500],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide.none)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Load has been saved successfully"),));
                      },
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 2.h),
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                      )),

            ],
          ),
        ),
      ),
    );
  }
}
