
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:darl_dispatch/Admin/admin_load_delivered_preview.dart';
import 'package:darl_dispatch/Despatcher/dsp_all_delivered_loads_preview.dart';
import 'package:darl_dispatch/Despatcher/dsp_delivered_loads_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Admin/admin_home.dart';
import '../Admin/admin_profile_page.dart';
import '../Admin/manage_staff.dart';
import '../Admin/manage_reports.dart';
import '../Chat/chat_users_list.dart';



class DspDeliveredLoadsManager extends StatefulWidget {
  const  DspDeliveredLoadsManager ({Key? key}) : super(key: key);

  @override
  _DspDeliveredLoadsManagerState createState() => _DspDeliveredLoadsManagerState();
}

class _DspDeliveredLoadsManagerState extends State<DspDeliveredLoadsManager>
    with SingleTickerProviderStateMixin {

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  void dispose() {
    // Dispose the TabController when the widget is disposed.
    _tabController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
          automaticallyImplyLeading: true, title: Text("Delivered Loads"),
          bottom: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'My Completed Loads'),
          Tab(text: 'All Completed Loads'),

        ],)),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          DspLoadDeliveredPreview(),
        DspAllLoadDeliveredPreview(),
      ],)
    );
  }

}
