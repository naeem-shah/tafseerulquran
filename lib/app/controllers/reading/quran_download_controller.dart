import 'package:download_assets/download_assets.dart';
import 'package:get/get.dart';
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
        assetsUrl: Constants.quranDownloadLink,
        onProgress: (progressValue) => progress.value = progressValue / 100,
      );

      Get.find<Preferences>().setBool(
        key: Constants.hasDownloaded,
        value: true,
      );
      Get.offNamed(AppRoutes.indexesSimple);
    } on DownloadAssetsException catch (e) {
      Get.rawSnackbar(
        message: "Unable to download. try to reinstall app Error: $e",
      );
    }
  }
}
