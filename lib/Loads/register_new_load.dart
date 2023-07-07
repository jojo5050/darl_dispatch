
import 'package:darl_dispatch/AuthManagers/authRepo.dart';
import 'package:darl_dispatch/Models/load_reg_model.dart';
import 'package:darl_dispatch/Utils/form_validators.dart';
import 'package:darl_dispatch/Utils/progress_bar.dart';
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

import '../../../ConstantHelper/colors.dart';
import '../../../Utils/localstorage.dart';

class RegisterLoad extends StatefulWidget {
  const RegisterLoad({Key? key}) : super(key: key);

  @override
  _RegisterLoadState createState() => _RegisterLoadState();
}

class _RegisterLoadState extends State<RegisterLoad> with FormValidators {

  bool loading = false;

  LoadRegistrationModel loadModel = LoadRegistrationModel();

  var errorMessage;
  String role = "Admin";

  String? formatedDate;

  @override
  void initState() {
    getTodaysDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Form(key: loadModel.loadRegFormKey,
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
                        "LOAD REGISTRATION",
                        style: TextStyle(
                            color: AppColors.dashboardtextcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            decoration: TextDecoration.none),
                      ),
                  Container()

                ]
                ),

                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(onTap: (){
                      Routers.pushNamed(context, '/registered_loads_Preview');
                      },
                      child: Text(
                        "Load Details",
                        style: TextStyle(
                            color: AppColors.dashboardtextcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ],
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
                      hintText: "Enter Rate Confirmation",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: loadModel.rateConfirmController,
                  validator: validateRateCon,
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
                      hintText: "Enter Amount",
                      suffixIcon: Icon(Icons.attach_money, color: Colors.grey),
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: loadModel.amountController,
                  validator: validateLoadAmount,
                  keyboardType: TextInputType.number,

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
                      hintText: "Enter weight",
                      suffixIcon: Container(height: 3.h, width: 5.w,
                        padding: EdgeInsets.all(3),
                        child: Image.asset('assets/images/weight.png',
                            color: Colors.grey),
                      ),
                      hintStyle: TextStyle(color: Colors.grey)),
                      controller: loadModel.weightController,
                      validator: validateLoadWeight,
                      keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 1.h,
                ),
               /* Container(
                  height: 9.h,
                  width: MediaQuery.of(context).size.width / 0.7,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 2.h,
                        ),
                        TextFormField(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1960),
                                lastDate: DateTime(2025));
                            if (pickedDate != null) {
                              print("..........................$pickedDate");
                              String formatDate =
                              DateFormat("yyyy-MM-DD").format(pickedDate);
                              setState(() {
                                loadRegdateInputController.text = formatDate;
                              });
                            } else {
                              print("...............Date is empty");
                            }
                          },
                          controller: loadRegdateInputController,
                          style: TextStyle(color: Colors.black, fontSize: 18.sp),
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              ),
                              hintText: "Date",
                              hintStyle: TextStyle(color: Colors.grey)),
                          readOnly: true,
                        ),

                      ],
                    ),
                  ),
                ),*/
                SizedBox(
                  height: 1.h,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  style: TextStyle(color: Colors.black, fontSize: 18.sp),
                  decoration: InputDecoration(
                      //  border: InputBorder.none,

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1)),
                      hintText: "Enter load description",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: loadModel.loadDiscrController,
                  validator: validateLoadDescription,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Broker Details",
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
                TextFormField(
                  style: TextStyle(color: Colors.black, fontSize: 18.sp),
                  decoration: InputDecoration(
                      //  border: InputBorder.none,

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1)),
                      hintText: "Enter Broker name",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: loadModel.brokerNameController,
                  validator: validateBrokerName,
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
                      hintText: "Enter Broker email",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: loadModel.brokerEmailController,
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
                      hintText: "Enter Broker phone",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: loadModel.brokerPhoneController,
                  validator: validateBrokerNum,
                ),
                SizedBox(
                  height: 4.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Shipper Details",
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
                TextFormField(
                  style: TextStyle(color: Colors.black, fontSize: 18.sp),
                  decoration: InputDecoration(
                    //  border: InputBorder.none,

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: Colors.black, width: 1)),
                      hintText: "Enter Shipper email",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: loadModel.shipperEmailController,
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
                      hintText: "Enter Shipper address",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: loadModel.shipperAddressController,
                  validator: validateShipperAddress,
                ),

                SizedBox(
                  height: 4.h,
                ),

               // loading ? ProgressBar():
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigo[500],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide.none)),
                    onPressed: () {
                      if(loadModel.loadRegFormKey.currentState!.validate()){
                        showLoader();
                      }
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25.w, vertical: 2.h),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void submitLoad() async {
    var usrRole = await LocalStorage().fetch("roleKey");
   final AuthRepo authRepo = AuthRepo();
   dynamic userId = await LocalStorage().fetch("idKey");

   try{
     Response? response = await authRepo.registerLoad({
       "brokerName" : loadModel.brokerNameController.text,
       "brokerEmail" : loadModel.brokerEmailController.text,
       "brokerNumber" : loadModel.brokerPhoneController.text,
       "shipperEmail" : loadModel.shipperEmailController.text,
       "shipperAddress" : loadModel.shipperAddressController.text,
       "loadDescription" : loadModel.loadDiscrController.text,
       "dateRegistered" : formatedDate.toString(),
       "status" : "1",
       "registeredBy" : userId,
       "rate" : loadModel.amountController.text,
       "rateConfirmationID" : loadModel.rateConfirmController.text,
       "weight" : loadModel.weightController.text

     });

     if(response != null && response.statusCode == 200 && response.data["status"] == 200){
       desplayLoginsuccessmssg();
       stopLoder();
       if(usrRole == role){

         Routers.replaceAllWithName(context, '/adminRegLoadSuccessPage');
       }else{
         Routers.replaceAllWithName(context, '/dspRegLoadSuccessPage');
       }

     }else{
       setState(() {
         errorMessage = response?.data["message"];
       });

       displayErrorSnackbar();
     }


   }catch(e, str){
     debugPrint("Error: $e");
     debugPrint("StackTrace: $str");
   }
   setState(() {
     loading = false;
   });

  }

  Future desplayLoginsuccessmssg() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          "Load Registered Successfully",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  void displayErrorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          "$errorMessage",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }

  void showLoader() {
    showDialog(
        barrierDismissible: false,
        context: context, builder: (buildContext){
      submitLoad();
      return Container(
        color: Colors.transparent,
        child: const Center(child: ProgressBar(),),
      );
    });
  }

  Future<void> stopLoder() async {
    Navigator.of(context).pop();
  }

  void getTodaysDate() {
    var currentDate = new DateTime.now();
    var formater = new DateFormat("dd-MM-yyyy");
    formatedDate = formater.format(currentDate);

  }

}
