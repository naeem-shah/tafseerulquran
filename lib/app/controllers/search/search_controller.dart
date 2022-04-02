import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:tafseer/app/models/ayat_model.dart';
import 'package:tafseer/app/models/index_model.dart';
import 'package:tafseer/app/services/database_manager.dart';

class SearchController extends GetxController {
  final RxList<AyatModel> searches = RxList<AyatModel>();
  final Rxn<IndexModel> selectedSurah = Rxn<IndexModel>();
  final Rxn<IndexModel> selectedJuz = Rxn<IndexModel>();

  final RxList<IndexModel> surahs = RxList<IndexModel>();
  final RxList<IndexModel> juz = RxList<IndexModel>();

  final TextEditingController queryController = TextEditingController();
  final debouncer = Debouncer(delay: const Duration(milliseconds: 400));

  final RxBool inQuran = RxBool(true);
  final RxBool inTranslation = RxBool(true);
  final RxBool inExplanation = RxBool(true);

  final RxBool isLoading = RxBool(false);

  Future applySearch() async {
    if (queryController.text.isNotEmpty) {
      search();
    }
  }

  Future search() async {
    debouncer.call(() async {
      isLoading.value = true;
      final String query = queryController.text;
      if (query.isEmpty) {
        return;
      }
      String where = "";
      List<dynamic> arguments = [];
      // only quran


      if (inQuran.value && !inTranslation.value && !inExplanation.value) {
        where = "${Constants.arabicClean} LIKE ? ";
        arguments.add("%$query%");
      } else if (inQuran.value && inTranslation.value && !inExplanation.value) {
        // quran and translation
        where =
            "${Constants.arabicClean} LIKE ? OR ${Constants.translation} LIKE ? ";
        arguments.add("%$query%");
        arguments.add("%$query%");
      } else if (inQuran.value && inTranslation.value && inExplanation.value) {
        // quran, translation and explanation
        where =
            "${Constants.arabicClean} LIKE ? OR ${Constants.translation} LIKE ? OR ${Constants.tafsir} LIKE ? ";
        arguments.add("%$query%");
        arguments.add("%$query%");
        arguments.add("%$query%");
      } else if (inQuran.value && !inTranslation.value && inExplanation.value) {
        // quran and tafseer
        where =
            "${Constants.arabicClean} LIKE ? OR ${Constants.tafsir} LIKE ? ";
        arguments.add("%$query%");
        arguments.add("%$query%");
      } else if (!inQuran.value && inTranslation.value && inExplanation.value) {
        // translation and tafseer
        where =
            "${Constants.translation} LIKE ? OR ${Constants.tafsir} LIKE ? ";
        arguments.add("%$query%");
        arguments.add("%$query%");
      } else if (!inQuran.value &&
          !inTranslation.value &&
          inExplanation.value) {
        // tafseer only
        where = "${Constants.tafsir} LIKE ? ";
        arguments.add("%$query%");
      } else if (!inQuran.value &&
          inTranslation.value &&
          !inExplanation.value) {
        // translation only
        where = "${Constants.tafsir} LIKE ? ";
        arguments.add("%$query%");
      }

      if (selectedJuz.value != null) {
        where += "${arguments.isNotEmpty ? "AND" : ""} ${Constants.juzId} = ? ";
        arguments.add(selectedJuz.value?.id);
      }

      if (selectedSurah.value != null) {
        where += "${arguments.isNotEmpty ? "AND" : ""} ${Constants.surahId} = ? ";
        arguments.add(selectedSurah.value?.id);
      }

      final list = await Get.find<DatabaseManager>().search(
        where,
        arguments,
      );
      isLoading.value = false;
      searches.assignAll(list);
    });
  }

  Future getSurahs() async {
    final list = await Get.find<DatabaseManager>().getIndexes(
      Constants.surahTable,
    );
    surahs.assignAll(list);
  }

  Future getJuz() async {
    final list = await Get.find<DatabaseManager>().getIndexes(
      Constants.juzTable,
    );
    juz.assignAll(list);
  }

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      getSurahs(),
      getJuz(),
    ]);
  }
}
