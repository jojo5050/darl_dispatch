import 'package:darl_dispatch/AuthManagers/authRepo.dart';
import 'package:darl_dispatch/Utils/form_validators.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Utils/progress_bar.dart';

class RegisterNewUser extends StatefulWidget {
  const RegisterNewUser({Key? key}) : super(key: key);

  @override
  State<RegisterNewUser> createState() => _RegisterNewUserState();
}

class _RegisterNewUserState extends State<RegisterNewUser> with FormValidators {

  final GlobalKey<FormState> createUserFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accNumController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController licenceController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController accNameController = TextEditingController();

  bool loading = false;

  var errorMsg;

  String dropDownValue = "Admin";
  var items = ["Admin", "Accountant", "Despatcher", "Driver"];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Register New User", style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: SingleChildScrollView(
          child: Form(
            key: createUserFormKey,
            child: Column(children: [

              SizedBox(height: 0.5.h,),
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "Full Name",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: nameController,
                validator: validateName,
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
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: emailController,
                validator: validateEmail,
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
                controller: telController,
                validator: validatePhoneNum,
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
                controller: bankNameController,
                validator: validateBankName,
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
                controller: accNumController,
                validator: validateAccNum,
              ),
              SizedBox(
                height: 1.h,
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
                controller: accNameController,
                validator: validateAccName,
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
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: passController,
                validator: validatePassword,
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
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: confirmController,
                validator: validateConPass,
              ),
              SizedBox(
                height: 1.h,
              ),

              Container(
                height: 7.h,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Role:", style: TextStyle(color: Colors.grey, fontSize: 18.sp),),
                      DropdownButton<String>(
                          value: dropDownValue, style: TextStyle(fontSize: 20, color: Colors.black,),
                          icon: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black, size: 30,),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                                value: items, child: Text(items));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              dropDownValue = newValue!;
                            });
                          }),
                    ],
                  ),
                ),
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
                    hintText: "LicenceID",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: licenceController,
                validator: validateLicence,
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
                    hintText: "Address",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: addressController,
                validator: validateAddress,
              ),
              SizedBox(
                height: 5.h,
              ),
              loading ? ProgressBar():
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo[500],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide.none)),
                  onPressed: () {
                    if(createUserFormKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      createUser();
                    }

                  },
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 2.h),
                    child: Text(
                      "Create",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  )),

            ],),
          ),
        ),
      ),
    );
  }

  void createUser() async {

       final AuthRepo authRepo = AuthRepo();

       try{
         Response? response = await authRepo.createNewUser({
           "name": nameController.text,
           "tel": telController.text,
           "role": dropDownValue,
           "email": emailController.text,
           "password": passController.text,
           "accountNumber": accNumController.text,
           "accountName": accNameController.text,
           "bankName": bankNameController.text,
           "licenseID": licenceController.text,
           "address": addressController.text
         });

         if(response != null && response.statusCode == 200 && response.data["status"] == 200){
           showSuccessPopup();

         }else{
           setState(() {
             errorMsg = response!.data["message"];
           });
            displayErrorMsg();
         }
       }catch(e, str){
         debugPrint("Error: $e");
         debugPrint("StackTrace: $str");

       }
       setState(() {
         loading = false;
       });
  }

  Future desplaySignupsuccessmssg() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        duration: Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          "User Created Successful",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }

  Future  displayErrorMsg() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        duration: Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          "$errorMsg",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }

  String? validateConPass(String? value) {

    if(value != passController.text){
      return "Password did not match";
    }
    return null;
  }

  void showSuccessPopup() {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
            backgroundColor: Colors.black87,
            actions: <Widget>[SizedBox(height: 30,),
              Center(child: Icon(Icons.check_circle_outline,
                color: Colors.green, size: 50.sp,)),
              SizedBox(height: 20,),
              const Center(
                child: Text(" Success!",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 30,),
              const Center(
                child: Text("New User Created",
                  style: TextStyle(
                      fontSize: 20, color: Colors.white
                  ),
                ),
              ), SizedBox(height: 5,),
              const Center(
                child: Text("Successfully",
                  style: TextStyle(
                      fontSize: 20, color: Colors.white
                  ),
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                     Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("OK", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),),
                      ),
                    )),
              ),
              SizedBox(height: 10,),

            ],
          ),
    );
  }
}
