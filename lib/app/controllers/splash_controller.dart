import 'package:get/get.dart';
import 'package:tafseer/app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.quranHome);
    });
  }
}
