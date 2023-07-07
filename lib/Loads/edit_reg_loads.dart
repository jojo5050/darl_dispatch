import 'package:darl_dispatch/AuthManagers/authRepo.dart';
import 'package:darl_dispatch/LandingPageManagers/dispatcher_landing_page_manager.dart';
import 'package:darl_dispatch/Models/global_variables.dart';
import 'package:darl_dispatch/Utils/form_validators.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../ConstantHelper/colors.dart';
import '../../../Utils/localstorage.dart';
import '../../../Utils/progress_bar.dart';
import '../../../Utils/routers.dart';

class EditRegisteredLoads extends StatefulWidget {
  const EditRegisteredLoads({Key? key}) : super(key: key);

  @override
  State<EditRegisteredLoads> createState() => _EditRegisteredLoadsState();
}

class _EditRegisteredLoadsState extends State<EditRegisteredLoads> with FormValidators {
  var successMssg;
  var resetPassErrorMssg;

  final GlobalKey<FormState> updateLoadFormKey = GlobalKey<FormState>();
  TextEditingController rateConfirmController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController loadDescController = TextEditingController();
  TextEditingController brokerNameController = TextEditingController();
  TextEditingController brokerEmailController = TextEditingController();
  TextEditingController brokerPhoneController = TextEditingController();
  TextEditingController shiperEmailController = TextEditingController();
  TextEditingController shipperAddressController = TextEditingController();

  bool loading = false;


  var rateCon;
  var amount;
  var weight;
  var loadDesc;
  var brokerName;
  var brokerEmail;
  var brokerPhone;
  var shipperEmail;
  var shipperAddress;
  var date;


  @override
  void initState() {
    getLoadDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    rateConfirmController = TextEditingController(text: rateCon);
    amountController  = TextEditingController(text: amount);
    weightController  = TextEditingController(text: weight);
    loadDescController = TextEditingController(text: loadDesc);
    brokerNameController = TextEditingController(text: brokerName);
    brokerEmailController = TextEditingController(text: brokerEmail);
    brokerPhoneController = TextEditingController(text: brokerPhone);
    shiperEmailController = TextEditingController(text: shipperEmail);
    shipperAddressController = TextEditingController(text: shipperAddress);
    dateController = TextEditingController(text: date);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Update Load", style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: SingleChildScrollView(
          child: Form(
            key: updateLoadFormKey,
            child: Column(children: [

              SizedBox(height: 0.5.h,),
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
                    hintText: "Rate Confirmation",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: rateConfirmController,
                validator: validateName,
                onChanged: (String val){
                  rateCon = val;
                },
              ),
              SizedBox(
                height: 1.h,
              ),

              SizedBox(height: 0.5.h,),

              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "Amount",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: amountController,
                validator: validateName,
                onChanged: (String val){
                  amount = val;
                },
              ),
              SizedBox(
                height: 1.h,
              ),

              SizedBox(height: 0.5.h,),
              Container(
                height: 8.h,
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
                              dateController.text = formatDate;
                            });
                          } else {
                            print("...............Date is empty");
                          }
                        },
                       /* onChanged: (val){
                          date = val;
                        },*/
                        controller: dateController,
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
              ),
              SizedBox(height: 0.5.h,),
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "Weight",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: weightController,
                validator: validateName,
                onChanged: (String val){
                  weight = val;
                },
              ),
              SizedBox(
                height: 1.h,
              ),

              SizedBox(height: 0.5.h,),
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "Load Description",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: loadDescController,
                validator: validateName,
                onChanged: (String val){
                  bankName = val;
                },
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
                    hintText: "Broker Name",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: brokerNameController,
                validator: validateName,
                onChanged: (String val){
                  brokerName = val;
                },
              ),
              SizedBox(
                height: 1.h,
              ),

              SizedBox(height: 0.5.h,),
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "broker Email",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: brokerEmailController,
                validator: validateEmail,
                onChanged: (String val){
                  brokerEmail = val;
                },
              ),
              SizedBox(height: 0.5.h,),
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "Broker Phone",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: brokerPhoneController,
                validator: validatePhoneNum,
                onChanged: (String val){
                  brokerPhone = val;
                },
              ),
              SizedBox(height: 4.h,),
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
              SizedBox(height: 1.h,),
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "Shipper Email",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: shiperEmailController,
                validator: validateEmail,
                onChanged: (String val){
                  shipperEmail = val;
                },
              ),

              SizedBox(height: 0.5.h,),
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "Shipper Address",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: shipperAddressController,
                validator: validateAddress,
                onChanged: (String val){
                  shipperAddress = val;
                },
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
                    if(updateLoadFormKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      updateLoadInfo();
                    }

                  },
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 2.h),
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
      ),
    );
  }

  void updateLoadInfo() async {
    AuthRepo authRepo = AuthRepo();
    var token = await LocalStorage().fetch("token");
    print("printing token assssssssss${token.toString()}");
    try{
      Response? response = await authRepo.updateRegLoads({
        "rateConfirmationID": rateConfirmController.text,
        "rate":amountController.text,
        "weight": weightController.text,
        "dateRegistered": dateController.text,
        "loadDescription": loadDescController.text,
        "brokerName" : brokerNameController.text,
        "brokerEmail" : brokerEmailController.text,
        "brokerNumber" : brokerPhoneController.text,
        "shipperEmail" : shiperEmailController.text,
        "shipperAddress" : shipperAddressController.text
      });


      if(response != null && response.statusCode == 200){

        showPopUp();

        setState((){
          successMssg = response.data["message"];
        });
        desplaySuccess();

      }else{
        setState((){
          resetPassErrorMssg = response?.data["message"];
        });

        desplayErromssge();
      }
    }catch(e){
      return;
    }
    loading = false;

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

  void getLoadDetails() async {

    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.fetchSingleLoad({
        "id": singleLoadID.toString()
      });

      if(response != null && response.statusCode == 200){

        setState(() {
          rateCon = response.data["Rate ConfirmationID"];
        });
        print("printttttt rate con as $rateCon");
        setState(() {
          amount = response.data["Rate"];
        });
        setState(() {
          weight = response.data["weight"];
        });
        setState(() {
          loadDesc = response.data["Broker Name"];
        });
        setState(() {
          brokerName = response.data["Broker Name"];
        });
        setState(() {
          brokerEmail = response.data["Broker Name"];
        });
        setState(() {
          brokerPhone = response.data["Broker Name"];
        });
        setState(() {
          shipperEmail = response.data["Shipper Email"];
        });
        setState(() {
          shipperAddress = response.data["Shipper Address"];
        });
        setState(() {
          date = response.data["date Registered"];
        });

      }else{

        print("could not retreive it");
      }

    }catch(e, str){
       debugPrint("error $e");
       debugPrint("StackTrace: $str");
    }

  }

  void showPopUp() {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
            backgroundColor: Colors.black87,
            actions: <Widget>[SizedBox(height: 20,),
              Center(child: Icon(Icons.check_circle_outline,
                color: Colors.green, size: 40.sp,)),
              SizedBox(height: 15,),
              const Center(
                child: Text(" Success!",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 25,),
              const Center(
                child: Text(" Load Details was Updated",
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
