import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:tafseer/app/models/ayat_model.dart';
import 'package:tafseer/app/services/database_manager.dart';

class HomeQuranController extends GetxController {
  final hijri = HijriCalendar.now();
  final dateNow = DateTime.now();
  final Rxn<AyatModel> dailyAyat = Rxn<AyatModel>();

  @override
  void onInit() {
    super.onInit();

    getAyah();
  }

  Future getAyah() async {
    AyatModel ayatModel = await Get.find<DatabaseManager>().dailyAyah();
    if (ayatModel.ayatNo == 0 || ayatModel.id == 1) {
      Get.log("Fetching again Ayah");
      getAyah();
      return;
    }
    dailyAyat.value = ayatModel;
  }
}
