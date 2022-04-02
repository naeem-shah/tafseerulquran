import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:tafseer/app/models/ayat_model.dart';
import 'package:tafseer/app/models/index_model.dart';
import 'package:tafseer/app/services/database_manager.dart';
import 'package:tafseer/app/services/preferences.dart';

class AyatController extends GetxController {
  bool isSurah = true;
  final RxList<AyatModel> ayahs = RxList<AyatModel>();
  final RxList<IndexModel> indexes = RxList<IndexModel>();
  final RxBool _translationVisible = RxBool(true);
  final _tafsirVisible = RxBool(true);
  final Rxn<IndexModel> _selectedIndex = Rxn<IndexModel>();
  final ItemScrollController scrollController = ItemScrollController();
  final List<IndexModel> surahs = [];
  int lastVisible = 0;

  bool get translationVisible => _translationVisible.value;

  bool get tafsirVisible => _tafsirVisible.value;

  void setTranslationVisibility(bool value) => _translationVisible(value);

  void setTafsirVisibility(bool value) => _tafsirVisible(value);

  IndexModel? get selectedIndex => _selectedIndex.value;

  @override
  void onInit() async {
    super.onInit();

    assert(Get.arguments != null, "Must pass isSurah: BOOL, index: IndexModel");

    if (Get.arguments != null) {

      if (Get.arguments["isRecent"]) {
        int scrollPosition = Get.arguments["scroll_position"];
        int surahId = Get.arguments["surah_id"];
        isSurah = true;
        await getSurahs();
        _selectedIndex.value = surahs.firstWhere(
          (element) => element.id == surahId,
        );
        await getAyatList();
        Future.delayed(
          const Duration(
            milliseconds: 250,
          ),
          () {
            scrollController.scrollTo(
              index: scrollPosition,
              duration: const Duration(
                milliseconds: 300,
              ),
            );
          },
        );


      } else {
        indexes.assignAll(Get.arguments["indexes"]);
        final int index = Get.arguments["index"];
        isSurah = Get.arguments["isSurah"];

        _selectedIndex.value = indexes[index];
        await getSurahs();
        getAyatList();
      }
    }
  }

  Future<void> getAyatList() async {
    Get.log(selectedIndex!.id.toString());
    final list = await Get.find<DatabaseManager>().getAyatList(
      isSurah ? Constants.surahId : Constants.juzId,
      selectedIndex?.id,
    );

    ayahs.assignAll(list);
  }

  Future getSurahs() async {
    final list = await Get.find<DatabaseManager>().getIndexes(
      Constants.surahTable,
    );
    surahs.assignAll(list);
  }

  Future<bool> onPopScope() async {
    Get.log("Last Visible Index: $lastVisible");
    Get.log("Last Surah Id: ${selectedIndex?.id}");

    if (isSurah) {
      await Get.find<Preferences>().setInt(
        key: Constants.recentSurahId,
        value: selectedIndex?.id,
      );

      await Get.find<Preferences>().setInt(
        key: Constants.recentPosition,
        value: lastVisible,
      );
    }

    return Future.value(true);
  }
}
