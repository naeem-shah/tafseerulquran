import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/controllers/splash_controller.dart';
import 'package:tafseer/app/ui/widgets/bg_frame.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return BgFrame(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "logo",
              child: Image.asset("assets/images/logo.png"),
            ),
            const SizedBox(
              height: 24,
            ),
            Image.asset(
              "assets/images/abdulsalam_name.png",
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
