import 'package:flutter/material.dart';
import 'package:todoapp/constants/color_constant.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notification",
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
            ),
            ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: ColorConstant.shadowColor.withOpacity(.1),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ]),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "This is your notification so just look at your notification",
                      style: TextStyle(
                          color: ColorConstant.shadowColor, fontSize: 17),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
