import 'package:darl_dispatch/Models/global_variables.dart';
import 'package:darl_dispatch/Utils/localstorage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../../Utils/form_validators.dart';
import '../../Utils/progress_bar.dart';
import '../../Utils/routers.dart';

class ResetPassFinal extends StatefulWidget {
  const ResetPassFinal({Key? key}) : super(key: key);

  @override
  State<ResetPassFinal> createState() => _ResetPassFinalState();
}

class _ResetPassFinalState extends State<ResetPassFinal>  with FormValidators {

  TextEditingController passResetController = TextEditingController();
  TextEditingController passResetConfirmPassController = TextEditingController();
  final GlobalKey<FormState> passResetFinalFormKey = GlobalKey<FormState>();

  bool loading = false;

  var resetPassErrorMssg;

  var successMssg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 7.w),
        child: SingleChildScrollView(
          child: Form(
            key: passResetFinalFormKey,
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
                Text("Enter a new password to reset your password", textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 17.sp),),
                SizedBox(height: 10.h,),

                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.black),
                  controller: passResetController,
                  validator: validatePassword,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 1, color: Colors.blueAccent)),
                      prefixIcon: Icon(Icons.lock),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "New Password",
                      hintStyle: TextStyle(color: Colors.grey)),

                ),
                  SizedBox(height: 7.h,),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.black),
                  controller: passResetConfirmPassController,
                  validator: validateConfirmPass,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 1, color: Colors.blueAccent)),
                      prefixIcon: Icon(Icons.lock),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(color: Colors.grey)),

                ),
                SizedBox(height: 30.h,),


                loading ? ProgressBar():
                ElevatedButton(
                  onPressed: () {
                    if(passResetFinalFormKey.currentState!.validate()){
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
                        horizontal: 25.w, vertical: 2.h),),
                  child: Text("Reset Password",
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
     var token = await LocalStorage().fetch("token");

    print("printing token assssssssss$token");
    print("printing token again assssssssss${token.toString()}");

    try{
      Response? response = await authRepo.resetPassFinal({
        "id": res.toString(),
        "password": passResetController.text,
        "cpassword": passResetConfirmPassController.text
      });

      if(response != null && response.statusCode == 200 && response.data["status"] == 200){

        setState((){
          successMssg = response.data["message"];
        });
        desplaySuccess();

        Routers.pushNamed(context, '/login_page');


      }else{
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

  String? validateConfirmPass(String? value) {

    if(value != passResetController.text){
      return "Password did not match";
    }
    return null;
  }

  void desplaySuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("$successMssg",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );

  }
}
