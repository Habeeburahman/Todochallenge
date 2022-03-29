import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/model/notification.dart';
import 'package:todoapp/utils/class_builder.dart';
import 'package:todoapp/views/pages/category_page.dart';
import 'package:todoapp/views/pages/edit_todo_page.dart';
import 'package:todoapp/views/pages/home_page.dart';
import 'package:todoapp/views/pages/home_page_body.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationServiceImpl().init();

  await Firebase.initializeApp();

  await AndroidAlarmManager.initialize();

  runApp(MyApp());

  // ClassBuilder.registerClasses();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
