import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/assets/app_theme_info.dart';
import 'package:tafseer/app/routes/app_pages.dart';
import 'package:tafseer/app/routes/app_routes.dart';
import 'package:tafseer/app/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Services().initServices();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: customAppTheme,
      getPages: pages,
      initialRoute: AppRoutes.splash,
      transitionDuration: const Duration(milliseconds: 300),
      defaultTransition: Transition.rightToLeft,
    ),
  );
}
