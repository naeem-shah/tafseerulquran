import 'package:get/get.dart';
import 'package:tafseer/app/models/ayat_model.dart';
import 'package:tafseer/app/services/database_manager.dart';


class BookmarkController extends GetxController {
  final RxList<AyatModel> ayahs = RxList<AyatModel>();
  final RxBool isLoading = RxBool(true);
  @override
  void onInit() async {
    super.onInit();
    getBookmarks();
  }

  Future getBookmarks() async {
    isLoading.value = true;
    final list = await Get.find<DatabaseManager>().getBookmarks();
    isLoading.value = false;
    ayahs.assignAll(list);
  }
}
