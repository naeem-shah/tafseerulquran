import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

/* to run debug analytics
adb shell setprop debug.firebase.analytics.app [yourapp.package.id]*/
class AnalyticsService extends GetxService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUserId({String? userId}) async {
    await _analytics.setUserId(id: userId);
  }

  Future setUserProperties({
    required String? name,
    required String? phone,
  }) async {
    _analytics.setUserProperty(name: "Name", value: name);
    _analytics.setUserProperty(name: "Phone", value: phone);
  }

  Future logSignUp() async {
    _analytics.logSignUp(signUpMethod: "Phone");
  }

  Future logLogin({required String loginMethod}) async {
    _analytics.logLogin(loginMethod: loginMethod);
  }

  Future logEvent(
      {required String name, Map<String, Object>? parameters}) async {
    _analytics.logEvent(name: name, parameters: parameters);
  }
}
