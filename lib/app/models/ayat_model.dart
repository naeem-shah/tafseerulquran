import 'package:get/get.dart';
import 'package:tafseer/app/assets/constants.dart';

class AyatModel {
  int id;
  String ayat;
  String ayatClean;
  String translation;
  String? tafsir;
  int surahId;
  int juzId;
  int ayatNo;
  RxBool isBookmark;

  AyatModel({
    required this.id,
    required this.ayat,
    required this.ayatClean,
    required this.translation,
    this.tafsir,
    required this.surahId,
    required this.juzId,
    required this.ayatNo,
    required this.isBookmark,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map[Constants.id] = id;
    map[Constants.arabic] = ayat;
    map[Constants.arabicClean] = ayatClean;
    map[Constants.translation] = translation;
    map[Constants.tafsir] = tafsir;
    map[Constants.surahId] = surahId;
    map[Constants.juzId] = juzId;
    map[Constants.ayatNo] = ayatNo;
    map[Constants.isBookmark] = isBookmark.value ? 1 : 0;
    return map;
  }

  factory AyatModel.fromMapObject(Map<String, dynamic> map) {
    return AyatModel(
      id: map[Constants.id],
      ayat: map[Constants.arabic],
      ayatClean: map[Constants.arabicClean],
      translation: map[Constants.translation],
      tafsir: map[Constants.tafsir],
      surahId: map[Constants.surahId],
      juzId: map[Constants.juzId],
      ayatNo: map[Constants.ayatNo],
      isBookmark: RxBool(map[Constants.isBookmark] == 1),
    );
  }

  String? get tafsirClean {
    if (tafsir == null) {
      return null;
    }
    return tafsir
            ?.replaceAll(
              "{",
              "",
            )
            .replaceAll(
              "}",
              "",
            )
            .replaceAll(
              "¤",
              "\n",
            ) ??
        "";
  }
}
