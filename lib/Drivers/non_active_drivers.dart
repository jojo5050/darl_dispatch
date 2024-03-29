
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../General/clientProfilePage.dart';

class NonActiveDrivers extends StatefulWidget {
  const NonActiveDrivers({Key? key}) : super(key: key);

  @override
  State<NonActiveDrivers> createState() => _NonActiveDriversState();
}

class _NonActiveDriversState extends State<NonActiveDrivers> {
  List<Map<String, dynamic>>? listOfNonActiveDrivers;

  var errMsg;

  List<Map<String, dynamic>>? emtingData;


  @override
  void initState() {
    getNonActiveDrivers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text("Non Active Drivers",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Container(
            child: listOfNonActiveDrivers == null ? Center(child: CircularProgressIndicator(color: Colors.green,)):
            listOfNonActiveDrivers!.isEmpty ?
            Center(
              child: Column(
                children: [
                  Icon(Icons.question_mark, color: Colors.grey, size: 40.sp,),
                  const Text(
                    "No Record found",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ],
              ),
            ):
            ListView.builder(
                itemCount: listOfNonActiveDrivers!.length,
                itemBuilder: (context, index){
                  var pic = listOfNonActiveDrivers![index]["picture"];
                  var avatar = listOfNonActiveDrivers![index]["avatar"];
                  return GestureDetector(onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return ClientProfilePage(staffInfo: listOfNonActiveDrivers![index] );
                    }));

                  },

                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(maxWidth: 250),
                                    child: Text("${listOfNonActiveDrivers![index]["name"]}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white, fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  if(pic != null)
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.green,
                                      backgroundImage: NetworkImage(pic ?? ""),
                                    )else
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.green,
                                      backgroundImage: NetworkImage(avatar ?? ""),
                                    )
                                ],
                              ),
                              SizedBox(height: 1.h,),

                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(height: 1.h,),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Phone:",
                                        style: TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.bold, fontSize: 17.sp),),
                                      SizedBox(width: 7.w,),
                                      Container(
                                        constraints: BoxConstraints(maxWidth: 200),
                                        child: Text(
                                          "${listOfNonActiveDrivers![index]["tel" ?? ""]}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h,),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Email:",
                                        style: TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.bold, fontSize: 17.sp),),
                                      SizedBox(width: 7.w,),
                                      Container(
                                        constraints: BoxConstraints(maxWidth: 200),
                                        child: Text(
                                          "${listOfNonActiveDrivers![index]["email" ?? ""]}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                }),),
        ));
  }

  void getNonActiveDrivers() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.nonActiveDrivers();

      if(response != null && response.statusCode == 200){
        List activeDrivers = response.data["data"]["docs"];

        List<Map<String,dynamic>> data = [];

        if(activeDrivers.length > 0){
          for(int i = 0; i < activeDrivers.length; i++){
            Map<String,dynamic> drvList = activeDrivers[i];
            data.add(drvList);
          }
        }
        setState(() {
          listOfNonActiveDrivers = data;
        });

        print("printing list of loads asssssss $listOfNonActiveDrivers");

      }if(response != null && response.statusCode == 404){
        setState(() {
          emtingData = response.data["data"];
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
                color: Colors.yellow, size: 40.sp,)),
              SizedBox(height: 5.h,),
              Center(
                child: Text(" Do you want to",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 2.h,),
              Center(
                child: Text(" delete this Staff ?",
                  style: TextStyle(
                      fontSize: 18.sp, color: Colors.white
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
                      deleteStaff(index);
                      getNonActiveDrivers();
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

  void deleteStaff(index) async {
    var staffID = listOfNonActiveDrivers![index]["id"];
    final AuthRepo authRepo = AuthRepo();

    try{
      Response? response = await authRepo.deletStaff({
        "id": staffID.toString()

      });
      print("print load id assssssssssssss $staffID ");

      if(response != null && response.statusCode == 200 && response.data["success"] == 200){
        showSuccessDialog();

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

  void showSuccessDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("Driver Deleted Successfuly",
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
}
