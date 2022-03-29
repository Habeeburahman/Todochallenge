import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/getx_controller.dart';
import 'package:todoapp/model/chart_spot_list.dart';
import 'package:todoapp/model/notification.dart';
import 'package:todoapp/views/componets/task_item.dart';

class TodoBuilder extends StatefulWidget {
  TodoBuilder({
    required this.data,
    required this.snapShot,
    this.count,
    Key? key,
  }) : super(key: key);
  int? count;
  QuerySnapshot data;
  AsyncSnapshot<QuerySnapshot> snapShot;

  @override
  State<TodoBuilder> createState() => _TodoBuilderState();
}

class _TodoBuilderState extends State<TodoBuilder> {
  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.data.size,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          // Specify a key if the Slidable is dismissible.

          key: ValueKey(widget.data.docs[index]),
          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            dismissible: DismissiblePane(onDismissed: () async {
              await FirebaseFirestore.instance
                  .runTransaction((Transaction myTransaction) async {
                myTransaction
                    .delete(widget.snapShot.data!.docs[index].reference);
              });
              controller.downListSpot();
              NotificationServiceImpl().showNotification(
                  title: widget.snapShot.data!.docs[index]["item"],
                  body: "this is fires my notification  in flutter",
                  payLoad: "play.abs");
            }),

            // All actions are defined in the children parameter.
            children: const [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: doNothing,
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              // SlidableAction(
              //   onPressed: doNothing,
              //   backgroundColor: Color(0xFF21B7CA),
              //   foregroundColor: Colors.white,
              //   icon: Icons.share,
              //   label: 'Share',
              // ),
            ],
          ),

          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            dismissible: DismissiblePane(onDismissed: () async {
              await FirebaseFirestore.instance
                  .runTransaction((Transaction myTransaction) async {
                myTransaction
                    .delete(widget.snapShot.data!.docs[index].reference);
              });
              controller.upListSpot();
            }),
            motion: ScrollMotion(),
            children: [
              // SlidableAction(
              //   // An action can be bigger than the others.
              //   // flex: 2,
              //   onPressed: doNothing,
              //   backgroundColor: Color(0xFF7BC043),
              //   foregroundColor: Colors.white,
              //   icon: Icons.archive,
              //   label: 'Archive',
              // ),
              SlidableAction(
                onPressed: doNothing,
                backgroundColor: Color(0xFF0392CF),
                foregroundColor: Colors.white,
                icon: Icons.check_circle,
                label: 'Done',
              ),
            ],
          ),

          // The child of the Slidable is what the user sees when the
          // component is not dragged.
          child: TaskItem(
            data: widget.data,
            index: index,
          ),
        );
      },
    );
  }
}

void doNothing(BuildContext context) {
  print("Pressed or tapped..");
}
