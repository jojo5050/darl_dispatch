
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../General/clientProfilePage.dart';

class AllDispatchers extends StatefulWidget {
  const AllDispatchers({Key? key}) : super(key: key);

  @override
  State<AllDispatchers> createState() => _AllDispatchersState();
}

class _AllDispatchersState extends State<AllDispatchers> {
  List<Map<String, dynamic>>? listOfStaffs;

  var errMsg;

  List<Map<String, dynamic>>? emtingData;


  @override
  void initState() {
    getDispatchers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text("Dispatchers",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),

        body:
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Container(
            child: listOfStaffs == null ? Center(child: CircularProgressIndicator(color: Colors.green,)):
            listOfStaffs!.isEmpty ?
            Center(
              child: Column(
                children: [
                  Icon(Icons.question_mark, color: Colors.grey, size: 40.sp,),
                  const Text(
                    "No Registered Loads Yet",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ],
              ),
            ):
            ListView.builder(
                itemCount: listOfStaffs!.length,
                itemBuilder: (context, index){
                  var pic = listOfStaffs![index]["picture"];
                  var avatar = listOfStaffs![index]["avatar"];
                  return GestureDetector(onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return ClientProfilePage(staffInfo: listOfStaffs![index] );
                    }));

                  },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.indigo[500],
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(child: Row(children: [
                                if(pic != null)
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.green,
                                    backgroundImage: NetworkImage(pic ?? ""),
                                  ) else
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.green,
                                    backgroundImage: NetworkImage(avatar ?? ""),
                                  ),
                                SizedBox(width: 3.w,),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(maxWidth: 250),
                                      child: Text("${listOfStaffs![index]["name"]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.white, fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 1.h,),
                                    Container(
                                      constraints: BoxConstraints(maxWidth: 200),
                                      child: Text(
                                        "${listOfStaffs![index]["role"]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                  ],
                                ),
                              ],),),

                             Icon(Icons.arrow_forward_ios, color: Colors.white,)



                             /* PopupMenuButton(
                                  color: Colors.black,
                                  elevation: 20,
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  icon: const Center(
                                    child: Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 1,
                                      child: Container(
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.of(context).pop();
                                            showPopup(index);
                                          },
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
                                    ),

                                  ]),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                }),),
        ));
  }

  void getDispatchers() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getAllDispatchers();

      if(response != null && response.statusCode == 200){
        List staffs = response.data["data"]["docs"];

        List<Map<String,dynamic>> data = [];

        if(staffs.length > 0){
          for(int i = 0; i < staffs.length; i++){
            Map<String,dynamic> staffList = staffs[i];
            data.add(staffList);
          }
        }
        setState(() {
          listOfStaffs = data;
        });

        print("printing list of loads asssssss $listOfStaffs ");

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
                      getDispatchers();
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
    var staffID = listOfStaffs![index]["id"];
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
        content: Text("Staff Deleted Successfuly",
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
