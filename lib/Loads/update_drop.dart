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

class UpdateDrop extends StatefulWidget {
  const UpdateDrop({Key? key}) : super(key: key);

  @override
  State<UpdateDrop> createState() => _UpdateDropState();
}

class _UpdateDropState extends State<UpdateDrop> with FormValidators {
  var successMssg;
  var resetPassErrorMssg;

  final GlobalKey<FormState> updateDropFormKey = GlobalKey<FormState>();
  TextEditingController dropStateController = TextEditingController();
  TextEditingController dropCityController = TextEditingController();
  TextEditingController dropDateController = TextEditingController();
  TextEditingController dropTimeController = TextEditingController();
  TextEditingController dropZipController = TextEditingController();
  TextEditingController dropAddressController = TextEditingController();
  TextEditingController dropNameController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    //  getLoadDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dropStateController = TextEditingController(text: editDropState);
    dropCityController = TextEditingController(text: editDropCity);
    dropDateController = TextEditingController(text: editDropDate);
    dropTimeController = TextEditingController(text: editDropTime);
    dropZipController = TextEditingController(text: editDropZip);
    dropAddressController = TextEditingController(text: editDropAddress);
    dropNameController = TextEditingController(text: editDropName);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Update Drop", style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold, fontSize: 17.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: SingleChildScrollView(
          child: Form(
            key: updateDropFormKey,
            child: Column(children: [

              SizedBox(height: 0.5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(onTap: (){
                    Routers.pushNamed(context, '/registered_loads_Preview');
                  },
                    child: Text(
                      "Drop Details",
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
                controller: dropStateController,
                validator: validateName,
                onChanged: (String val){
                  editDropState = val;
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
                controller: dropCityController,
                validator: validateName,
                onChanged: (String val){
                  editDropCity = val;
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
                controller: dropDateController,
                validator: validateName,
                onChanged: (String val){
                  editDropDate = val;
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
                controller: dropTimeController,
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
                controller: dropZipController,
                validator: validateName,
                onChanged: (String val){
                  editDropZip = val;
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
                controller: dropNameController,
                validator: validateName,
                onChanged: (String val){
                  editDropName = val;
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
                controller: dropAddressController,
                validator: validateName,
                onChanged: (String val){
                  editDropAddress = val;
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
                    if(updateDropFormKey
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
      Response? response = await authRepo.updateDrop({
        "date": dropDateController.text,
        "time":dropTimeController.text,
        "city": dropCityController.text,
        "state": dropStateController.text,
        "load_id": editDropLoadID.toString(),
        "name": dropNameController.text,
        "stateZipCode" : dropZipController.text,
        "address" : dropAddressController.text,
        "id": editDropID.toString()
      });


      if(response != null && response.statusCode == 200
          && response.data["status"] == 200){

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
                child: Text("Drop Details Updated",
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
