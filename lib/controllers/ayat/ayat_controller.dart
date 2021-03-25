import 'package:clipboard/clipboard.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:tafseer_hafiz_abdusalam/Database/DatabaseManager.dart';
import 'package:tafseer_hafiz_abdusalam/assets/constants.dart';
import 'package:tafseer_hafiz_abdusalam/assets/toaster.dart';
import 'package:tafseer_hafiz_abdusalam/models/ayat_model.dart';
import 'package:tafseer_hafiz_abdusalam/models/index_model.dart';

class AyatController extends GetxController{

  bool isSurah = true;
  var visibleIndex = 0.obs;
  var _ayat = [].obs;
  var _indexes = [].obs;
  var _selectedIndex = IndexModel().obs;

  List<IndexModel> get indexes => List<IndexModel>.from(_indexes);

  List<AyatModel> get ayatList => List<AyatModel>.from(_ayat);


  void onIndexChange(IndexModel indexModel) {
    _selectedIndex(indexModel);
    _ayat.clear();
    getAyatList();
  }

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

  Future<void> onBookmarkPressed(AyatModel ayatModel,int index) async {

    ayatModel.isBookmark = !ayatModel.isBookmark;

    _ayat[index] = ayatModel;

    if (ayatModel.isBookmark){
      Toaster.toast("Bookmark Added");
    }else {
      Toaster.toast("Bookmark Removed");
    }

    DbManager().updateAyat(ayatModel);
  }


  void onCopyPressed(AyatModel ayatModel) {
    String text = _textMaker(ayatModel);
    FlutterClipboard.copy(text);
    Toaster.toast("Copied");
  }

  void onSharePressed(AyatModel ayatModel){
    String text = _textMaker(ayatModel);

    Share.share(text);
  }


  String _textMaker(AyatModel ayatModel){

    String text="";

    String surahName = selectedIndex.name;
    int ayaNo = ayatModel.ayatNo;
    text += "$surahName آیت نمبر $ayaNo\n\n";
    text += "${Constants.auzubillah}\n";
    text += "${Constants.bismillah}\n\n";
    text += "${ayatModel.ayat}\n\n";
    text += "ترجمہ:\n";
    text += "${ayatModel.translation}\n\n";
    text += "تفسیر:\n";
    text += "${ayatModel.tafsir.replaceAll("{", "").replaceAll("}", "").replaceAll("¤", "\n")}";

    return text;
  }
}