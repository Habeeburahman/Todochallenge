// import 'dart:convert';
// import 'dart:math';

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:todoapp/controllers/getx_controller.dart';
// import 'package:todoapp/model/chart_spot_list.dart';
// import 'package:todoapp/model/todo_builder.dart';

// class LineChartSample extends StatefulWidget {
//   const LineChartSample({Key? key}) : super(key: key);

//   @override
//   _LineChartSampleState createState() => _LineChartSampleState();
// }

// class _LineChartSampleState extends State<LineChartSample> {
//   List<Color> gradientColors = [
//     const Color(0xff23b6e6),
//     const Color(0xff02d39a),
//   ];
//   bool showAvg = false;
//   // PointList point = PointList();

//   @override
//   Controller controller = Get.put(Controller());
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Container(
//           width: 400,
//           height: 200,
//           decoration: const BoxDecoration(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(18),
//               ),
//               color: Color(0xff232d37)),
//           child: Padding(
//             padding: const EdgeInsets.only(
//                 right: 15.0, left: 15.0, top: 15, bottom: 15),
//             child: LineChart(
//               mainData(),
//             ),
//           ),
//         ),
//         // SizedBox(
//         //   width: 60,
//         //   height: 34,
//         //   child: TextButton(
//         //     onPressed: () {
//         //       setState(() {
//         //         showAvg = !showAvg;
//         //       });
//         //     },
//         //     child: Text(
//         //       'avg',
//         //       style: TextStyle(
//         //           fontSize: 12,
//         //           color:
//         //               showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }

//   LineChartData mainData() {
//     swapAnimationCurve:
//     Curves.easeInQuint;
//     swapAnimationDuration:
//     Duration(seconds: 1);
//     return LineChartData(
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         getDrawingHorizontalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//         getDrawingVerticalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: SideTitles(showTitles: false),
//         topTitles: SideTitles(showTitles: false),
//         bottomTitles: SideTitles(
//           showTitles: false,
//           reservedSize: 22,
//           interval: 1,
//           getTextStyles: (context, value) => const TextStyle(
//               color: Color(0xff68737d),
//               fontWeight: FontWeight.bold,
//               fontSize: 16),
//           margin: 20,
//         ),
//         leftTitles: SideTitles(
//           showTitles: false,
//           interval: 1,
//           getTextStyles: (context, value) => const TextStyle(
//             color: Color(0xff67727d),
//             fontWeight: FontWeight.bold,
//             fontSize: 15,
//           ),
//           getTitles: (value) {
//             getPoint(value);
//             String result = String.fromCharCodes(PointList.myList);
//             print("result is $result");
//             return result;

//             // String result = utf8.decode(PointList.pointList);
//           },
//           reservedSize: 32,
//           margin: 12,
//         ),
//       ),
//       borderData: FlBorderData(
//           show: true,
//           border: Border.all(color: const Color(0xff37434d), width: 1)),
//       lineBarsData: [
//         LineChartBarData(
//           spots: controller.flSpotList,
//           isCurved: true,
//           colors: gradientColors,
//           barWidth: 2,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             colors:
//                 gradientColors.map((color) => color.withOpacity(0.3)).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }

// String getPoint(double value) {
//   int finalvalue = value.toInt();
//   PointList.myList.add(finalvalue);

//   int length = PointList.myList.length;

//   if (length == 3) {
//     // int sum = PointList.pointList.reduce((a, b) => a + b);
//     PointList.myList.clear();
//     return "0";
//   }

//   return PointList.myList.last.toString();
// }

// class PointList {
//   static List<int> pointList = [0];
//   static List<int> myList = [];
// }
