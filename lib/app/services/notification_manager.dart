import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/services/local_notification_manager.dart';
import 'package:tafseer/app/services/preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../assets/constants.dart';

class PushNotificationsManager extends GetxService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  bool _initialized = false;

  Future<PushNotificationsManager> init() async {
    await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (_initialized) return this;
    // background
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) => notificationDecide(
        message,
      ),
    );

    // terminate
    _messaging.getInitialMessage().then(
          (RemoteMessage? message) => notificationDecide(message),
        );

    // foreground
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) =>
          notificationDecide(message, isForeground: true),
    );

    FirebaseMessaging.instance.getToken().then(
      (String? token) async {
        assert(token != null);

        Get.log("FCM Token: $token");
      },
    );

    _initialized = true;
    return this;
  }

  void notificationDecide(RemoteMessage? message, {bool isForeground = false}) {
    if (message == null) return;

    Get.log("Notification Data::: ${message.data}");

    String? lastMessageID =
        Get.find<Preferences>().getString(key: Constants.messageId);

    /// to handle duplicate messages.
    if (lastMessageID == message.messageId) {
      return;
    }
    Get.find<Preferences>().setString(
      key: Constants.messageId,
      value: message.messageId,
    );

    RemoteNotification? notification = message.notification;
    String? action = message.data[Constants.actionType];

    String title = notification?.title ?? "";
    String body = notification?.body ?? "";

    if (isForeground) {
      Get.find<LocalNotificationManger>().showNotification(
        title,
        body,
      );
      /*if (action == Constants.others) {

      } else {
        showMessage(
          title: title,
          description: body,
          action: action,
          payload: payload,
        );
      }*/
    } else {
      navigate(
        action,
        payload: message.data,
      );
    }
  }

  void showMessage({
    required String title,
    required String description,
    String? action,
    Map<String, dynamic>? payload,
  }) =>
      Get.defaultDialog(
        title: title,
        textCancel: 'DISMISS',
        textConfirm: 'VIEW',
        middleText: description,
        onConfirm: () {
          if (Get.isDialogOpen!) {
            Get.back();
          }
          navigate(action, payload: payload);
        },
      );

  void navigate(String? type, {Map<String, dynamic>? payload}) {

    /// handle newer version.
    if (type == Constants.actionTypeURL) {
      Uri? uri = Uri.tryParse(payload?[Constants.data]);
      if (uri != null) {
        launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    }
  }
}
