import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DriverEditProfile extends StatefulWidget {
  const DriverEditProfile({Key? key}) : super(key: key);

  @override
  State<DriverEditProfile> createState() => _DriverEditProfileState();
}

class _DriverEditProfileState extends State<DriverEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Edit Profile", style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.h),
        child: SingleChildScrollView(
          child: Column(children: [
            TextFormField(
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
              decoration: InputDecoration(
                //  border: InputBorder.none,

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(color: Colors.black, width: 1)),
                  hintText: "Full name",
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 1.h,
            ),

            TextFormField(
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
              decoration: InputDecoration(
                //  border: InputBorder.none,

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(color: Colors.black, width: 1)),
                  hintText: "Telephone",
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 1.h,
            ),

            TextFormField(
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
              decoration: InputDecoration(
                //  border: InputBorder.none,

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(color: Colors.black, width: 1)),
                  hintText: "Bank Name",
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 1.h,
            ),

            TextFormField(
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
              decoration: InputDecoration(
                //  border: InputBorder.none,

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(color: Colors.black, width: 1)),
                  hintText: "Account Name",
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 1.h,
            ),

            TextFormField(
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
              decoration: InputDecoration(
                //  border: InputBorder.none,

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(color: Colors.black, width: 1)),
                  hintText: "Account Number",
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 1.h,
            ),

            TextFormField(
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
              decoration: InputDecoration(
                //  border: InputBorder.none,

                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(color: Colors.black, width: 1)),
                  hintText: "House Address",
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 8.h,
            ),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.indigo[500],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide.none)),
                onPressed: () {
                },
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 25.w, vertical: 2.h),
                  child: Text(
                    "Update",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                )),

          ],),
        ),
      ),
    );
  }
}
