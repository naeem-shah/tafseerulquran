import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetClosingWidget extends StatelessWidget {
  const BottomSheetClosingWidget({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 6, 6, 12),
      width: Get.width,
      child: GestureDetector(
        onTap: Get.back,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.grey,
              size: 30,
            ),
            if (title != null)
              const SizedBox(
                height: 12,
              ),
            if (title != null)
              Text(
                title!,
                style: Get.textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
