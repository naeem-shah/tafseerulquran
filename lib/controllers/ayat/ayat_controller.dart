import 'package:get/get.dart';
import 'package:tafseer_hafiz_abdusalam/Database/DatabaseManager.dart';
import 'package:tafseer_hafiz_abdusalam/assets/constants.dart';
import 'package:tafseer_hafiz_abdusalam/models/ayat_model.dart';
import 'package:tafseer_hafiz_abdusalam/models/index_model.dart';

class AyatController extends GetxController{

  bool isSurah = true;

  var _ayat = [].obs;
  var _indexes = [].obs;
  var _selectedIndex = IndexModel().obs;

  List<IndexModel> get indexes => List<IndexModel>.from(_indexes);

  List<AyatModel> get ayatList => List<AyatModel>.from(_ayat);

  IndexModel get selectedIndex {
    if (_selectedIndex.value.id != null){
      return _selectedIndex.value;
    }
    return null;
  }


  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      _indexes.assignAll(Get.arguments["indexes"]);
      int index = Get.arguments["index"];
      isSurah = Get.arguments["isSurah"];
      _selectedIndex(indexes[index]);
    }

    getAyatList();
  }

  Future<void> getAyatList() async {
    var list = await DbManager().getAyatList(isSurah? Constants.surahId : Constants.juzId, selectedIndex.id);

    _ayat.assignAll(list);
  }
}