import 'package:darl_dispatch/AuthManagers/authRepo.dart';
import 'package:darl_dispatch/Utils/form_validators.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Utils/progress_bar.dart';
import '../../Utils/routers.dart';

class RegisterNewVehicle extends StatefulWidget {
  const RegisterNewVehicle({Key? key}) : super(key: key);

  @override
  State<RegisterNewVehicle> createState() => _RegisterNewVehicleState();
}

class _RegisterNewVehicleState extends State<RegisterNewVehicle> with FormValidators {

  final GlobalKey<FormState> createVehicleFormKey = GlobalKey<FormState>();
  TextEditingController vehicleIdController = TextEditingController();
  TextEditingController vinController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();


  bool loading = false;
  var errorMsg;

  String dropDownValue = "Truck";
  var items = ["Truck", "Reefer", "Van",];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Register New Vehicle", style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: SingleChildScrollView(
          child: Form(
            key: createVehicleFormKey,
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
                    hintText: "Vehicle ID",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: vehicleIdController ,
              //  validator: validateName,
              ),
              SizedBox(
                height: 1.5.h,
              ),

              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "VIN",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: vinController,
              //  validator: validatePhoneNum,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
                decoration: InputDecoration(
                  //  border: InputBorder.none,

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1)),
                    hintText: "Number Plate",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: plateNumberController,
              //  validator: validateBankName,
              ),
              SizedBox(
                height: 1.5.h,
              ),

              Container(
                height: 7.h,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Vehicle Type:", style: TextStyle(color: Colors.grey, fontSize: 18.sp),),
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
                height: 37.h,
              ),
              loading ? ProgressBar():
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo[500],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide.none)),
                  onPressed: () {
                    if(createVehicleFormKey.currentState!.validate()){
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
                      "Register",
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
        "vehicleType": dropDownValue,
        "number": vehicleIdController.text,
        "vin": vinController.text,
        "plateNumber": plateNumberController.text,
        "status": "0"
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
                child: Text("Vehicle Registered",
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
                      Routers.pushNamed(context, '/availableVehicles');
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
