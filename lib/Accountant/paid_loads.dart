import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../AuthManagers/authRepo.dart';
import '../General/clientProfilePage.dart';

class PaidLoads extends StatefulWidget {
  const PaidLoads({Key? key}) : super(key: key);

  @override
  State<PaidLoads> createState() => _PaidLoadsState();
}

class _PaidLoadsState extends State<PaidLoads> with WidgetsBindingObserver {
  List<Map<String, dynamic>>? listOfPaidLoads;

  var errMsg;

  List<Map<String, dynamic>>? emtingData;

  bool _hasInternet = true;


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    checkInternetConnection();
    getPaidLoads();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text("Paid Loads",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),

        body: _hasInternet ?
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Container(
            child: listOfPaidLoads == null ? Center(child: CircularProgressIndicator(color: Colors.green,)):
            listOfPaidLoads!.isEmpty ?
            Center(
              child: Column(
                children: [
                  SizedBox(height: 20.h,),
                  Icon(Icons.question_mark, color: Colors.grey, size: 40.sp,),
                  const Text(
                    "No Record Found",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ],
              ),
            ):
            ListView.builder(
                itemCount: listOfPaidLoads !.length,
                itemBuilder: (context, index){
                  var pic = listOfPaidLoads ![index]["picture"];
                  var avatar = listOfPaidLoads ![index]["avatar"];
                  return GestureDetector(onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return ClientProfilePage(staffInfo: listOfPaidLoads ![index] );
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
                                      child: Text("${listOfPaidLoads![index]["name"]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.white, fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      constraints: BoxConstraints(maxWidth: 200),
                                      child: Text(
                                        "${listOfPaidLoads![index]["role"]}",
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                }),),
        ): buildNoInternetPopup());
  }

  void getPaidLoads() async {
    if (!_hasInternet) {
      return;
    }
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.getPaidLoads();

      if(response != null && response.statusCode == 200
          && response.data["status"] == 200 ){
        List loads = response.data["data"];

        List<Map<String,dynamic>> data = [];

        if(loads.length > 0){
          for(int i = 0; i < loads.length; i++){
            Map<String,dynamic> staffList = loads[i];
            data.add(staffList);
          }
        }
        setState(() {
          listOfPaidLoads = data;
        });

        print("printing list of loads asssssss $listOfPaidLoads");

      }if(response != null && response.statusCode == 404){
        setState(() {
          emtingData = response.data["data"];
        });
      }
      else {
        print("error");

      }

    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");

    }

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
