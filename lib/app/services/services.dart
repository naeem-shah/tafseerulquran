import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:tafseer/app/controllers/index/index_data_controller.dart';
import 'package:tafseer/app/controllers/reading/quran_download_controller.dart';
import 'package:tafseer/app/controllers/settings_bottom_sheet_controller.dart';
import 'package:tafseer/app/services/database_manager.dart';
import 'package:tafseer/app/services/local_notification_manager.dart';
import 'package:tafseer/app/services/notification_manager.dart';
import 'package:tafseer/app/services/preferences.dart';

import '../../firebase_options.dart';
import 'analytics_service.dart';

class Services {
  static final Services _instance = Services._();

  factory Services() => _instance;

  Services._();

  Future<void> initServices() async {
    await Firebase.initializeApp(
      name: "tafseer (android)",
      options: DefaultFirebaseOptions.currentPlatform,
    );

    Get.lazyPut(() => AnalyticsService());

    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    await Get.putAsync<Preferences>(
      () => Preferences().initPreferences(),
    );

    Get.lazyPut(
      () => SettingsBottomSheetController(),
      fenix: true,
    );

    await Get.putAsync<DatabaseManager>(
      () => DatabaseManager().initializeDatabase(),
    );
    Get.put<IndexDataController>(
      IndexDataController(),
      permanent: true,
    );
    await Get.find<Preferences>().setBool(
      key: Constants.hasDownloaded,
      value: false,
    );
    final bool hasDownloaded = Get.find<Preferences>().getBool(
          key: Constants.hasDownloaded,
        ) ??
        false;

    if (!hasDownloaded) {
      Get.put(
        QuranDownloadController(),
        tag: Constants.hasDownloaded,
        permanent: true,
      );
    }

    await Get.putAsync(
      () => LocalNotificationManger().initialize(),
      permanent: true,
    );

    await Get.putAsync(
      () => PushNotificationsManager().init(),
      permanent: true,
    );
  }
}
