import 'package:darl_dispatch/Utils/form_validators.dart';
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../AuthManagers/authRepo.dart';
import '../../../ConstantHelper/colors.dart';
import '../../../Models/global_variables.dart';
import '../../../Utils/progress_bar.dart';

class PickPickUp extends StatefulWidget {
  const PickPickUp({Key? key}) : super(key: key);

  @override
  _PickPickUpState createState() => _PickPickUpState();
}

class _PickPickUpState extends State<PickPickUp> with FormValidators {

  var errMsg;
  List<Map<String, dynamic>>? listOfPickups;

  var pickUpId;

  TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> commentFormKey = GlobalKey<FormState>();

  var errorMssg;

  String? formatedDate;

  String? currentTime;

  var truckNum;

  var trailerNum;

  var tractorNum;

  @override
  void initState() {
    getTodaysDate();
    getTodaysTime();
    getPickup();
    getTruckNum();
    getTrailerNum();
    getTractorNum();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
          child: Column(children: [
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
                "PickUps",
                style: TextStyle(
                    color: AppColors.dashboardtextcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    decoration: TextDecoration.none),
              ),
              Container(
                height: 0,
                width: 0,
              ),
            ]),
            SizedBox(height: 1.h,),
            Expanded(
              child: Container(
                child: listOfPickups == null ? Center(child: CircularProgressIndicator(color: Colors.blue,)):
                listOfPickups!.isEmpty ?
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 40.h,),
                      Icon(Icons.question_mark, color: Colors.grey, size: 40.sp,),
                      const Text(
                        "No Registered Pickup Yet",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                ) : ListView.builder(
                    itemCount: listOfPickups!.length,
                    itemBuilder: (context, index){

                      return Container(
                          height: 30.h,
                          child: Card(
                            color: Colors.green,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3.w,),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 1.h,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text("Pickup State:",  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                                SizedBox(width: 4.w,),
                                                Text("${listOfPickups![index]["state"]}",  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                              ],

                                            ),
                                            PopupMenuButton(
                                                color: Colors.black,
                                                elevation: 20,
                                                shape: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(15)),
                                                icon: const Center(
                                                  child: Icon(
                                                    Icons.more_vert,
                                                    color: Colors.black,
                                                    size: 30,
                                                  ),
                                                ),
                                                onSelected: (value){
                                                  switch (value) {
                                                    case 1: showPickModal(index);
                                                    break;
                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 1,
                                                    child: Container(
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.add_circle,
                                                              color: Colors.green,
                                                              size: 20,
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "PICK",
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 16.sp,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                          ],
                                                        ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 2,
                                                    child: Container(
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                              size: 20,
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 15.sp,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                          ],
                                                        ),
                                                    ),
                                                  ),

                                                ]),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 1.h,
                                        ),

                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Pickup City:",  style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                            SizedBox(width: 4.w,),
                                            Text("${listOfPickups![index]["city"]}",  style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          ],

                                        ),

                                        SizedBox(height: 1.5.h,),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Pickup date:",  style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                            SizedBox(width: 4.w,),
                                            Text("${listOfPickups![index]["date"]}",  style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          ],

                                        ),

                                        SizedBox(height: 1.5.h,),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Pickup Time:",  style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                            SizedBox(width: 4.w,),
                                            Text("${listOfPickups![index]["time"]}",  style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          ],

                                        ),
                                        SizedBox(height: 1.5.h,),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Pickup ZipCode:",  style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                            SizedBox(width: 4.w,),
                                            Text("${listOfPickups![index]["stateZipCode"]}",  style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          ],

                                        ),

                                        SizedBox(height: 1.5.h,),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Address",  style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                            SizedBox(width: 4.w,),
                                            Text("${listOfPickups![index]["address"]}",  style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          ],

                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        );

                    }),
              ),
            ),
            SizedBox(height: 4.h,),
           
          ],),
        ),
    );
  }

  void showSuccessDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("Vehicle Deleted Successfuly",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

  }

  void showErr() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("$errMsg",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

  }

  void getPickup() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getPickups({
        "loadID": loadToBePickedId.toString()
      });
      print("print load id assssssss ${singleLoadID}");

      if(response != null && response.statusCode == 200){
        List regPickups = response.data["data"]["docs"];

        print("print pickup asssss${regPickups}");
        List<Map<String,dynamic>> data = [];

        if(regPickups.length > 0){
          for(int i = 0; i < regPickups.length; i++){
            Map<String,dynamic> regLoadList = regPickups[i];
            data.add(regLoadList);
          }
        }
        setState(() {
          listOfPickups = data;
        });

        print("printing list of pickups asssssss $listOfPickups");

      }else  {
        print("Errorrrrrrrrrrr");

      }

    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");

    }

  }

  void showPickModal(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        pickUpId = listOfPickups![index]["id"];

        print("printttttttttttttt pickupid assssssssss $pickUpId");

        return SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: commentFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 1.h,),
                  const Divider(
                    color: Colors.grey,
                    height: 5,
                    thickness: 5,
                    indent: 150,
                    endIndent: 150,
                  ),
                  SizedBox(height: 3.h,),
                  Text("Add a Comment (Optional)", style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold, fontSize: 18.sp),),
                  SizedBox(height: 2.h,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                    child: TextFormField(
                      maxLines: 3,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black, fontSize: 18.sp),
                      controller: commentController,
                        validator: validateComment,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(15)),
                          fillColor: AppColors.textFieldColor,
                          filled: true,
                          hintText: "Leave a comment",
                          hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo[500],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide.none)),
                      onPressed: () {
                        startLoader();
                        pickLoad();
                        },
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                        child: Text(
                          "Pick Load",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  SizedBox(height: 2.h,),
                ],
              ),
            ),
          ),
        );
      },
    );

  }

  void pickLoad() async {
    final AuthRepo authRepo = AuthRepo();
    try {
      Response? response = await authRepo.pickLoad({
        "pickID": pickUpId,
        "status": "2",
        "load_id": loadToBePickedId.toString(),
        "pickedupTime": currentTime.toString(),
        "pickedup_Date": formatedDate.toString(),
        "pickedStatus": "2",
        "totalLoadPicked": totalLoadPicked.toString(),
        "comment": commentController.text,
        "truck": truckNum ?? "",
        "trailer": pickTrailerNum.toString() ?? "",
        "tractor": pickTractorNum.toString() ?? ""
      });

      if (response != null && response.statusCode == 200
          && response.data["Status"] == 200) {
        stopLoader();
        showPopUp();
      } else {
        setState(() {
          errorMssg = response?.data["message"];
        });

        desplayErromssge();
      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }

    setState(() {
      // loading = false;
    });

  }

  Future<void> stopLoader() async {
    Navigator.of(context).pop();
  }

  void showPopUp() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 40.sp,
              )),
          SizedBox(
            height: 15,
          ),
          const Center(
            child: Text(
              " Success!",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          const Center(
            child: Text(
              " Load Was Picked ",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          const Center(
            child: Text(
              "Successfully",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Center(
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/loadsAssignedPreview');
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
                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void desplayErromssge() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("$errorMssg",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

  }

  void getTodaysDate() {
    var currentDate = new DateTime.now();
    var formater = new DateFormat("yyyy-MM-dd");
    formatedDate = formater.format(currentDate);
  }

  void getTodaysTime() {
    DateTime now = DateTime.now();
    currentTime = DateFormat('HH:mm:ss').format(now);

  }

  Future<void> startLoader() async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: const Center(child: ProgressBar(),),
        );
      },
    );

  }

  void getTruckNum() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getAssignedTruck({
        "load_id": loadToBePickedId.toString()
      });
      if(response != null && response.statusCode == 200
          && response.data["Code"] == 200){

          var truckDetails = response.data;
          setState(() {
            truckNum = truckDetails["number"];
          });
          print("print truck assssssssssss........$truckNum");

      }else{
        var error = response?.data;
      }

    }catch(e){


    }

  }

  void getTrailerNum() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getAssignedTrailer({
        "load_id": loadToBePickedId.toString()
      });
      if(response != null && response.statusCode == 200
          && response.data["Code"] == 200){

        var trailerDetails = response.data;
        setState(() {
          trailerNum = trailerDetails["number"];
        });
        print("print truck assssssssssss........$trailerNum");

      }else{
        var error = response?.data;
      }

    }catch(e){


    }

  }

  void getTractorNum() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getAssignedTractor({
        "load_id": loadToBePickedId.toString()
      });
      if(response != null && response.statusCode == 200
          && response.data["Code"] == 200){

        var tractorDetails = response.data;
        setState(() {
          tractorNum = tractorDetails["number"];
        });
        print("print truck assssssssssss........$tractorNum");

      }else{
        var error = response?.data;
      }

    }catch(e){


    }

  }

}
