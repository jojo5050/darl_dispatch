import 'package:darl_dispatch/GoogleMapManagers/device_location_page.dart';
import 'package:darl_dispatch/Utils/form_validators.dart';
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DeviceTrackingInputFieldPage extends StatefulWidget {
  const DeviceTrackingInputFieldPage({Key? key}) : super(key: key);

  @override
  State<DeviceTrackingInputFieldPage> createState() => _DeviceTrackingInputFieldPageState();
}

class _DeviceTrackingInputFieldPageState extends State<DeviceTrackingInputFieldPage>
    with FormValidators {

  TextEditingController _userIdController = TextEditingController();
  final GlobalKey<FormState> trackingKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
        child: SingleChildScrollView(
          child: Form(
            key: trackingKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back_ios_new)),
                ),
                SizedBox(height: 3.h,),
                TextFormField(
                  style: TextStyle(color: Colors.black, fontSize: 18.sp),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(
                          10.0,
                        ),
                        borderSide:
                        BorderSide(width: 2, color: Colors.blue),
                      ),
                      labelText: "Enter Tracking ID"),
                     controller: _userIdController,
                     validator: validateTrckingId,
                ),
                SizedBox(height: 50.h,),


                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide.none)),
                    onPressed: (){
                      if(trackingKey.currentState!.validate()){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeviceLocationPage(trackingId: _userIdController.text),
                          ),
                        );
                      }
                      return;
                    },

                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 2.h),
                      child: Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, fontSize: 17.sp),
                      ),
                    )),


              ],

            ),
          ),
        ),
      ),
    );
  }

  void _trackUserLocation() {
  }
}
