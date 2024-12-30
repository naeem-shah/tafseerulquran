import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/ui/widgets/bg_frame.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BgFrame(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          0,
          Get.width * 0.3,
          0,
          0,
        ),
        child: Column(
          children: [
            Center(
              child: Hero(
                tag: "logo",
                child: Image.asset(
                  "assets/images/logo.png",
                  width: Get.width * 0.3,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
