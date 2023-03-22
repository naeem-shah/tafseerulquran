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
      String query = queryController.text;
      if (query.isEmpty) {
        return;
      }
      query = "%$query%";

      String where = " 1 = 1 ";
      List<dynamic> arguments = [];

      if (inQuran.value) {
        where += " AND ${Constants.arabicClean} LIKE ? ";
        arguments.add(query);
      }

      if (inTranslation.value) {
        where += " AND ${Constants.translation} LIKE ? ";
        arguments.add(query);
      }
      if (inExplanation.value) {
        where += " AND ${Constants.tafsir} LIKE ? ";
        arguments.add(query);
      }

      if (selectedJuz.value != null) {
        where += " AND ${Constants.juzId} = ? ";
        arguments.add(selectedJuz.value!.id);
      }

      if (selectedSurah.value != null) {
        where += " AND ${Constants.surahId} = ? ";
        arguments.add(selectedSurah.value!.id);
      }

      print(where);
      print(arguments);

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
