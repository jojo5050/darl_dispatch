import 'package:darl_dispatch/AuthManagers/authRepo.dart';
import 'package:darl_dispatch/LandingPageManagers/dispatcher_landing_page_manager.dart';
import 'package:darl_dispatch/Models/global_variables.dart';
import 'package:darl_dispatch/Utils/form_validators.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../ConstantHelper/colors.dart';
import '../../Utils/localstorage.dart';
import '../../Utils/progress_bar.dart';
import '../../Utils/routers.dart';

class EditVehicle extends StatefulWidget {
  const EditVehicle({Key? key}) : super(key: key);

  @override
  State<EditVehicle> createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> with FormValidators {
  var successMssg;
  var resetPassErrorMssg;

  final GlobalKey<FormState> updateVehicleFormKey = GlobalKey<FormState>();
  TextEditingController plateNumControl = TextEditingController();
  TextEditingController vehicleNumControl = TextEditingController();
  TextEditingController vinControl = TextEditingController();
  TextEditingController dateController = TextEditingController();

  bool loading = false;
  String dropDownValue = "Truck";
  var items = ["Truck", "Reefer", "Van",];

  var vehicleTypes;
  var vehicleNum;
  var viin;
  var plateNum;

  @override
  void initState() {
   getVehicleDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    plateNumControl = TextEditingController(text: plateNum);
    vehicleNumControl = TextEditingController(text: vehicleNum);
    vinControl  = TextEditingController(text: viin);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Update Vehicle", style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold, fontSize: 17.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: SingleChildScrollView(
          child: Form(
            key: updateVehicleFormKey,
            child: Column(children: [

              SizedBox(height: 0.5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(onTap: (){
                    Routers.pushNamed(context, '/registered_loads_Preview');
                  },
                    child: Text(
                      "Vehicle Details",
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
                controller: vehicleNumControl,
                validator: validateName,
                onChanged: (String val){
                  vehicleNum = val;
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
                    hintText: "VIN",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: vinControl,
                validator: validateName,
                onChanged: (String val){
                  viin = val;
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
                    hintText: "Number Plate",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: plateNumControl,
                validator: validateName,
                onChanged: (String val){
                  plateNum = val;
                },
              ),
              SizedBox(
                height: 1.h,
              ),

              SizedBox(height: 0.5.h,),
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
                height: 4.h,
              ),

              SizedBox(
                height: 25.h,
              ),
              loading ? ProgressBar():
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo[500],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide.none)),
                  onPressed: () {
                    if(updateVehicleFormKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      updateVehicleInfo();
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

  void updateVehicleInfo() async {
    final AuthRepo authRepo = AuthRepo();

    try{
      Response? response = await authRepo.updateVehicle({
        "vehicleType": dropDownValue,
        "number": vehicleNumControl.text,
        "vin": vinControl.text,
        "plateNumber": plateNumControl.text,
        "id": vehicleID.toString()

      });

      if(response != null && response.statusCode == 200){

        showPopUp();

      }else{
        setState((){
          resetPassErrorMssg = response?.data["message"];
        });

        desplayErromssge();
      }
    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }

    setState(() {
      loading = false;
    });

  }


  void desplayErromssge() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 2),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("$resetPassErrorMssg",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

  }

  void getVehicleDetails() async {
    final AuthRepo authRepo = AuthRepo();
      var id = vehicleID;
      print("print vehicle id asssssssssssss $id");
    try{
      Response? response = await authRepo.getVehicleDetail({
        "id": id.toString()
      });

      if(response != null && response.statusCode == 200 ){


        setState(() {
          vehicleTypes = response.data["vehicle Type"];
        });
        print("print vehicle num asssssssssss $vehicleTypes");
        setState(() {
          vehicleNum = response.data["Vehicle Number"];
        });
        print("print vehicle num asssssssssss $vehicleNum");
        setState(() {
          viin = response.data["Vehicle VIN"];
        });
        print("print vehicle num asssssssssss $viin");
        setState(() {
          plateNum = response.data["Vehicle PlateNumber"];
        });
        print("print vehicle num asssssssssss $plateNum");

      }else{

        print("could not retreive it");
      }

    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }

  }

  void showPopUp() {
    loading = false;
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
            backgroundColor: Colors.black87,
            actions: <Widget>[SizedBox(height: 20,),
              Center(child: Icon(Icons.check_circle_outline,
                color: Colors.green, size: 35.sp,)),
              SizedBox(height: 15,),
               Center(
                child: Text(" Success!",
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 25,),
               Center(
                child: Text(" Vehicle Details was Updated",
                  style: TextStyle(
                      fontSize: 16.sp, color: Colors.white
                  ),
                ),
              ), SizedBox(height: 5,),
               Center(
                child: Text("Successfully",
                  style: TextStyle(
                      fontSize: 16.sp, color: Colors.white
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
