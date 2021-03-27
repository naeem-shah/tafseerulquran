import 'package:clipboard/clipboard.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:share/share.dart';
import 'package:tafseer_hafiz_abdusalam/Database/DatabaseManager.dart';
import 'package:tafseer_hafiz_abdusalam/assets/constants.dart';
import 'package:tafseer_hafiz_abdusalam/assets/toaster.dart';
import 'package:tafseer_hafiz_abdusalam/models/ayat_model.dart';
import 'package:tafseer_hafiz_abdusalam/models/index_model.dart';

class AyatController extends GetxController{

  bool isSurah = true;
  int visibleIndex = 0;
  var _ayat = [].obs;
  var _indexes = [].obs;
  var _translationVisible = true.obs, _tafsirVisible = true.obs;
  var _selectedIndex = IndexModel().obs;
  final ItemScrollController scrollController = ItemScrollController();

  List<IndexModel> get indexes => List<IndexModel>.from(_indexes);

  List<AyatModel> get ayatList => List<AyatModel>.from(_ayat);

  bool get translationVisible => _translationVisible.value;

  bool get tafsirVisible => _tafsirVisible.value;

  void setTranslationVisibility (bool value) => _translationVisible(value);

  void setTafsirVisibility (bool value) => _tafsirVisible(value);

  void onIndexChange(int index) {
    visibleIndex = 0;
    _selectedIndex(indexes[index]);
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