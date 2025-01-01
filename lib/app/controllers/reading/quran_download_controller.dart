import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:download_assets/download_assets.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:tafseer/app/routes/app_routes.dart';
import 'package:tafseer/app/services/preferences.dart';

class QuranDownloadController extends GetxController {
  DownloadAssetsController assetsController = DownloadAssetsController();
  final RxnDouble progress = RxnDouble();

  @override
  void onInit() async {
    super.onInit();
    await assetsController.init();
  }

  Future downloadQuran() async {
    try {
      await assetsController.clearAssets();
      await assetsController.startDownload(
        uncompressDelegates: [UnzipDelegate()],
        onProgress: (progressValue) {
          progress.value = progressValue;
          // Get.find<LocalNotificationManger>().showDownloading(101, progressValue.toInt());
        },
        onStartUnziping: () {},
        assetsUrls: [
          AssetUrl(url: Constants.quranDownloadLink, fileName: "quran.zip"),
        ],
        onDone: () {
          Get.find<Preferences>().setBool(
            key: Constants.hasDownloaded,
            value: true,
          );
          Get.offNamed(AppRoutes.indexesSimple);
        },
      );
    } on DownloadAssetsException catch (e) {
      progress.value = null;
      // Get.find<LocalNotificationManger>().dismissNotification(101);
      Get.rawSnackbar(
        message: "Unable to download. try to reinstall app Error: $e",
      );
    }
  }
}
