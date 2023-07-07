import 'package:darl_dispatch/AuthManagers/authRepo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Models/global_variables.dart';
import '../../Utils/form_validators.dart';
import '../../Utils/progress_bar.dart';
import '../../Utils/routers.dart';

class ForgetPassEnterEmail extends StatefulWidget {
  const ForgetPassEnterEmail({Key? key}) : super(key: key);

  @override
  State<ForgetPassEnterEmail> createState() => _ForgetPassEnterEmailState();
}

class _ForgetPassEnterEmailState extends State<ForgetPassEnterEmail>  with FormValidators {

  TextEditingController resetPassController = TextEditingController();
  final GlobalKey<FormState> changePassKey = GlobalKey<FormState>();

  bool loading = false;

  var resetPassErrorMssg;

  int index = 5;

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
                Text("Enter your registerd email address to reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 17.sp),),
                   SizedBox(height: 10.h,),

                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.black),
                    controller: resetPassController,
                    validator: validateEmail,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                width: 1, color: Colors.blueAccent)),
                        prefixIcon: Icon(Icons.email),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Email Address",
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
      Response? response = await authRepo.resetPassWithEmail({
        "email": resetPassController.text
      });

      if(response != null && response.statusCode == 200 && response.data["success"] == 200){

        phoneNumber = response.data["tel"];

        Routers.pushNamed(context, '/forgotPassTel');

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
