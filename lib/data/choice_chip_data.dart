import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/model/choice_chip.dart';

class ChoiceChips extends GetxController {
  getList() {
    FirebaseFirestore.instance
        .collection('ChoiceList')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (all.length != querySnapshot.size) {
          all.add(ChoiceChipData(
              label: doc["item"],
              isSelected: false,
              textColor: Colors.black,
              selectedColor: Color(doc["color"])));

          print("this is item ${doc["item"]}");
        } else {
          return;
        }
      });
    });
  }

  static List<ChoiceChipData> all = <ChoiceChipData>[].obs;
}
