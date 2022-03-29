import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/getx_controller.dart';
import 'package:todoapp/model/todo_builder.dart';

class LineChartSample2 extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  final stream =
      FirebaseFirestore.instance.collection('AllList').doc("10").get();
  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      padding: EdgeInsets.all(15),
      child: FutureBuilder(
          future: stream,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapShot) {
            if (snapShot.hasError) {
              return Text("Something error..");
            }
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Text("Loading...");
            }
            final choiceData = snapShot.requireData;

            //
            return Stack(
              children: <Widget>[
                LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(show: false),
                    gridData: FlGridData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        preventCurveOverShooting: false,
                        spots: controller.flSpotList

                        // List.generate(
                        //     choiceData.size,
                        //     (index) => FlSpot(choiceData.docs[index][0],
                        //         choiceData.docs[10][index][1]))

                        //     [
                        //   FlSpot(0, 0),
                        //   FlSpot(1, 1),
                        //   FlSpot(2, 2),
                        //   FlSpot(3, 2),
                        //   FlSpot(4, 1),
                        //   FlSpot(5, 2),
                        //   FlSpot(6, 3),
                        // ]
                        //
                        ,
                        isCurved: true,
                        colors: gradientColors,
                        barWidth: 2,
                        dotData: FlDotData(
                          show: false,
                        ),
                        belowBarData: BarAreaData(
                          spotsLine: BarAreaSpotsLine(show: false),
                          show: true,
                          colors: gradientColors
                              .map((color) => color.withOpacity(0.3))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  swapAnimationCurve: Curves.easeInQuint,
                  swapAnimationDuration: Duration(seconds: 1),
                ),
              ],
            );
          }),
    );
  }

  // List<FlSpot> getStreamMethod(snapShot) {
  //   print("this is what result of a stream");
  //   List<FlSpot> listOfPint = [FlSpot(1, 1)];

  //   // snapShot.data!
  //   // .map((e) => listOfPint.add(FlSpot(e.data().values.toList()[0][0] + .0,
  //   //     e.data().values.toList()[0][1] + .0)))
  //   // .toList();
  //   print("this is new value with get");
  //   print(stream.then((value) => value.data()));

  //   print(listOfPint);
  //   return listOfPint;
  // }

  AsyncSnapshot<QuerySnapshot> newMethod(
          AsyncSnapshot<QuerySnapshot> snapShot) =>
      snapShot;
}
