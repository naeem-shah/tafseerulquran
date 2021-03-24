import 'package:get/get.dart';
import 'package:tafseer_hafiz_abdusalam/Database/DatabaseManager.dart';
import 'package:tafseer_hafiz_abdusalam/assets/constants.dart';
import 'package:tafseer_hafiz_abdusalam/models/index_model.dart';

class IndexController extends GetxController {
  bool isSurah = true;
  var _indexes = [].obs;

  List<IndexModel> get indexes => List<IndexModel>.from(_indexes);

  @override
  void onInit() async {
    super.onInit();

    if (Get.arguments != null) {
      isSurah = Get.arguments;
    }

    var list = await DbManager()
        .getIndexes(isSurah ? Constants.surahTable : Constants.juzTable);
    _indexes.assignAll(list);
  }
}
