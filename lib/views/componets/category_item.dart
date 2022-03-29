import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:todoapp/constants/color_constant.dart';
import 'package:todoapp/views/pages/category_page.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(
      {required this.remainingTask, required this.title, required this.color});
  String title;
  String remainingTask;
  int color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(CategoryPage(title: title, color: color));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: ColorConstant.shadowColor.withOpacity(.1),
                  blurRadius: 10,
                  spreadRadius: 3)
            ]),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              remainingTask.toUpperCase(),
              style: TextStyle(
                  color: ColorConstant.shadowColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                title,
                style: TextStyle(
                    color: ColorConstant.blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 130,
              height: 3,
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(color)),
                backgroundColor: ColorConstant.shadowColor.withOpacity(.2),
                value: .3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
