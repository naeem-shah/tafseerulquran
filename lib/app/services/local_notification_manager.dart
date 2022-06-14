import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotificationManger extends GetxService {
  static late FlutterLocalNotificationsPlugin localNotification;

  Future<LocalNotificationManger> initialize() async {
    localNotification = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    const MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS,
    );

    await localNotification.initialize(
      initializationSettings,
    );
    return this;
  }

  Future showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'Updates',
      'Updates',
      channelDescription: 'Updates about application',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
    );
    await localNotification.show(
      Random().nextInt(100),
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
