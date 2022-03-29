import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:todoapp/constants/color_constant.dart';

import 'package:todoapp/model/settins_item.dart';

class SettingsPage extends KFDrawerContent {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool isUpdateAlways = false;
  KFDrawerController controller2 = Get.find();

  @override
  Widget build(BuildContext context) {
    KFDrawerContent? currentPage = controller2.page;
    print("now page is $currentPage");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.red,
            ),
            onPressed: widget.onMenuPressed),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.grey.withOpacity(.76),
                    size: 100,
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              SettingsItem(
                text: Text(
                  "Enable Dark Mode",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                secondWidget: Switch(
                    activeColor: ColorConstant.fabColor,
                    value: isDarkMode,
                    onChanged: (newValue) {
                      setState(() {
                        isDarkMode = newValue;
                      });
                    }),
              ),
              SettingsItem(
                text: Text(
                  "Always upload datas to cloud",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                secondWidget: Switch(
                    activeColor: ColorConstant.fabColor,
                    value: isUpdateAlways,
                    onChanged: (newValue) {
                      setState(() {
                        isUpdateAlways = newValue;
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
