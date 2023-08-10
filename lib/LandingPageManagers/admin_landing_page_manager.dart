
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Admin/admin_home.dart';
import '../Admin/admin_profile_page.dart';
import '../Admin/manage_staff.dart';
import '../Admin/manage_reports.dart';
import '../Chat/chat_users_list.dart';
import '../Utils/routers.dart';



class AdminLandingPageManager extends StatefulWidget {
  const AdminLandingPageManager({Key? key}) : super(key: key);

  @override
  _AdminLandingPageManagerState createState() => _AdminLandingPageManagerState();
}

class _AdminLandingPageManagerState extends State<AdminLandingPageManager> {

  int selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    AdminHomePage(),
    AdminManageStaff(),
    ChatUsersList(),
    ManageReports(),
    AdminProfilePage()
  ];


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    double barHeight;
    double barHeightWithNotch = 67;
    double arcHeightWithNotch = 67;

    if (size.height > 700) {
      barHeight = 62;
    } else {
      barHeight = size.height * 0.1;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    }


    return WillPopScope(
      onWillPop: _onWillPop,

      child: Scaffold(
        body: _pages[selectedIndex],

        bottomNavigationBar: CircleBottomNavigationBar(
          initialSelection: selectedIndex,
          barHeight: viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
          arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
          itemTextOff: viewPadding.bottom > 0 ? 0 : 1,
          itemTextOn: viewPadding.bottom > 0 ? 0 : 1,
          circleOutline: 15.0,
          shadowAllowance: 0.0,
          circleSize: 50.0,
          blurShadowRadius: 50.0,
          circleColor: Colors.white,
          activeIconColor: Colors.blueAccent,
          inactiveIconColor: Colors.black,
          textColor: Colors.black,
          hasElevationShadows: true,

          barBackgroundColor: Colors.white,
          tabs: getTabsData(),
          onTabChangedListener: (index) => setState(() => selectedIndex = index),
        ),
      ),
    );
  }

  List<TabData> getTabsData() {
    return [
      TabData(
        icon: Icons.home,
        iconSize: 20.0,
        title: 'Home',
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
      ),
      TabData(
        icon: Icons.group,
        iconSize: 20.0,
        title: 'Staff',
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
      ),
      TabData(
        icon: Icons.message,
        iconSize: 20.0,
        title: 'Chat',
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
      ),
      TabData(
        icon: Icons.menu_book,
        iconSize: 20.0,
        title: 'Report',
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
      ),
      TabData(
        icon: Icons.person,
        iconSize: 20.0,
        title: 'Profile',
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
      ),
    ];
  }


  Future<bool> _onWillPop() async {
    if (selectedIndex != 0) {
      setState(() {
        selectedIndex = 0;
      });
      Routers.replaceAllWithName(context, '/admin_landing_manager');
    }else{
      showPopUp();
    }
    return true;
  }

  void showPopUp() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            //  title: new Text('Are you sure?'),
            content: new Text('Do you want to exit the App'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  TextButton(
                    onPressed: () => exitApp(),
                    child: new Text('Yes'),
                  ),
                ],
              ),
            ],
          ),
    );
  }

  exitApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }
}
