import 'package:tafseer_hafiz_abdusalam/assets/constants.dart';

class IndexModel{

  int id;
  String name;
  String nameEng;
  String nameEngMeaning;

  IndexModel({this.id, this.name, this.nameEng, this.nameEngMeaning});

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();

    map[Constants.id] = this.id;
    map[Constants.nameEng] = this.name;
    map[Constants.nameEng] = this.nameEng;
    map[Constants.nameEngMeaning] = this.nameEngMeaning;
    return map;
  }


  IndexModel.fromMapObject(Map<String, dynamic> map){
    this.id = map[Constants.id];
    this.name = map[Constants.name];
    this.nameEng = map[Constants.nameEng];
    this.nameEngMeaning = map[Constants.nameEngMeaning];
  }
}