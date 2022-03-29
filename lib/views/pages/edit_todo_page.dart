import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todoapp/constants/color_constant.dart';
import 'package:todoapp/controllers/getx_controller.dart';

import 'package:todoapp/data/choice_chip_data.dart';
import 'package:todoapp/model/choice_chip.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:todoapp/model/todo_builder.dart';

class EditTodoPage extends StatefulWidget {
  const EditTodoPage({Key? key}) : super(key: key);

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  var color = Color(0xFFE9E9E9);
  TimeOfDay initialTime = TimeOfDay(hour: 4, minute: 0);

  CollectionReference todo = FirebaseFirestore.instance.collection("TodoList");
  CollectionReference choiceList =
      FirebaseFirestore.instance.collection("ChoiceList");
  DocumentReference ref =
      FirebaseFirestore.instance.collection('ChoiceList').doc();
  var querySnapshot = FirebaseFirestore.instance.collection("ChoiceList").get();

  // MyClass obj = MyClass();

  // dynamic list = ChoiceChips().newMethod();

  List? data = Get.arguments;
  String? todoText;
  String choiceText = '';
  String? selectedChoice;
  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection('ChoiceList').snapshots();

  @override
  void initState() {
    newMethod();
    controller.isCloseButtonVisible.value = false;
    controller.editCategoryVisible.value = false;

    // TODO: implement initState
    super.initState();
  }

  void newMethod() async {
    var querySnapshot = await choiceList.get();
    int length = querySnapshot.docs.length;
    for (int num = 0; num < length;) {
      var id = querySnapshot.docs[num]["id"];
      choiceList.doc(id).update({'isSelected': false});
      num++;
    }
  }

  Controller controller = Get.put(Controller());
  // List<ChoiceChipData> choiceChips = ChoiceChips.all;
  @override
  Widget build(BuildContext context) {
    // bool isSelected = true;
    // obj.fetchAndSetList();
    // List<ChoiceChipData> list = obj.loadedList;
    // print(list);
    ChoiceChips().getList();
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: ColorConstant.shadowColor.withOpacity(.1),
                    blurRadius: 10,
                    spreadRadius: 3)
              ]),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          // margin: EdgeInsets.only(right: 24),
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.close),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color(0xFFE9E9E9), width: 1)),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Write Your Task",
                        style: TextStyle(
                            color: Colors.black38, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      TextField(
                        controller: TextEditingController()
                          ..text = data?[0] ?? null,
                        onChanged: (value) {
                          todoText = value;
                        },
                        style: TextStyle(
                            fontSize: 23, color: ColorConstant.shadowColor),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          hintStyle: TextStyle(color: Color(0xFFDFDFDF)),
                          hintText: "Add your work",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color(0xFFB5B5B4), width: 3)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color(0xFFB5B5B4), width: 3)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select category",
                            style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg: "Please connect this with firebase");
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.delete,
                                    size: 29,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 17,
                              ),
                              InkWell(
                                onTap: () {
                                  controller.changeVisivility();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      StreamBuilder(
                          stream: stream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapShot) {
                            if (snapShot.hasError) {
                              return Text("Something error..");
                            }
                            if (snapShot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading...");
                            }
                            final choiceData = snapShot.requireData;

                            List<ChoiceChipData> some = List.generate(
                                choiceData.size,
                                (index) => ChoiceChipData(
                                    id: choiceData.docs[index]["id"],
                                    label: choiceData.docs[index]["item"],
                                    isSelected: choiceData.docs[index]
                                        ["isSelected"],
                                    textColor: Colors.white,
                                    selectedColor: Color(
                                        choiceData.docs[index]["color"])));

                            // return Wrap(
                            //   runSpacing: 3,
                            //   spacing: 3,
                            //   children: some
                            //       .map((choiceChip) => FilterChip(
                            //             checkmarkColor: Colors.red,
                            //             label: Text(choiceChip.label!),
                            //             labelStyle: TextStyle(
                            //                 fontWeight: FontWeight.bold,
                            //                 color: Colors.white),
                            //             onSelected: (isSelected) => setState(() {
                            //               some = some.map((otherChip) {
                            //                 ChoiceChipData newChip =
                            //                     otherChip.copy(isSelected: false);

                            //                 return choiceChip == newChip
                            //                     ? newChip.copy(
                            //                         isSelected: isSelected)
                            //                     : newChip;
                            //               }).toList();
                            //             }),
                            //             selected: choiceChip.isSelected!,
                            //             selectedColor: color,
                            //             // backgroundColor:
                            //             //     choiceChip.selectedColor!.withOpacity(.6),
                            //           ))
                            //       .toList(),
                            // );
                            return Wrap(
                              runSpacing: 3,
                              spacing: 6,
                              children: some.map((choiceChip) {
                                // bool condition = choiceChip.isSelected!;
                                // color = condition
                                //     ? Color(choiceChip.textColor!.value)
                                //     : Color(0xFFE9E9E9);

                                return GestureDetector(
                                  onLongPress: () {
                                    print(
                                        "You long pressed on ${choiceChip.label!}");
                                    controller.changeCloseButtonVisibility();
                                  },
                                  child: Container(
                                    child: Stack(
                                      children: [
                                        FilterChip(
                                          label: Text(choiceChip.label!),
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          onSelected: (status) async {
                                            print(
                                                "this  is id ${choiceChip.id}");
                                            var querySnapshot =
                                                await choiceList.get();
                                            int length =
                                                querySnapshot.docs.length;
                                            for (int num = 0; num < length;) {
                                              var id =
                                                  choiceData.docs[num]["id"];
                                              choiceList.doc(id).update(
                                                  {'isSelected': false});
                                              num++;
                                            }
                                            Future.delayed(
                                                Duration(milliseconds: 300),
                                                () {
                                              selectedChoice = choiceChip.label;
                                              return choiceList
                                                  .doc(choiceChip.id)
                                                  .update({
                                                'isSelected': status,
                                                "color": choiceChip
                                                    .selectedColor!.value
                                              });
                                            });
                                            color = Color(choiceChip
                                                .selectedColor!.value);
                                            // setState(() {
                                            //   // some.map((otherChip) {
                                            //   //   // print(
                                            //   //   //     'all choiceChips${choiceChips.length}');
                                            //   //   final newChip =
                                            //   //       otherChip.copy(isSelected: false);

                                            //   //   return choiceChip == newChip
                                            //   //       ? newChip.copy(
                                            //   //           isSelected: isSelected)
                                            //   //       : newChip;
                                            //   // }).toList();
                                            //   // print("this is choice chip");
                                            //   // print(choiceChip.label == "2"
                                            //   //     ? "done"
                                            //   //     : "not done");
                                            // });
                                          },
                                          selected: choiceChip.isSelected!,
                                          selectedColor:
                                              choiceChip.selectedColor,
                                          backgroundColor:
                                              choiceChip.selectedColor,
                                          checkmarkColor: Colors.white,
                                        ),
                                        Obx(
                                          () => controller
                                                  .isCloseButtonVisible.value
                                              ? Positioned(
                                                  right: 0,
                                                  top: 4,
                                                  child: Container(
                                                    // child: ElevatedButton(
                                                    //   onPressed: () {},
                                                    //   child: Text(""),
                                                    // ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        choiceList
                                                            .doc(choiceChip.id)
                                                            .delete();
                                                        controller
                                                            .isCloseButtonVisible
                                                            .value = false;
                                                      },
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                        size: 13,
                                                      ),
                                                    ),

                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        shape: BoxShape.circle),
                                                    width: 15,
                                                    height: 15,
                                                  ),
                                                )
                                              : SizedBox(
                                                  width: 1,
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }),
                      Obx(
                        () => controller.editCategoryVisible.value
                            ? Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        onChanged: (value) {
                                          choiceText = value;
                                        },
                                        style: TextStyle(fontSize: 20),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 17, vertical: 0),
                                          hintStyle: TextStyle(
                                              color: Color(0xFFE9E9E9)),
                                          hintText: "New category title",
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFB5B5B4),
                                                  width: .7)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFB5B5B4),
                                                  width: .7)),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(2),
                                      splashRadius: 20,
                                      onPressed: () {
                                        FocusManager.instance.primaryFocus!
                                            .unfocus();
                                        showDialogMethod(context);
                                      },
                                      icon: Icon(Icons.palette),
                                      color: color,
                                    ),
                                    // IconButton(
                                    //   padding: EdgeInsets.all(2),
                                    //   splashRadius: 20,
                                    //   onPressed: () {},
                                    //   icon: Icon(Icons.delete),
                                    //   color: Colors.grey,
                                    // ),
                                    ElevatedButton(
                                        onPressed: () {
                                          // choiceList
                                          //     .doc(id.toString())
                                          //     .set({"item": choiceText},
                                          //         SetOptions(merge: true))
                                          //     .then((value) => print("tag added"))
                                          //     .catchError((error) => print(
                                          //         "You got a error that is $error"));

                                          String id = Random()
                                              .nextInt(100000)
                                              .toString();

                                          // FirebaseFirestore.instance
                                          //     .collection('')
                                          //     .add({"color": color.value})
                                          //     .then((value) =>)
                                          //k
                                          //    .catchError((error) => print("your color error is $error"));

                                          choiceList.doc(id).set({
                                            'color': color.value,
                                            "item": choiceText,
                                            "isSelected": false,
                                            "id": id
                                          }, SetOptions(merge: true)).then(
                                              (value) {});

                                          controller.editCategoryVisible.value =
                                              false;

                                          // setState(() {});
                                        },
                                        child: Text("Save"))
                                  ],
                                ),
                              )
                            : Container(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Last Time",
                        style: TextStyle(
                            color: Colors.black38, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(showPicker(
                                  value: initialTime,
                                  onChange: (newTime) {
                                    setState(() {
                                      initialTime = newTime;
                                    });

                                    print("this is newtime $newTime");
                                  }));
                            },
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/colock.svg",
                                  width: 70,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  initialTime.format(context),
                                  style: TextStyle(
                                      shadows: [
                                        Shadow(
                                            offset: Offset(3.0, 3.0),
                                            color: ColorConstant.shadowColor
                                                .withOpacity(.2)),
                                      ],
                                      color: Colors.black38,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (data != null) {
            var index = data![1];
            todoText = todoText ?? data![2].docs[index]["item"];
            if (todoText != null && initialTime.format(context) != "04:00 AM") {
              Get.back();

              todo.doc(data![2].docs[index]["id"]).update({
                "item": todoText,
                "color": color.value,
                "lastTime": initialTime.format(context),
                "category": selectedChoice
              });
              // todo.doc(data![2].docs[index]["id"]).update({
              //   // color == Color(0xFFE9E9E9)
              //   //     ?
              //   // Color(data![2].docs[index]["color"])

              //   // : color
              // });
              print("this is the index ${data![1]}");
              print("updated");
            } else {
              Fluttertoast.showToast(
                msg: "Please complete..",
              );
            }
          } else {
            if (todoText != "" && initialTime.format(context) != "04:00 AM") {
              Get.back();
            } else {
              Fluttertoast.showToast(
                msg: "Please complete..",
              );
            }
            String id = Random().nextInt(10000000).toString();
            // todo.doc(id.toString()).set(
            //     {'color': color.value}, SetOptions(merge: true)).then((value) {
            //   print('added color');
            // });
            // FirebaseFirestore.instance
            //     .collection('')
            //     .add({"color": color.value})
            //     .then((value) =>)
            //     .catchError((error) => print("your color error is $error"));
            todo
                .doc(id)
                .set({
                  "item": todoText,
                  'color': color.value,
                  "id": id,
                  "lastTime": initialTime.format(context),
                  "category": selectedChoice
                }, SetOptions(merge: false))
                .then((value) => print("Item added"))
                .catchError((error) => print("You got a error that is $error"));
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }

  Widget buildColorPicker() {
    return ColorPicker(
      pickerColor: color,
      // onHsvColorChanged: (value){
      //   this.color=value as Color;
      // },
      onColorChanged: (Color value) {
        setState(() {
          this.color = Color(value.value);
        });
      },
    );
  }

  void showDialogMethod(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Color picker"),
              content: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildColorPicker(),
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Select"))
                  ],
                ),
              ),
            ));
  }
}
