import 'package:darl_dispatch/Models/global_variables.dart';
import 'package:darl_dispatch/Utils/form_validators.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../../Utils/progress_bar.dart';
import '../../Utils/routers.dart';

class ForgotPassConfirmTel extends StatefulWidget {
  const ForgotPassConfirmTel({Key? key}) : super(key: key);

  @override
  State<ForgotPassConfirmTel> createState() => _ForgotPassConfirmTelState();
}

class _ForgotPassConfirmTelState extends State<ForgotPassConfirmTel> with FormValidators {

  TextEditingController resetPassController = TextEditingController();
  final GlobalKey<FormState> changePassKey = GlobalKey<FormState>();

  bool loading = false;

  var resetPassErrorMssg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 7.w),
        child: SingleChildScrollView(
          child: Form(
            key: changePassKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: const Icon(Icons.arrow_back_ios, size: 30, color: Colors.black,))

                  ],
                ),SizedBox(height: 3.h,),
                Text("Please confirm your registered phone number to proceed",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 17.sp),),
                SizedBox(height: 8.h,),

                Text("${phoneNumber?.replaceRange(4, 9, "xxxxx") ?? ""}", style: TextStyle(color: Colors.black, fontSize: 20.sp,
                fontWeight: FontWeight.bold),),

                SizedBox(height: 3.h,),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  controller: resetPassController,
                  validator: validatePhoneNum,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 1, color: Colors.blueAccent)),
                      prefixIcon: Icon(Icons.phone),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Phone Number",
                      hintStyle: TextStyle(color: Colors.grey)),

                ),
                SizedBox(height: 40.h,),


                loading ? ProgressBar():
                ElevatedButton(
                  onPressed: () {
                    if(changePassKey.currentState!.validate()){
                      setState(() {
                        loading = true;

                      });
                      continueReset();
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    //  onPrimary: Colors.white,
                    //  splashFactory: InkRipple.splashFactory,
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(
                        horizontal: 30.w, vertical: 2.h),),
                  child: Text("Continue",
                    style: TextStyle(color: Colors.white,
                        fontSize: 16.sp, fontWeight: FontWeight.bold),),

                ),
              ],

            ),
          ),
        ),
      ),

    );
  }

  void continueReset() async {
    final  AuthRepo authRepo = AuthRepo();

    try{
      Response? response = await authRepo.resetPassWithTel({
        "tel": phoneNumber.toString()
      });

      if(response != null && response.statusCode == 200 && response.data["success"] == 200 ){

        res = response.data["id"];
        print("iddddddddddddddd asssssss  $res");

        Routers.pushNamed(context, '/resetPassFinal');

      }
      else{
        setState((){
          resetPassErrorMssg = response?.data["message"];
        });

        desplayErromssge();

      }
    }catch(e){
      return;
    }

    setState(() {
      loading = false;
    });
  }

  void desplayErromssge() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("$resetPassErrorMssg",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );

  }
}
