import 'package:tafseer/app/assets/constants.dart';

class IndexModel {
  int id;
  String name;
  String nameEng;
  String nameEngMeaning;

  IndexModel({
    required this.id,
    required this.name,
    required this.nameEng,
    required this.nameEngMeaning,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map[Constants.id] = id;
    map[Constants.nameEng] = name;
    map[Constants.nameEng] = nameEng;
    map[Constants.nameEngMeaning] = nameEngMeaning;
    return map;
  }

  factory IndexModel.fromMapObject(Map<String, dynamic> map) => IndexModel(
        id: map[Constants.id],
        name: map[Constants.name],
        nameEng: map[Constants.nameEng],
        nameEngMeaning: map[Constants.nameEngMeaning],
      );
}
