import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/constants/color_constant.dart';
import 'package:todoapp/views/pages/edit_todo_page.dart';

class TaskItem extends StatelessWidget {
  TaskItem({
    required this.data,
    required this.index,
    Key? key,
  }) : super(key: key);
  QuerySnapshot data;
  int index;
  // Color color= data.docs[index]["color"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(" item pressed");
        Get.to(
          EditTodoPage(),
          arguments: [data.docs[index]["item"] ?? " ", index, data],
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        padding: EdgeInsets.only(left: 20, top: 15, bottom: 7, right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: ColorConstant.shadowColor.withOpacity(.1),
                  blurRadius: 1,
                  spreadRadius: 1)
            ]),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: ScrollPhysics(),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Color(data.docs[index]["color"]), width: 2)),
                    // child: Icon(
                    //   Icons.check,
                    //   size: 15,
                    //   color: Colors.green,
                    // ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .62,
                    child: Text(
                      data.docs[index]["item"],
                      style: TextStyle(
                          color: Colors.black.withOpacity(.7), fontSize: 18),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 2),
                child: Text(
                  data.docs[index]["lastTime"],
                  style: TextStyle(
                      color: ColorConstant.shadowColor.withOpacity(.7)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
