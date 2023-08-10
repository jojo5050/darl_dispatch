import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Utils/routers.dart';

class AdminRegisteredLoadsSuccessPage extends StatefulWidget {
  const AdminRegisteredLoadsSuccessPage({Key? key}) : super(key: key);

  @override
  State<AdminRegisteredLoadsSuccessPage> createState() => _AdminRegisteredLoadsSuccessPageState();
}

class _AdminRegisteredLoadsSuccessPageState extends State<AdminRegisteredLoadsSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopControll,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 5.h,),
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(onPressed: (){
                          Routers.pushNamed(context, '/admin_landing_manager');
                        }, icon: Icon(Icons.clear, size: 25.sp,)),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Icon(Icons.check_circle, color: Colors.green,
                      size: 50.sp,),
                    SizedBox(height: 3.h,),
                    Text("Load was registered",
                      style: TextStyle(
                          color: Colors.black, fontSize: 19.sp, fontWeight: FontWeight.bold),),
                    SizedBox(height: 1.h,),
                    Text("Successfully", style: TextStyle(
                        color: Colors.black, fontSize: 19.sp, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20.h,),

                    ElevatedButton(
                      onPressed: () {
                        Routers.replaceAllWithName(context, '/amRegLoadsFromSuccess');

                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        //  onPrimary: Colors.white,
                        //  splashFactory: InkRipple.splashFactory,
                        primary: Colors.indigo,
                        padding: EdgeInsets.symmetric(
                            horizontal: 28.w, vertical: 2.h),),
                      child: Text("Continue",
                        style: TextStyle(color: Colors.white,
                            fontSize: 16.sp, fontWeight: FontWeight.bold),),

                    ),


                  ],),
              ),
            ),
          ),
        ),),
    );
  }

  Future<bool> willPopControll() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        //  title: new Text('Are you sure?'),
        content: const Text('The page you are navigating to is auto generated',
          style: TextStyle(fontWeight: FontWeight.bold),),
        actions: <Widget>[
          InkWell(onTap: (){
            Routers.pushNamed(context, '/admin_landing_manager');
          },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.arrow_back, ),
                TextButton(
                  onPressed: () =>  Routers.pushNamed(context, '/admin_landing_manager'),
                  child: Text('HomePage',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),),
                ),
              ],
            ),
          ),
        ],
      ),
    )) ??
        false;
  }
}
