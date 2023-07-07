//import 'package:clipboard/clipboard.dart';
import 'package:clipboard/clipboard.dart';
import 'package:darl_dispatch/ConstantHelper/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';

class UsersFromFbDetails extends StatefulWidget {
  const UsersFromFbDetails({Key? key, required this.arguments})
      : super(key: key);

  final UsersDetails arguments;

  @override
  State<UsersFromFbDetails> createState() => _UsersFromFbDetailsState();
}

class UsersDetails {
  final String userid;
  final String userAvatar;
  final String userName;

  UsersDetails(
      {required this.userid, required this.userAvatar, required this.userName});
}

class _UsersFromFbDetailsState extends State<UsersFromFbDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios_new)),
          ),
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(widget.arguments.userAvatar),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            widget.arguments.userName ?? "",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17.sp),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Tracking ID:",
            style: TextStyle(color: AppColors.dashboardtextcolor, fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            widget.arguments.userid ?? "",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          GestureDetector(onTap: (){
             if(widget.arguments.userid.isNotEmpty){
                FlutterClipboard.copy(widget.arguments.userid);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('copied to clipboard')),
                );
             }
          },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.copy,
                  color: Colors.black,
                ),
                Text(
                  "Copy ID",
                  style: TextStyle(color: AppColors.dashboardtextcolor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
