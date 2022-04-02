import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';

class HomeQuranController extends GetxController {
  final hijri = HijriCalendar.now();
  final dateNow = DateTime.now();

}
