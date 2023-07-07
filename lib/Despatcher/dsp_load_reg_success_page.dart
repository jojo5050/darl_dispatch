import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Utils/routers.dart';


class DspRegLoadSuccessPage extends StatelessWidget {
  const DspRegLoadSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                       Routers.pushNamed(context, '/dispatcher_landingPage_manager');
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
                        Routers.replaceAllWithName(context, '/dspRegLoadsFromSuccess');

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
      ),);
  }
}
