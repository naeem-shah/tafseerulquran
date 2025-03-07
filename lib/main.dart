import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/assets/app_theme_info.dart';
import 'package:tafseer/app/routes/app_pages.dart';
import 'package:tafseer/app/routes/app_routes.dart';
import 'package:tafseer/app/services/services.dart';

import 'app/services/analytics_service.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Services().initServices();

      runApp(
        const MyApp(),
      );
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: customAppTheme,
      getPages: pages,
      initialRoute: AppRoutes.splash,
      transitionDuration: const Duration(milliseconds: 100),
      defaultTransition: Transition.rightToLeft,
      navigatorObservers: [
        Get.find<AnalyticsService>().getAnalyticsObserver(),
      ],
    );
  }
}
