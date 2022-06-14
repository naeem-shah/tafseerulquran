import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences extends GetxService {
  late SharedPreferences _preferences;

  Future<Preferences> initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  String? getString({required String key}) {
    return _preferences.getString(key);
  }

  bool? getBool({required String key}) {
    return _preferences.getBool(key);
  }

  int? getInt({required String key}) {
    return _preferences.getInt(key);
  }

  double? getDouble({required String key}) {
    return _preferences.getDouble(key);
  }

  Future<void> setString({required String key, required String? value}) async {
    if (value == null) return;
    await _preferences.setString(key, value);
  }

  Future<void> setBool({required String key, required bool? value}) async {
    if (value == null) return;
    await _preferences.setBool(key, value);
  }

  Future<void> setDouble({required String key, required double value}) async {
    await _preferences.setDouble(key, value);
  }

  Future<void> setInt({required String key, int? value}) async {
    if (value != null) {
      await _preferences.setInt(key, value);
    }
  }
}
