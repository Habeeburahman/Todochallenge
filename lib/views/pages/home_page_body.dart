import 'dart:convert';
import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:todoapp/constants/color_constant.dart';
import 'package:todoapp/controllers/getx_controller.dart';
import 'package:todoapp/model/todo_builder.dart';
import 'package:todoapp/views/componets/category_item.dart';
import 'package:todoapp/views/componets/task_item.dart';
import 'package:todoapp/views/pages/notification_page.dart';
import 'package:animated_search_bar/animated_search_bar.dart';

class HomePageBody extends KFDrawerContent {
  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

Controller getxController = Get.put(Controller());

class _HomePageBodyState extends State<HomePageBody> {
  @override
  void initState() {
    getxController.getData();
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg:
            "Work in progress.......!!\n some features wouldn't work properly");
    // TODO: implement initState
    super.initState();
  }

  void printHello() {
    final DateTime now = DateTime.now();
    final int isolateId = Isolate.current.hashCode;
    print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
  }

  @override
  Widget build(BuildContext context) {
    // getxController.getData;
    final Stream<QuerySnapshot> stream =
        FirebaseFirestore.instance.collection('ChoiceList').snapshots();
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.red,
            ),
            onPressed: () {
              const int helloAlarmID = 0;
              AndroidAlarmManager.periodic(
                const Duration(seconds: 1),
                helloAlarmID,
                printHello,
                exact: true,
              );
              getxController.getData();
              // getxController.getData();
              widget.onMenuPressed!();
            }),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          SizedBox(
            width: 300,
            child: AnimatedSearchBar(
                label: "Search Something Here",
                labelStyle: TextStyle(fontSize: 9),
                searchStyle: TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                closeIcon: Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
                searchIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                searchDecoration: InputDecoration(
                  // filled: true,
                  hintText: "Search",
                  focusedBorder: InputBorder.none,
                  alignLabelWithHint: true,
                  // fillColor: ColorConstant.shadowColor,
                  // focusColor: ColorConstant.shadowColor,
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  print("value on Change");
                  // getxController.isHidden.value = true;
                  getxController.searchText.value = value;
                }),
          )

          // IconButton(
          //     icon: Icon(
          //       Icons.search,
          //       color: ColorConstant.shadowColor,
          //     ),
          //     onPressed: () {}),

          // AnimSearchBar(
          //     color: Colors.red,
          //     suffixIcon: Icon(
          //       Icons.search,
          //       color: Colors.grey,
          //     ),
          //     width: 300,
          //     textController: controller,
          //     closeSearchOnSuffixTap: true,
          //     onSuffixTap: () {
          //       setState(() {});
          //     }),

          ,
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: ColorConstant.shadowColor,
            ),
            onPressed: () {
              Get.to(NotificationPage());
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Obx(
                  () => getxController.isHidden.value
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                "What's up,User!",
                                style: TextStyle(
                                    color: ColorConstant.blackColor,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                "Categories".toUpperCase(),
                                style: TextStyle(
                                    color: ColorConstant.shadowColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 400,
                                height: 134,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: StreamBuilder(
                                          stream: stream,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapShot) {
                                            if (snapShot.hasError) {
                                              return Text("Something error..");
                                            }
                                            if (snapShot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Text("Loading...");
                                            }
                                            final choiceData =
                                                snapShot.requireData;
                                            return ListView.builder(
                                                itemCount: choiceData.size,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        index) {
                                                  return CategoryItem(
                                                    color:
                                                        choiceData.docs[index]
                                                                ["color"] ??
                                                            "sonthins",
                                                    title:
                                                        choiceData.docs[index]
                                                                ["item"] ??
                                                            "Not found",
                                                    remainingTask: "40 tasks",
                                                  );
                                                });
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "today's Tasks".toUpperCase(),
                  style: TextStyle(
                      color: ColorConstant.shadowColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
                SizedBox(
                  height: 20,
                ),
              ]),
              Obx(() {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('TodoList')
                        .orderBy(
                          "lastTime",
                        )
                        .startAt([getxController.searchText.value]).endAt([
                      getxController.searchText.value != null
                          ? getxController.searchText.value + '\uf8ff'
                          : getxController.searchText.value
                    ])
                        // .where("item",
                        //     isEqualTo:
                        //         searchText != null && searchText!.isEmpty ? null : searchText)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapShot) {
                      if (snapShot.hasError) {
                        return Text("Something error..");
                      }
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return Text("Loading...");
                      }
                      final data = snapShot.requireData;
                      return TodoBuilder(
                        snapShot: snapShot,
                        data: data,
                      );
                    });
              })
            ],
          )
        ],
      ),
    );
  }
}
