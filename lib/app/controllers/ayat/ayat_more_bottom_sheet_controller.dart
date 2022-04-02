import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:tafseer/app/controllers/bookmark_controller.dart';
import 'package:tafseer/app/controllers/index/index_data_controller.dart';
import 'package:tafseer/app/enums.dart';
import 'package:tafseer/app/models/ayat_model.dart';
import 'package:tafseer/app/routes/app_routes.dart';
import 'package:tafseer/app/services/database_manager.dart';
import 'package:tafseer/app/ui/widgets/message_logger.dart';
import 'package:tafseer/app/ui/widgets/share/share_text_bottom_sheet.dart';

class MoreBottomSheetController extends GetxController {
  late AyatModel ayat;

  Future onCopy() async {
    ShareEnums? eValue = await Get.bottomSheet(const ShareTextBottomSheet());

    if (eValue == null) return;
    Clipboard.setData(
      ClipboardData(
        text: _textMaker(
          shareEnums: eValue,
        ),
      ),
    );

    messageLogger("Copy To Clipboard");
  }

  Future onBookmark() async {
    ayat.isBookmark.value = !ayat.isBookmark.value;
    if (ayat.isBookmark.value) {
      messageLogger("Bookmark added");
    } else {
      messageLogger("Bookmark removed");
    }

    await Get.find<DatabaseManager>().updateAyat(ayat);
    if (Get.currentRoute.contains(AppRoutes.bookmarks)) {
      if (Get.isBottomSheetOpen ?? false) Get.back();
      Get.find<BookmarkController>().getBookmarks();
    }
  }

  void onPlay() {
    messageLogger("Coming soon");
  }

  Future onShareAsImage() async {
    Get.toNamed(AppRoutes.editShare, arguments: ayat);
  }

  Future onShare() async {
    Share.share(
      _textMaker(shareEnums: ShareEnums.copyAyahTranslationAndTafseer),
    );
  }

  String _textMaker({required ShareEnums shareEnums}) {
    String text = "";
    String? surahName =
        Get.find<IndexDataController>().getIndex(ayat.surahId).name;

    final int ayaNo = ayat.ayatNo;
    text += "$surahName آیت نمبر $ayaNo\n\n";
    text += "${Constants.auzubillah}\n";
    text += "${Constants.bismillah}\n\n";

    if (shareEnums == ShareEnums.copyAyah) {
      text += "${ayat.ayat}\n\n";
    }

    if (shareEnums == ShareEnums.copyAyahWithTafseer) {
      text += "${ayat.ayat}\n\n";
      text += "ترجمہ:\n";
      text += "${ayat.translation}\n\n";
    }

    if (shareEnums == ShareEnums.copyAyahTranslationAndTafseer) {
      text += "${ayat.ayat}\n\n";
      text += "ترجمہ:\n";
      text += "${ayat.translation}\n\n";
      if (!GetUtils.isNullOrBlank(ayat.tafsir)!) {
        text += "تفسیر:\n";
        text += ayat.tafsirClean!;
      }
    }

    if (shareEnums == ShareEnums.copyTranslationOnly) {
      text += "ترجمہ:\n";
      text += "${ayat.translation}\n\n";
    }

    if (shareEnums == ShareEnums.copyTafseerOnly) {
      if (!GetUtils.isNullOrBlank(ayat.tafsir)!) {
        text += "تفسیر:\n";
        text += ayat.tafsirClean!;
      }
    }

    return text;
  }
}
