import 'package:darl_dispatch/Utils/loaderFadingBlue.dart';
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../AuthManagers/authRepo.dart';
import '../../../ConstantHelper/colors.dart';
import '../../../Models/global_variables.dart';

class RegisteredPickDrop extends StatefulWidget {
  const RegisteredPickDrop({Key? key}) : super(key: key);

  @override
  _RegisteredPickDropState createState() => _RegisteredPickDropState();
}

class _RegisteredPickDropState extends State<RegisteredPickDrop> {

  var errMsg;

  List<Map<String, dynamic>>? listOfDrops;

  List<Map<String, dynamic>>? listOfPickups;

  var emptyLList;

  @override
  void initState() {
    getPickup();
    getDrop();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Pickups/Drops", style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold, fontSize: 17.sp)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child: Column(children: [
            Align(alignment: Alignment.centerLeft,
              child: Text("Pickups:", style: TextStyle(color: AppColors.dashboardtextcolor,
                  fontSize: 18.sp, fontWeight: FontWeight.bold ),),
            ),
            SizedBox(height: 1.h,),
            Container(
              height: 50.h,
              child: listOfPickups == null ? Center(child: LoaderFadingBlue()):
              listOfPickups!.isEmpty ?
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 10.h,),
                    Icon(Icons.question_mark, color: Colors.grey, size: 35.sp,),
                    Text(
                      "No Registered Pickup",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp),
                    )
                  ],
                ),
              ) : ListView.builder(
                  itemCount: listOfPickups!.length,
                  itemBuilder: (context, index){
                    var pickStatus = listOfPickups![index]["pickedStatus"];

                    return GestureDetector( onTap: (){

                    },
                      child: Container(
                        height: 42.h,
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
                                              Container(constraints: BoxConstraints(maxWidth: 170),
                                                child: Text("${listOfPickups![index]["state"]}",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                              ),
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
                                              onSelected: (val){
                                                switch(val){
                                                  case 1: navigateToEdit(index);
                                                  break;
                                                  case 2: showDeletePickPopup(index);
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
                                                            Icons.edit,
                                                            color: Colors.green,
                                                            size: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                            "Edit",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 15.sp,
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
                                                              color: Colors.red,
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
                                          Container(constraints: BoxConstraints(maxWidth: 170),
                                            child: Text("${listOfPickups![index]["city"]}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          ),
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
                                          Text("Description:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfPickups![index]["name"]}",  style: TextStyle(
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
                                          Container(constraints: BoxConstraints(maxWidth: 220),
                                            child: Text("${listOfPickups![index]["address"]}",
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          ),
                                        ],

                                      ),
                                      SizedBox(height: 2.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("PICK STATUS:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),

                                          if(pickStatus == "0" || pickStatus == null)
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius
                                                    .circular(10)
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 3.w,
                                                  vertical: 1.h),
                                              child: Text("PENDING", style: TextStyle(color: Colors.red,
                                                  fontWeight: FontWeight.bold),),
                                            ),
                                          )
                                          else
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius
                                                      .circular(10)
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 3.w,
                                                    vertical: 1.h),
                                                child: Text("PICKED", style: TextStyle(color: Colors.black,
                                                    fontWeight: FontWeight.bold),),
                                              ),
                                            )
                                        ],

                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ),
                    );

                  }),
            ),
            SizedBox(height: 4.h,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Drops:", style: TextStyle(color: AppColors.dashboardtextcolor,
                  fontSize: 18.sp, fontWeight: FontWeight.bold ),),
            ),
            SizedBox(height: 1.h,),
            Container(
              height: 50.h,
              child: listOfDrops == null ? Center(child: LoaderFadingBlue()):
              listOfDrops!.isEmpty ?
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 10.h,),
                    Icon(Icons.question_mark, color: Colors.grey, size: 35.sp,),
                     Text(
                      "No Registered Drop",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp),
                    )
                  ],
                ),
              ) : ListView.builder(
                  itemCount: listOfDrops!.length,
                  itemBuilder: (context, index){

                    var dropStatus = listOfDrops![index]["status"];
                    return Container(
                        height: 42.h,
                        child: Card(
                          color: Colors.grey,
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
                                              Text("Drop State:",  style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                              SizedBox(width: 4.w,),
                                              Container(constraints: BoxConstraints(maxWidth: 170),
                                                child: Text("${listOfDrops![index]["state"]}",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                              ),
                                            ],

                                          ),
                                          PopupMenuButton(
                                              color: Colors.black,
                                              shape: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15)),
                                              icon: const Center(
                                                child: Icon(
                                                  Icons.more_vert,
                                                  color: Colors.black,
                                                  size: 30,
                                                ),
                                              ),
                                              onSelected: (val){
                                                switch(val){
                                                  case 1: navigateToEditDrop(index);
                                                  break;
                                                  case 2: showPopup(index);
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
                                                            Icons.edit,
                                                            color: Colors.green,
                                                            size: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Text(
                                                            "Edit",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 15.sp,
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
                                                                color: Colors.red,
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
                                          Text("Drop City:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Container(constraints: BoxConstraints(maxWidth: 170),
                                            child: Text("${listOfDrops![index]["city"]}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          ),
                                        ],

                                      ),

                                      SizedBox(height: 1.5.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Drop date:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfDrops![index]["date"]}",  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                        ],

                                      ),

                                      SizedBox(height: 1.5.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Drop Time:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfDrops![index]["time"]}",  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                        ],

                                      ),
                                      SizedBox(height: 1.5.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Description:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfDrops![index]["name"]}",  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                        ],

                                      ),
                                      SizedBox(height: 1.5.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Drop ZipCode:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Text("${listOfDrops![index]["stateZipCode"]}",  style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                        ],

                                      ),

                                      SizedBox(height: 1.5.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Drop Address",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4.w,),
                                          Container(constraints: BoxConstraints(maxWidth: 190),
                                            child: Text("${listOfDrops![index]["address"]}",
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17.sp, fontWeight: FontWeight.bold)),
                                          ),
                                        ],

                                      ),

                                      SizedBox(height: 2.h,),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("DROP STATUS:",  style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp, fontWeight: FontWeight.bold)),

                                          if(dropStatus == "0" || dropStatus == null)
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius
                                                      .circular(10)
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 3.w,
                                                    vertical: 1.h),
                                                child: Text("PENDING", style: TextStyle(color: Colors.red,
                                                    fontWeight: FontWeight.bold),),
                                              ),
                                            )
                                          else
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius
                                                      .circular(10)
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 3.w,
                                                    vertical: 1.h),
                                                child: Text("DROPPED", style: TextStyle(color: Colors.black,
                                                    fontWeight: FontWeight.bold),),
                                              ),
                                            )

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
          ],),
        ),
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
        "loadID": loadsID.toString()
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

  void getDrop() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getDrops({
        "loadID": loadsID.toString()
      });

      if(response != null && response.statusCode == 200){
        List regDrops = response.data["data"]["docs"];

        List<Map<String,dynamic>> data = [];

        if(regDrops.length > 0){
          for(int i = 0; i < regDrops.length; i++){
            Map<String,dynamic> regDropList = regDrops[i];
            data.add(regDropList);
          }
        }
        setState(() {
          listOfDrops = data;
        });
      }
      else {

      }

    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");

    }

  }

  void showPopup(index) {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
            backgroundColor: Colors.black87,
            actions: <Widget>[SizedBox(height: 3.h,),
              Center(child: Icon(Icons.warning_amber,
                color: Colors.yellow, size: 30.sp,)),
              SizedBox(height: 5.h,),
              Center(
                child: Text(" Do you want to",
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              Center(
                child: Text(" delete this load ?",
                  style: TextStyle(
                      fontSize: 17.sp, color: Colors.white, fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.indigo[500]),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("NO", style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ],
                      )),
                  TextButton(
                    onPressed: () {
                      deleteDrop(index);
                      Navigator.of(context).pop();
                    },
                    child:
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("YES", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),

            ],
          ),
    );
  }

  void deleteDrop(index) async {
    var dropID = listOfDrops![index]["id"];
    final AuthRepo authRepo = AuthRepo();

    try{
      Response? response = await authRepo.deleteDrop({
        "id": dropID.toString()

      });

      if(response != null && response.statusCode == 200 && response.data["success"] == 200){
        showSuccessDialog();
        getDrop();

      }else{
        showErr();
        setState(() {
          errMsg = response!.data["message"];
        });

      }


    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void showDeletePickPopup(index) {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
            backgroundColor: Colors.black87,
            actions: <Widget>[SizedBox(height: 3.h,),
              Center(child: Icon(Icons.warning_amber,
                color: Colors.yellow, size: 30.sp,)),
              SizedBox(height: 5.h,),
              Center(
                child: Text(" Do you want to",
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              Center(
                child: Text(" delete this load ?",
                  style: TextStyle(
                      fontSize: 17.sp, color: Colors.white, fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.indigo[500]),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("NO", style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ],
                      )),
                  TextButton(
                    onPressed: () {
                      deletePickup(index);
                      Navigator.of(context).pop();
                    },
                    child:
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("YES", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),

            ],
          ),
    );
  }

  void deletePickup(index) async {
    var pickupID = listOfPickups![index]["id"];
    final AuthRepo authRepo = AuthRepo();

    try{
      Response? response = await authRepo.deletePickup({
        "id": pickupID.toString()
      });

      if(response != null && response.statusCode == 200 && response.data["success"] == 200){
        showSuccessDialog();
        getPickup();

      }else{
        showErr();
        setState(() {
          errMsg = response!.data["message"];
        });

      }


    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
  }

  void navigateToEdit(int index) {
    editPickID = listOfPickups![index]["id"];
    editPickLoadID = listOfPickups![index]["load_id"];
    editPickState = listOfPickups![index]["state"];
    editPickCity = listOfPickups![index]["city"];
    editPickDate = listOfPickups![index]["date"];
    editPickZip = listOfPickups![index]["stateZipCode"];
    editPickAddress = listOfPickups![index]["address"];
    editPickTime = listOfPickups![index]["time"];
    editPickName = listOfPickups![index]["name"];

    Routers.pushNamed(context, '/updatePickup');

  }

  void navigateToEditDrop(int index) {
    editDropID = listOfDrops![index]["id"];
    editDropLoadID = listOfDrops![index]["load_id"];
    editDropState = listOfDrops![index]["state"];
    editDropCity = listOfDrops![index]["city"];
    editDropDate = listOfDrops![index]["date"];
    editDropZip = listOfDrops![index]["stateZipCode"];
    editDropAddress = listOfDrops![index]["address"];
    editDropTime = listOfDrops![index]["time"];
    editDropName = listOfDrops![index]["name"];

    Routers.pushNamed(context, '/updateDrop');



  }


}
