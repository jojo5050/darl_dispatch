
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Chat/chat_users_list.dart';
import '../Despatcher/active_loads_preview.dart';
import '../Despatcher/despatcher_Profile_page.dart';
import '../Despatcher/despatcher_home_page.dart';
import '../Despatcher/dsp_delivered_loads_preview.dart';


class DispatcherLandingPageManager extends StatefulWidget {

  const DispatcherLandingPageManager({Key? key}) : super(key: key);

  @override
  _DispatcherLandingPageManagerState createState() => _DispatcherLandingPageManagerState();
}

class _DispatcherLandingPageManagerState extends State<DispatcherLandingPageManager> {

  int selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    DespatcherHomePage(),
    ActiveLoadPreview(),
    ChatUsersList(),
    DspLoadDeliveredPreview(),
    DispatcherProfilePage()
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


    return Scaffold(
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
        icon: Icons.local_shipping,
        iconSize: 20.0,
        title: 'Active',
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
        icon: Icons.check_circle,
        iconSize: 20.0,
        title: 'Delivered',
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
}
