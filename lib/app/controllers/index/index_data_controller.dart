import 'package:get/get.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:tafseer/app/models/index_model.dart';
import 'package:tafseer/app/services/database_manager.dart';

class IndexDataController extends GetxController {
  final List<IndexModel> surahs = [];
  final List<IndexModel> juz = [];

  @override
  void onInit() {
    super.onInit();
    getSurah();
    getJuz();
  }

  Future<void> getSurah() async {
    final list = await Get.find<DatabaseManager>().getIndexes(
      Constants.surahTable,
    );
    surahs.assignAll(list);
  }

  Future<void> getJuz() async {
    final list = await Get.find<DatabaseManager>().getIndexes(
      Constants.juzTable,
    );
    juz.assignAll(list);
  }

  IndexModel getIndex(int id) => surahs.firstWhere(
        (element) => element.id == id,
      );
}
