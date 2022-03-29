import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:todoapp/constants/color_constant.dart';
import 'package:todoapp/controllers/getx_controller.dart';
import 'package:todoapp/model/line_chart.dart';
import 'package:todoapp/model/todo_builder.dart';
import 'package:todoapp/utils/class_builder.dart';
import 'package:todoapp/views/componets/category_item.dart';
import 'package:todoapp/views/componets/task_item.dart';
import 'package:todoapp/views/pages/analyse_page.dart';
import 'package:todoapp/views/pages/edit_todo_page.dart';
import 'package:todoapp/views/pages/home_page_body.dart';
import 'package:todoapp/views/pages/line_chart_page.dart';
import 'package:todoapp/views/pages/settings_page.dart';

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late KFDrawerController controller2 =
      Get.put(KFDrawerController(initialPage: HomePageBody()));
  Controller getxController = Get.put(Controller());

  @override
  void initState() {
    controller2 = KFDrawerController(
      initialPage: HomePageBody(),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('Home', style: TextStyle(color: getColor("HomePageBody"))),
          icon: Icon(Icons.apps, color: Colors.white),
          page: HomePageBody(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Analytics',
            style: TextStyle(color: getColor("AnalysePage")),
          ),
          icon: Icon(Icons.bar_chart, color: Colors.white),
          page: AnalysePage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Settings',
            style: TextStyle(color: getColor("SettingsPage")),
          ),
          icon: Icon(Icons.settings, color: Colors.white),
          page: SettingsPage(),
          // onPressed: () {
          //   controller.open;
          // },
        ),
        KFDrawerItem(
          text: Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.account_circle,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
    );

    // print(getxController.flSpotList);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: KFDrawer(
        controller: controller2,
        footer: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: LineChartSample2(),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Good",
                style: TextStyle(color: Colors.greenAccent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Consistency",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        borderRadius: 30.0,
        shadowBorderRadius: 30.0,
        menuPadding: EdgeInsets.all(20.0),
        scrollable: true,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
              // padding: EdgeInsets.symmetric(horizontal: 16.0),
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  // ElevatedButton(
                  //     onPressed: widget.onMenuPressed,
                  //     child: Text(
                  //       'show',
                  //       style: TextStyle(color: Colors.white),
                  //     )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.pink, width: 3)),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage(
                              "assets/images/imgbin-computer-icons-portable-network-graphics-avatar-icon-design-avatar-DsZ54Du30hTrKfxBG5PbwvzgE.jpg"),
                        ),
                      ),
                      SizedBox(
                        width: 45,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller2.close!();
                        }
                        // Get.to(controller.items.first.page);
                        // controller.close;
                        // print("some ..");
                        ,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color(0xFF9D9AB4), width: 1)),
                          child: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // ElevatedButton(
                  //     onPressed: widget.onMenuPressed,
                  //     child: Text(
                  //       'get',
                  //       style: TextStyle(color: Colors.white),
                  //     )),
                  Container(
                    width: 100,
                    child: Text(
                      "Habeeb Rahman",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                ],
              )),
        ),
        decoration: BoxDecoration(color: Color(0xFF020417)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstant.fabColor,
        onPressed: () {
          const int helloAlarmID = 0;
          AndroidAlarmManager.periodic(
            const Duration(seconds: 1),
            helloAlarmID,
            printHello,
            exact: true,
          );
          // getxController.getData();
          Get.to(EditTodoPage());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Color getColor(String page) {
    Color color = Colors.white;
    String currentPage = controller2.page.toString();
    print("now page is $currentPage");
    if (page == currentPage) {
      color = Colors.red;
    } else {
      color = Colors.white;
    }
    return color;
  }
}
