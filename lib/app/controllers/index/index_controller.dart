import 'package:get/get.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:tafseer/app/models/index_model.dart';
import 'package:tafseer/app/routes/app_routes.dart';
import 'package:tafseer/app/services/database_manager.dart';

class IndexController extends GetxController {
  bool isSurah = true;
  final RxList<IndexModel> indexes = RxList<IndexModel>();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments.runtimeType == bool) {
      isSurah = Get.arguments as bool;
    }
    getRecords();
  }

  void navigate(int index) {
    Get.toNamed(
      AppRoutes.ayat,
      arguments: {
        "indexes": indexes,
        "index": index,
        "isSurah": isSurah,
        "isRecent": false,
      },
    );
  }



  Future getRecords() async {
    final list = await Get.find<DatabaseManager>()
        .getIndexes(isSurah ? Constants.surahTable : Constants.juzTable);
    indexes.assignAll(list);
  }
}
