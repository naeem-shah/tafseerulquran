import 'package:get/get.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:tafseer/app/services/preferences.dart';

class SettingsBottomSheetController extends GetxController {
  final RxInt fontQuran = RxInt(18);
  final RxInt fontTranslation = RxInt(18);
  final RxInt fontExplanation = RxInt(18);
  final RxBool explanationVisibility = RxBool(true);

  @override
  void onInit() {
    super.onInit();
    getValues();
  }

  Future getValues() async {
    fontQuran.value =
        Get.find<Preferences>().getInt(key: Constants.fontQuran) ?? 18;
    fontTranslation.value =
        Get.find<Preferences>().getInt(key: Constants.fontTranslation) ?? 18;
    fontExplanation.value = Get.find<Preferences>().getInt(key: Constants.fontExplanation) ?? 18;
    explanationVisibility.value =
        Get.find<Preferences>().getBool(key: Constants.explanationVisibility) ?? true;
  }

  void changeVisibility(bool? visibility)async{

    explanationVisibility.value = !explanationVisibility.value;

    Get.find<Preferences>().setBool(key: Constants.explanationVisibility, value: explanationVisibility.value);
  }
}
