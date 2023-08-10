import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../General/clientProfilePage.dart';
import '../Utils/loaderFadingBlue.dart';

class AllStaffs extends StatefulWidget {
  const AllStaffs({Key? key}) : super(key: key);

  @override
  State<AllStaffs> createState() => _AllStaffsState();
}

class _AllStaffsState extends State<AllStaffs> with WidgetsBindingObserver {
  List<Map<String, dynamic>>? listOfStaffs;

  var errMsg;

  List<Map<String, dynamic>>? emtingData;

  bool _hasInternet = true;


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    checkInternetConnection();
    getAllUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Staffs",
          style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold, fontSize: 17.sp),),),

      body: _hasInternet ?
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Container(
            child: listOfStaffs == null ? Center(child: LoaderFadingBlue()):
            listOfStaffs!.isEmpty ?
            Center(
              child: Column(
                children: [
                  Icon(Icons.question_mark, color: Colors.grey, size: 30.sp,),
                   Text(
                    "No Registered Staff",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp),
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
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
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
                                    style: TextStyle(color: Colors.white, fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                ),
                                 ),
                                SizedBox(height: 0.5.h,),
                                Container(
                                  constraints: BoxConstraints(maxWidth: 200),
                                  child: Text(
                                    "${listOfStaffs![index]["role"]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),

                              ],
                            ),
                          ],),),

                          PopupMenuButton(
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
                              onSelected: (val){
                                switch(val){
                                  case 1: showPopup(index);
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
                    ),
                  ),
                ),
              );

            }),),
      ): buildNoInternetPopup());
  }

  void getAllUsers() async {
    if (!_hasInternet) {
      return;
    }
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getAllUsers();

      if(response != null && response.statusCode == 200 && response.data["status"] == "success" ){
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
                color: Colors.yellow, size: 35.sp,)),
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
                child: Text(" delete this Staff ?",
                  style: TextStyle(
                      fontSize: 17.sp, color: Colors.white,
                      fontWeight: FontWeight.bold
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
        getAllUsers();

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

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _hasInternet = false;
      });
    } else {
      setState(() {
        _hasInternet = true;
      });
    }
  }

  Widget buildNoInternetPopup() {
    return Center(
      child: Container(
        height: 23.h,
        child: Dialog(
          backgroundColor: Colors.grey,
          child: Column(
            children: [
              SizedBox(height: 2.h,),
              const Center(child: Text("No Internet access Detected",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
              SizedBox(height: 1.h,),
              const Center(child: Text("Re-Connect and try again",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
              //  SizedBox(height: 2.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        exitApp();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 5.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Exit", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),),
                        ),
                      )),

                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/splash_screen');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 5.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Reload", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),),
                        ),
                      )),

                ],)
            ],
          ),
        ),
      ),
    );

  }

  exitApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }
}
