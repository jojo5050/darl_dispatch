import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:darl_dispatch/Accountant/accountant_Profile_Page.dart';
import 'package:darl_dispatch/Accountant/accountant_home.dart';
import 'package:darl_dispatch/Utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Accountant/manage_report.dart';
import '../Chat/chat_users_list.dart';

class AccountantLandingPageManager extends StatefulWidget {
  @override
  _AccountantLandingPageManagerState createState() =>
      _AccountantLandingPageManagerState();
}

class _AccountantLandingPageManagerState
    extends State<AccountantLandingPageManager> {
  int selectedIndex = 0;


  static const List<Widget> _pages = <Widget>[
    AccountantHomePage(),
    ChatUsersList(),
    ManageReport(),
    AccountantProfilePage()
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


  Future<bool> _onWillPop() async {
    if (selectedIndex != 0) {
      setState(() {
        selectedIndex = 0;
      });
      Routers.replaceAllWithName(context, '/accountant_landing_manager');
    }else{
      showPopUp();
    }
    return true;
  }

  exitApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
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
}

List<TabData> getTabsData() {
  return [
    TabData(
      icon: Icons.home,
      iconSize: 20.0,
      title: 'Home',
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.message,
      iconSize: 20.0,
      title: 'Chat',
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.menu_book,
      iconSize: 20.0,
      title: 'Report',
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.person,
      iconSize: 20.0,
      title: 'Profile',
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
    ),
  ];
}
