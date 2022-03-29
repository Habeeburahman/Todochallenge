import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:todoapp/model/chart_spot_list.dart';

class Controller extends GetxController {
  List<FlSpot> flSpotList = <FlSpot>[].obs;
  final allList = FirebaseFirestore.instance.collection("AllList").snapshots();

  final allList2 = FirebaseFirestore.instance.collection("AllList");

  RxBool isHidden = false.obs;
  RxBool editCategoryVisible = false.obs;
  RxString searchText = "".obs;
  RxBool isCloseButtonVisible = false.obs;

  int count = 0;
  void changeVisivility() {
    editCategoryVisible.value = !editCategoryVisible.value;
  }

  void changeCloseButtonVisibility() {
    isCloseButtonVisible.value = !isCloseButtonVisible.value;
  }

  void upListSpot() {
    // print("this is list$flSpotList");
    if (flSpotList.isEmpty) {
      allList2
          .doc(count.toString())
          .set(
            {
              "point 1": [1.0, 1.0]
            },
          )
          .then((value) => print("Item added"))
          .catchError((error) => print("You got a error that is $error"));
      count++;
    } else {
      double first = flSpotList.last.x + 1;
      double second = flSpotList.last.y + 1;
      // flSpotList.add(FlSpot(first, second));
      allList2
          .doc(count.toString())
          .set(
            ({
              "point $first": [
                first,
                second,
              ],
            }),
          )
          .then((value) => print("Item added"))
          .catchError((error) => print("You got a error that is $error"));

      // allList2
      //     .doc("10")
      //     .update(
      //       {
      //         "point$first": [first, second]
      //       },
      //     )
      //     .then((value) => print("Item added"))
      //     .catchError((error) => print("You got a error that is $error"));
      count++;
    }
    print(flSpotList);
  }

  void downListSpot() {
    // double first = flSpotList.isEmpty ? 0 : flSpotList.last.x;
    // double second = flSpotList.isEmpty ? 0 : flSpotList.last.y;
    if (flSpotList.isEmpty ||
        flSpotList.last == FlSpot(flSpotList.last.x, 1.0)) {
      return;
    } else {
      double first = flSpotList.last.x + 2;
      double second = flSpotList.last.y - 1;
      // print(flSpotList.last);
      // flSpotList.add(FlSpot(first, second));
      allList2
          .doc(count.toString())
          .set(
            {
              "point$first": [first, second]
            },
          )
          .then((value) => print("Item added"))
          .catchError((error) => print("You got a error that is $error"));
      // print("after${flSpotList.last}");

      // } else {
      //   return;
      // }
      count++;
    }
    print(flSpotList);
  }

  void getData() {
    flSpotList = [];
    // StreamBuilder(
    //     stream: allList,
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
    //       if (snapShot.hasError) {
    //         return Text("Something error..");
    //       }
    //       if (snapShot.connectionState == ConnectionState.waiting) {
    //         return Text("Loading...");
    //       }
    //       final allListData = snapShot.requireData;

    //       List<FlSpot> some =
    //           List.generate(allListData.size, (index) => FlSpot(0, 0) ,

    //           );

    //     });
    // flSpotList = [];
    // print(flSpotList);
    FirebaseFirestore.instance
        .collection("AllList")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print("this is element${element.data().values.toList()}");
        flSpotList.add(
          FlSpot(element.data().values.toList()[0][0],
              element.data().values.toList()[0][1]),
        );

        //     // flSpotList.add(FlSpot(doc.data().values.first, doc.data().values.last));
        //     print(flSpotList);
        //   });
        // });
      });

      // getData() async {
      //   await allList2
      //       .doc("10")
      //       .get()
      //       .then((value) => List.from(value.get("poi")).forEach((element) {
      //             FlSpot data = FlSpot(element, element);
      //             flSpotList.add(data);
      //           }));
      // }
    });
  }
}
