import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../../Models/global_variables.dart';
import '../../Utils/localstorage.dart';
import '../../Utils/routers.dart';

class AccountantProfilePage extends StatefulWidget {
  const AccountantProfilePage({Key? key}) : super(key: key);

  @override
  _AccountantProfilePageState createState() => _AccountantProfilePageState();
}

class _AccountantProfilePageState extends State<AccountantProfilePage> {

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
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  /* IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    },
                        icon: const Icon(Icons.arrow_back_ios, size: 30, color: Colors.black,)),*/
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
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Container(
                              child: GestureDetector(
                                onTap: (){
                                  Routers.pushNamed(context, '/editProfile');

                                },
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
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Container(
                              child: InkWell(
                                onTap: () {
                                  //   Routers.pushNamed(context, '/faq');
                                },
                                child: InkWell(
                                  onTap: (){
                                    Routers.pushNamed(context, '/settings');

                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.settings,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Settings",
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
                          PopupMenuItem(
                            value: 1,
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

                const CircleAvatar(
                  backgroundColor: Colors.grey, radius: 70,
                  child: Icon(Icons.person, color: Colors.white, size: 30,),),
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
                      Row(
                        children: [
                          Text("TEL:", style: TextStyle(color: Colors.black,
                              fontSize: 19.sp, fontWeight: FontWeight.bold),),
                          SizedBox(width: 2.w,),
                          Text("${telNum ?? ""}", style: TextStyle(color: Colors.white,
                              fontSize: 18.sp, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 3.h,),
                      Row(
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
                      Row(
                        children: [
                          Text("A/C Number:", style: TextStyle(color: Colors.black,
                              fontSize: 18.sp, fontWeight: FontWeight.bold),),
                          SizedBox(width: 2.w,),
                          Text("${accNum ?? ""}", style: TextStyle(color: Colors.white,
                              fontSize: 18.sp, fontWeight: FontWeight.bold),),
                        ],
                      ),

                      SizedBox(height: 3.h, ),
                      Row(
                        children: [
                          Text("Bank Name:", style: TextStyle(color: Colors.black,
                              fontSize: 18.sp, fontWeight: FontWeight.bold),),
                          SizedBox(width: 2.w,),
                          Text("${bankName ?? ""}", style: TextStyle(color: Colors.white,
                              fontSize: 18.sp, fontWeight: FontWeight.bold),),
                        ],
                      ),

                      SizedBox(height: 3.h, ),
                      Row(
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
    LocalStorage().delete("token");
    LocalStorage().delete("userData");
    LocalStorage().delete("roleKey");
    LocalStorage().delete("idKey");

    Routers.replaceAllWithName(context, '/login_page');

  }

  void getUserDetails() async {

    dynamic userId = await LocalStorage().fetch("idKey");
    print("userid as $userId");

    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getSingleUserInfo({
        "id": userId.toString()
      });

      if(response != null && response.statusCode == 200){

        var  userdata = response.data;
        print("user data asssssssssss $userdata");

        setState(() {
          userName = userdata["name"];
        });
        setState(() {
          email = userdata["email"];
        });
        setState(() {
          userRole = userdata["role"];
        });
        setState(() {
          telNum = userdata["tel"];
        });
        setState(() {
          accNum = userdata["accountNumber"];
        });
        setState(() {
          bankName = userdata["bankName"];
        });
        setState(() {
          address = userdata["address"];
        });

      }else{
        print("could not retrieve it");

      }

    }catch(e){

    }

  }
}
