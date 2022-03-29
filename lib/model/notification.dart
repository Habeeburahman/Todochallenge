import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const String channel_id = "123";

class NotificationServiceImpl {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future showNotification(
          {int id = 0, String? title, String? body, String? payLoad}) async =>
      flutterLocalNotificationsPlugin.show(
          id,
          title,
          body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  channel_id, title, 'To remind you about upcoming birthdays')),
          payload: payLoad);
}
