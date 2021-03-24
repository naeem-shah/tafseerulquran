import 'package:tafseer_hafiz_abdusalam/assets/constants.dart';

class AyatModel{

  int id;
  String ayat;
  String ayatClean;
  String translation;
  String tafsir;
  int surahId;
  int juzId;
  int ayatNo;
  bool isBookmark;

  AyatModel(
      {this.id,
      this.ayat,
      this.ayatClean,
      this.translation,
      this.tafsir,
      this.surahId,
      this.juzId,
      this.ayatNo,
      this.isBookmark});

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();

    map[Constants.id] = this.id;
    map[Constants.arabic] = this.ayat;
    map[Constants.arabicClean] = this.ayatClean;
    map[Constants.translation] = this.translation;
    map[Constants.tafsir] = this.tafsir;
    map[Constants.surahId] = this.surahId;
    map[Constants.juzId] = this.juzId;
    map[Constants.ayatNo] = this.ayatNo;
    map[Constants.isBookmark] = this.isBookmark ? 1 : 0;
    return map;
  }


  AyatModel.fromMapObject(Map<String, dynamic> map){
    this.id = map[Constants.id];
    this.ayat = map[Constants.arabic];
    this.ayatClean = map[Constants.arabicClean];
    this.translation = map[Constants.translation];
    this.tafsir = map[Constants.tafsir];
    this.surahId = map[Constants.surahId];
    this.juzId = map[Constants.juzId];
    this.ayatNo = map[Constants.ayatNo];
    this.isBookmark = map[Constants.isBookmark] == 1? true:false;

  }

}