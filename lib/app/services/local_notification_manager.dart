import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotificationManger extends GetxService {
  static late FlutterLocalNotificationsPlugin localNotification;

  Future<LocalNotificationManger> initialize() async {
    localNotification = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
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

  Future<void> showDownloading(int id, int progress) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Quran downloading', 'Quran downloading',
        channelDescription: 'Quran downloading',
        channelShowBadge: false,
        importance: Importance.max,
        priority: Priority.high,
        onlyAlertOnce: true,
        showProgress: true,
        progress: progress,
        maxProgress: 100);
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    localNotification.show(
      id,
      "Tafseer ul quran",
      "16 Line Quran downloading",
      platformChannelSpecifics,
    );
  }

  Future<void> dismissNotification(int id) async {
    await localNotification.cancel(id);
  }
}
