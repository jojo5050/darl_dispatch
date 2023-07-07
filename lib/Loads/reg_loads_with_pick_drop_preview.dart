
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../AuthManagers/authRepo.dart';
import '../../../ConstantHelper/colors.dart';
import '../../../Models/global_variables.dart';
import '../../../Utils/routers.dart';


class RegLoadsWithPickDropPreview extends StatefulWidget {
  const RegLoadsWithPickDropPreview({Key? key}) : super(key: key);

  @override
  _RegLoadsWithPickDropPreviewState createState() => _RegLoadsWithPickDropPreviewState();
}

class _RegLoadsWithPickDropPreviewState extends State<RegLoadsWithPickDropPreview> {
  List<Map<String, dynamic>>? listOfLoads;

  var successMssg;

  var errMsg;

  @override
  void initState() {
    getAllLoads();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
        child: Column(
            children: [
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
                  "Registered Loads",
                  style: TextStyle(
                      color: AppColors.dashboardtextcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      decoration: TextDecoration.none),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Colors.indigo, Colors.lightBlueAccent],
                          begin: Alignment.centerLeft, end: Alignment.centerRight
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  child: PopupMenuButton(
                      color: Colors.black,
                      elevation: 20,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      icon: const Center(
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Container(
                            child: InkWell(
                              onTap: () {
                                Routers.pushNamed(context, '/nonAssignedLoadsPreview');

                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 25,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Assigned Loads",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          value: 1,
                          child: Container(
                            child: InkWell(
                              onTap: () {
                                Routers.pushNamed(context, '/nonAssignedLoadsPreview');

                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.no_transfer,
                                    color: Colors.green,
                                    size: 25,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "N.A Loads",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ]

                  ),
                ),
              ]),
              SizedBox(
                height: 2.h,
              ),

              Expanded(
                child: Container(
                    child: listOfLoads == null ? Center(child: CircularProgressIndicator(color: Colors.green,)):
                    listOfLoads!.isEmpty ?
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
                    ) : ListView.builder(
                        itemCount: listOfLoads!.length,
                        itemBuilder: (context, index){
                          return GestureDetector( onTap: (){
                            loadDetailsModal(index);
                          },
                            child: Container(
                              height: 22.h,
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3.w,),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 1.h,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${listOfLoads![index]["rateConfirmationID"]}",
                                              style: TextStyle(
                                                  color: AppColors.dashboardtextcolor,
                                                  fontSize: 19.sp,
                                                  fontWeight: FontWeight.bold),
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
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 1,
                                                    child: Container(
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          loadDetailsModal(index);
                                                        },
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.remove_red_eye_outlined,
                                                              color: Colors.green,
                                                              size: 20,
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "View",
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
                                                  PopupMenuItem(
                                                    value: 1,
                                                    child: Container(
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          getIDandPush(index);

                                                        },
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
                                                  ),
                                                  PopupMenuItem(
                                                    value: 1,
                                                    child: Container(
                                                      child: GestureDetector(
                                                        onTap: (){
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

                                                ]),
                                          ],
                                        ),

                                        SizedBox(
                                          height: 1.h,
                                        ),

                                        Row(mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Load Desc:",  style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                            SizedBox(width: 2.w,),
                                            Text("${listOfLoads![index]["loadDescription"]}",  style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp, fontWeight: FontWeight.bold)),


                                          ],

                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),

                                        Card(
                                          color: Colors.blueAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          elevation: 15,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                                            child: Column(
                                              children: [
                                                Row(mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text("Registered by:", style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                                    SizedBox(width: 2.w,),
                                                    Container(
                                                      constraints: BoxConstraints(maxWidth: 180),
                                                      child: Text("${listOfLoads![index]["registeredBy"]}",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17.sp, fontWeight: FontWeight.bold),),
                                                    )
                                                  ],),

                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 1.h,),
                                        Text("View Details", style: TextStyle(color: AppColors.dashboardtextcolor,
                                            fontSize: 14.sp, fontWeight: FontWeight.bold),)

                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ),
                          );

                        })


                ),
              )
            ]

        ),
      ),
    );
  }

  void loadDetailsModal(index) {
    showModalBottomSheet<dynamic>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        isScrollControlled: true,
        context: context, builder: (BuildContext bc)

    {

      load_ID = listOfLoads![index]["id"];
      load_desc = listOfLoads![index]["loadDescription"];

      print("load id assssssssss$load_ID");
      return Wrap(children:<Widget> [
        Container(
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(25.0),
                    topRight: const Radius.circular(25.0))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              child: Column(children:  [
                Divider(
                  color: Colors.grey,
                  height: 5,
                  thickness: 5,
                  indent: 110,
                  endIndent: 110,
                ),
                SizedBox(height: 1.h,),
                Icon(Icons.check_circle, color: Colors.green, size: 30.sp,),
                SizedBox(height: 1.h,),
                Text(
                  "${listOfLoads![index]["rateConfirmationID"]}",
                  style: TextStyle(
                      color: AppColors.dashboardtextcolor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Load Desc",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2.w,),
                    Text(
                      "${listOfLoads![index]["loadDescription"]}",
                      style: TextStyle(
                          color: AppColors.dashboardtextcolor,
                          fontSize: 17.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 1.h,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Rate",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 2.w,),
                        Text(
                          "\$"" ${listOfLoads![index]["rate"]}",
                          style: TextStyle(
                              color: AppColors.dashboardtextcolor,
                              fontSize: 17.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Weight",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 2.w,),
                        Text(
                          " ${listOfLoads![index]["weight"]}",
                          style: TextStyle(
                              color: AppColors.dashboardtextcolor,
                              fontSize: 17.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Registered By",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2.w,),
                    Text(
                      "${listOfLoads![index]["registeredBy"]}",
                      style: TextStyle(
                          color: AppColors.dashboardtextcolor,
                          fontSize: 17.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Date Registered",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2.w,),
                    Text(
                      "${listOfLoads![index]["dateRegistered"]}",
                      style: TextStyle(
                          color: AppColors.dashboardtextcolor,
                          fontSize: 17.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Broker Name: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2.w,),
                    Text(
                      "${listOfLoads![index]["brokerName"]}",
                      style: TextStyle(
                          color: AppColors.dashboardtextcolor,
                          fontSize: 17.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Broker Email ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2.w,),
                    Text(
                      "${listOfLoads![index]["brokerEmail"]}",
                      style: TextStyle(
                          color: AppColors.dashboardtextcolor,
                          fontSize: 17.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Broker Tel",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2.w,),
                    Text(
                      "${listOfLoads![index]["brokerNumber"]}",
                      style: TextStyle(
                          color: AppColors.dashboardtextcolor,
                          fontSize: 17.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Shipper Email",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2.w,),
                    Text(
                      "${listOfLoads![index]["shipperEmail"]}",
                      style: TextStyle(
                          color: AppColors.dashboardtextcolor,
                          fontSize: 17.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Shipper Address ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2.w,),
                    Container(
                      constraints: BoxConstraints(maxWidth: 250),
                      child: Text(
                        "${listOfLoads![index]["shipperAddress"]}",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            color: AppColors.dashboardtextcolor,
                            fontSize: 17.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h,),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigo[500],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide.none)),
                    onPressed: () {
                      Routers.pushNamed(context, '/addDropPickup');
                    },
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                      child: Text(
                        "Add Drop/Pickup",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(height: 2.h,),
              ],),
            ),
          ),

        ),


      ]);
    });

  }

  void getAllLoads() async {
    final AuthRepo authRepo = AuthRepo();
    try{
      Response? response = await authRepo.fetchAllRegLoads();

      if(response != null && response.statusCode == 200){
        List regLoads = response.data["data"]["docs"];

        print("print loadssssssss asssss${regLoads}");
        List<Map<String,dynamic>> data = [];

        if(regLoads.length > 0){
          for(int i = 0; i < regLoads.length; i++){
            Map<String,dynamic> regLoadList = regLoads[i];
            data.add(regLoadList);
          }
        }
        setState(() {
          listOfLoads = data;
        });

        print("printing list of loads asssssss $listOfLoads");

      }else {

      }

    }catch(e, str){
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");

    }

  }

  void deleteLoad(index) async {
    var loadID = listOfLoads![index]["id"];
    final AuthRepo authRepo = AuthRepo();

    try{
      Response? response = await authRepo.deletLoad({
        "id": loadID.toString()

      });
      print("print load id assssssssssssss $loadID ");
      print("print load id again assssssss $load_ID");

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
                child: Text(" delete this load ?",
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
                      deleteLoad(index);
                      getAllLoads();
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

  Future showSuccessDialog() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text("Load Deleted Successfuly",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  void showErr() async {
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

  void getIDandPush(int index) {
    singleLoadID = listOfLoads![index]["id"];
    Routers.pushNamed(context, '/editRegLoads');
  }
}
