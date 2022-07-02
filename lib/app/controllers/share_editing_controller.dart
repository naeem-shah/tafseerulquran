import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:tafseer/app/models/ayat_model.dart';
import 'package:tafseer/app/models/index_model.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tafseer/app/services/database_manager.dart';

class ShareEditingController extends GetxController {
  final RxBool quranSelected = RxBool(false);
  final RxBool translationSelected = RxBool(false);
  final RxBool explanationSelected = RxBool(false);

  final RxString quran = RxString("");
  final RxString translation = RxString("");
  final RxString reference = RxString("");
  final RxnString explanation = RxnString();

  final RxString backgroundImage =
      RxString("assets/images/backgrounds/background.jpg");

  final RxInt quranFont = RxInt(18);
  final RxInt translationFont = RxInt(18);
  final RxInt explanationFont = RxInt(16);

  final RxList<IndexModel> indexes = RxList<IndexModel>();
  ScreenshotController screenshotController = ScreenshotController();

  late final AyatModel _ayatModel;

  @override
  void onInit() {
    super.onInit();
    getIndexes();
  }

  Future getIndexes() async {
    final items =
        await Get.find<DatabaseManager>().getIndexes(Constants.surahTable);
    indexes.assignAll(items);

    if (Get.arguments != null) {
      _ayatModel = Get.arguments;
      quran.value = _ayatModel.ayat;
      translation.value = _ayatModel.translation;
      reference.value =
          "${indexes[_ayatModel.surahId - 1].name}: ${_ayatModel.ayatNo}";
    }
  }

  Future<Uint8List?> captureImage() async {
    return await screenshotController.capture(
      pixelRatio: Get.pixelRatio,
      delay: const Duration(
        milliseconds: 10,
      ),
    );
  }

  Future onShare() async {
    Uint8List? image = await captureImage();

    if (image != null) {
      final directory = (await getApplicationDocumentsDirectory()).path;
      final imagePath = await File('$directory/${_ayatModel.id}.png').create();
      await imagePath.writeAsBytes(image);

      Share.shareFiles([imagePath.path]);
    }
  }

  Future onSave() async {
    Uint8List? image = await captureImage();

    if (image != null) {
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(image),
        quality: 100,
        name: _ayatModel.ayatNo.toString(),
      );

      if (!GetUtils.isNullOrBlank(result["filePath"])!) {
        Get.rawSnackbar(
          message: "Save into Gallery",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING,
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          borderRadius: 16,
        );
      }
    }
  }

  List<String> get backgrounds => [
        "assets/images/backgrounds/1.png",
        "assets/images/backgrounds/2.png",
        "assets/images/backgrounds/3.png",
        "assets/images/backgrounds/4.png",
        "assets/images/backgrounds/5.png",
        "assets/images/backgrounds/6.png",
        "assets/images/backgrounds/7.png",
        "assets/images/backgrounds/8.png",
      ];
}
