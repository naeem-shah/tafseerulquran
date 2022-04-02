import 'dart:io';

import 'package:download_assets/download_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

class ReadingController extends GetxController {
  final PageController pageController = PageController();
  RxInt pageNo = RxInt(0);
  final Duration duration = const Duration(milliseconds: 300);
  final Curve curve = Curves.linear;

  final RxBool assetInitialized = RxBool(false);
  final DownloadAssetsController _assetsController = DownloadAssetsController();

  @override
  void onInit() async {
    super.onInit();
    await _assetsController.init();
    assetInitialized.value = true;

    if (Get.arguments.runtimeType == int) {
      Future.delayed(const Duration(milliseconds: 100), () {
        pageController.animateToPage(
          Get.arguments,
          curve: curve,
          duration: const Duration(milliseconds: 100),
        );
      });
    }
    Wakelock.enable();
  }

  @override
  void onClose() {
    super.onClose();
    Wakelock.disable();
  }

  List<File> get images {
    return List.generate(548, (index) {
      return File("${_assetsController.assetsDir}/${++index}.jpg");
    });
  }
}
