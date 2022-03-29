import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/model/todo_builder.dart';
import 'package:todoapp/views/componets/task_item.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({required this.title, required this.color});
  String title;
  int color;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> todo = FirebaseFirestore.instance
        .collection("TodoList")
        .where("category", isEqualTo: title)
        .snapshots();
    int? count;

    void getCount() async {
      QuerySnapshot choiceList =
          await FirebaseFirestore.instance.collection("ChoiceList").get();
      count = await choiceList.docs.length;
    }

    getCount();

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Category",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterChip(
                    label: Text(
                      title,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Color(color),
                    onSelected: (bool value) {},
                  ),
                  Container()
                ],
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder(
                  stream: todo,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapShot) {
                    if (snapShot.hasError) {
                      return Text("Something error..");
                    }
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return Text("Loading...");
                    }
                    final choiceData = snapShot.requireData;

                    return TodoBuilder(
                      data: choiceData,
                      snapShot: snapShot,
                      count: count,
                    );
                  }),
            ],
          )
        ],
      ),
    );
  }
}
