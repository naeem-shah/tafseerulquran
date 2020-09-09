import 'package:tafseer_hafiz_abdusalam/Constants/Constants.dart';

class AyatModel {
  int id;
  int suratId;
  String ayatNo;
  String ayat;
  String ayatSimple;
  String translation;
  String tafseer;
  int parhNo;
  String reference;

  AyatModel({this.id,
    this.suratId,
    this.ayat,
    this.ayatSimple,
    this.translation,
    this.tafseer,
    this.parhNo,
    this.reference});

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();

    map[Constants.ID] = this.id;
    map[Constants.SURAT_ID] = this.suratId;
    map[Constants.AYAT_NO] = this.ayatNo;
    map[Constants.AYAT] = this.ayat;
    map[Constants.AYAT_SIMPLE] = this.ayatSimple;
    map[Constants.TRANSLATION] = this.translation;
    map[Constants.TAFSEER] = this.tafseer;
    map[Constants.PARAH] = this.parhNo;
    map[Constants.REFERENCE] = this.reference;

    return map;
  }


  AyatModel.fromMapObject(Map<String, dynamic> map){
    this.id = map[Constants.ID];
    this.suratId = map[Constants.SURAT_ID];
    this.ayat = map[Constants.AYAT];
    this.ayatSimple = map[Constants.AYAT_SIMPLE];
    this.translation = map[Constants.TRANSLATION];
    this.ayatNo = map[Constants.AYAT_NO];
    this.tafseer = map[Constants.TAFSEER];
    this.parhNo = map[Constants.PARAH];
    this.reference = map[Constants.REFERENCE];
  }
}
