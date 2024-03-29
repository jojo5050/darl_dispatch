
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../../Models/global_variables.dart';
import '../../Utils/localstorage.dart';

class AccountantProfilePage extends StatefulWidget {
  const AccountantProfilePage({Key? key}) : super(key: key);

  @override
  _AccountantProfilePageState createState() => _AccountantProfilePageState();
}

class _AccountantProfilePageState extends State<AccountantProfilePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? currentuser = FirebaseAuth.instance.currentUser;
  CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");

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
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Colors.indigo, Colors.lightBlueAccent],
                              begin: Alignment.centerLeft, end: Alignment.centerRight
                          ),
                          //   color: Colors.indigo,
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
                          onSelected: (value){
                            switch (value){
                              case 1: Routers.pushNamed(context, '/editProfile');
                              break;
                              case 2: signOut(context);
                              break;
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Container(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Edit",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Container(
                                child: InkWell(
                                  onTap: () {
                                    signOut(context);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.logout,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "LogOut",
                                        style: TextStyle(
                                            color: Colors.red,
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
                  SizedBox(height: 1.h,),

                  Container(
                      child: profilePic == null ? CircularProgressIndicator():
                      CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(profilePic ?? ""),
                      )),
                  SizedBox(height: 2.h,),

                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text("${userName ?? ""} ", style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.sp),)
                    ],),
                  SizedBox(height: 1.h,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text("${userRole ?? ""}", style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal, fontSize: 18.sp),)
                    ],),
                  SizedBox(height: 3.h,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Colors.lightBlueAccent, Colors.indigo],
                            begin: Alignment.centerLeft, end: Alignment.centerRight
                        ),
                        //  color: Colors.indigo,
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("TEL:", style: TextStyle(color: Colors.black,
                                fontSize: 19.sp, fontWeight: FontWeight.bold),),
                            SizedBox(width: 2.w,),
                            Text("${telNum ?? ""}", style: TextStyle(color: Colors.white,
                                fontSize: 18.sp, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(height: 3.h,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Email:", style: TextStyle(color: Colors.black,
                                fontSize: 18.sp, fontWeight: FontWeight.bold),),
                            SizedBox(width: 2.w,),
                            Text("${email ?? ""}", style: TextStyle(color: Colors.white,
                                fontSize: 18.sp, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        /* SizedBox(height: 2.h,),
                          Row(
                            children: [
                              Text("A/C Name:", style: TextStyle(color: Colors.black,
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),),
                              SizedBox(width: 2.w,),
                              Text("${accNum ?? ""}", style: TextStyle(color: Colors.white,
                                  fontSize: 18.sp, ),),
                            ],
                          ),*/
                        SizedBox(height: 3.h, ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("A/C Number:", style: TextStyle(color: Colors.black,
                                fontSize: 18.sp, fontWeight: FontWeight.bold),),
                            SizedBox(width: 2.w,),
                            Text("${accNum ?? ""}", style: TextStyle(color: Colors.white,
                                fontSize: 18.sp, fontWeight: FontWeight.bold),),
                          ],
                        ),

                        SizedBox(height: 3.h, ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Bank Name:", style: TextStyle(color: Colors.black,
                                fontSize: 18.sp, fontWeight: FontWeight.bold),),
                            SizedBox(width: 2.w,),
                            Text("${bankName ?? ""}", style: TextStyle(color: Colors.white,
                                fontSize: 18.sp, fontWeight: FontWeight.bold),),
                          ],
                        ),

                        SizedBox(height: 3.h, ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Address:", style: TextStyle(color: Colors.black,
                                fontSize: 18.sp, fontWeight: FontWeight.bold),),
                            SizedBox(width: 2.w,),
                            Text("${address ?? ""}", style: TextStyle(color: Colors.white,
                                fontSize: 18.sp, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ],),
                    ),
                  )
                ],

              ),
            ),
          ),
        ),
      );
  }

  void signOut(BuildContext context) async {
    // LocalStorage().store("token", "");
    firebaseAuth.signOut();
    LocalStorage().delete("token");
    LocalStorage().delete("userData");
    LocalStorage().delete("roleKey");
    LocalStorage().delete("idKey");

    Routers.replaceAllWithName(context, '/login_page');

  }
}
