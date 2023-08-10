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

class UpdatePickup extends StatefulWidget {
  const UpdatePickup({Key? key}) : super(key: key);

  @override
  State<UpdatePickup> createState() => _UpdatePickupState();
}

class _UpdatePickupState extends State<UpdatePickup> with FormValidators {
  var successMssg;
  var resetPassErrorMssg;

  final GlobalKey<FormState> updatePickupFormKey = GlobalKey<FormState>();
  TextEditingController pickStateController = TextEditingController();
  TextEditingController pickCityController = TextEditingController();
  TextEditingController pickDateController = TextEditingController();
  TextEditingController pickTimeController = TextEditingController();
  TextEditingController pickZipController = TextEditingController();
  TextEditingController pickAddressController = TextEditingController();
  TextEditingController pickNameController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    //  getLoadDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pickStateController = TextEditingController(text: editPickState);
    pickCityController = TextEditingController(text: editPickCity);
    pickDateController = TextEditingController(text: editPickDate);
    pickTimeController = TextEditingController(text: editPickTime);
    pickZipController = TextEditingController(text: editPickZip);
    pickAddressController = TextEditingController(text: editPickAddress);
    pickNameController = TextEditingController(text: editPickName);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Update Pickup", style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold, fontSize: 17.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: SingleChildScrollView(
          child: Form(
            key: updatePickupFormKey,
            child: Column(children: [

              SizedBox(height: 0.5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(onTap: (){
                    Routers.pushNamed(context, '/registered_loads_Preview');
                  },
                    child: Text(
                      "Pickup Details",
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
                    hintText: "Pickup State",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: pickStateController,
                validator: validateName,
                onChanged: (String val){
                  editPickState = val;
                },
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
                    hintText: "Pickup City",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: pickCityController,
                validator: validateName,
                onChanged: (String val){
                  editPickCity = val;
                },
              ),
              SizedBox(
                height: 1.h,
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
                    hintText: "Date",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: pickDateController,
                validator: validateName,
                onChanged: (String val){
                  editPickDate = val;
                },
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
                    hintText: "Time",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: pickTimeController,
                validator: validateName,
                onChanged: (String val){
                  editPickTime = val;
                },
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
                    hintText: "Zipcode",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: pickZipController,
                validator: validateName,
                onChanged: (String val){
                  editPickZip = val;
                  print(":::::::::::::::::::::::::::$editDescription");
                },
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
                    hintText: "Description",
                    hintStyle: TextStyle(color: Colors.grey)),
                controller: pickNameController,
                validator: validateName,
                onChanged: (String val){
                  editPickName = val;
                },
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
                controller: pickAddressController,
                validator: validateName,
                onChanged: (String val){
                  editPickAddress = val;
                },
              ),
              SizedBox(
                height: 1.h,
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
                    if(updatePickupFormKey
                        .currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      updatePickInfo();
                    }

                  },
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 2.h),
                    child: Text(
                      "Update Pickup",
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

  void updatePickInfo() async {
    AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.updatePickup({
        "date": pickDateController.text,
        "time":pickTimeController.text,
        "city": pickCityController.text,
        "state": pickStateController.text,
        "load_id": editPickLoadID.toString(),
        "name": pickNameController.text,
        "stateZipCode" : pickZipController.text,
        "address" : pickAddressController.text,
        "id": editPickID.toString()
      });


      if(response != null && response.statusCode == 200 && response.data["status"] == 200){

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
                child: Text("Pickup Details Updated",
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
                      if(userRole == "Admin"){
                        Routers.pushNamed(context, '/am_reg_loads_with_pd_Preview');
                      }else{
                        Routers.pushNamed(context, '/dsp_reg_loads_with_pd_preview');
                      }

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
