import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/controllers/index/index_data_controller.dart';
import 'package:tafseer/app/models/index_model.dart';

import '../routes/app_routes.dart';

class JumpToAyahController extends GetxController {

  final Rx<IndexModel> selectedIndex = Rx<IndexModel>(Get
      .find<IndexDataController>()
      .surahs
      .first);
  int ayatNumber = 0;

  final formKey = GlobalKey<FormState>();


  void jump() {
    if (!formKey.currentState!.validate()) return;
    Get.back();
    Get.toNamed(
      AppRoutes.ayat,
      arguments: {
        "isRecent": true,
        "scroll_position": ayatNumber,
        "surah_id": selectedIndex.value.id,
      },
    );
  }
}