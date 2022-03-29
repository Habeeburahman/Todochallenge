import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:todoapp/constants/color_constant.dart';
import 'package:todoapp/model/line_chart.dart';

import 'package:todoapp/model/settins_item.dart';
import 'package:todoapp/views/componets/line_chart_full.dart';

class AnalysePage extends KFDrawerContent {
  @override
  _AnalysePageState createState() => _AnalysePageState();
}

class _AnalysePageState extends State<AnalysePage> {
  bool isDarkMode = false;
  bool isUpdateAlways = false;

  KFDrawerController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    KFDrawerContent? currentPage = controller.page;
    print("now page is $currentPage");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Analyse",
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
              SizedBox(height: 400, width: 400, child: LineChartSample2())
            ],
          ),
        ),
      ),
    );
  }
}
