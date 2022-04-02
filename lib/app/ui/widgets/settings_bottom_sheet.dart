import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:tafseer/app/controllers/settings_bottom_sheet_controller.dart';
import 'package:tafseer/app/services/preferences.dart';
import 'package:tafseer/app/ui/widgets/bottom_sheet_closing_widget.dart';
import 'package:tafseer/app/ui/widgets/font_tile.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsBottomSheetController());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            16,
          ),
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetClosingWidget(title: "Settings"),
            Obx(() {
              return FontTile(
                title: "Quran font size",
                onChange: (value) {
                  controller.fontQuran.value = value;
                  Get.find<Preferences>()
                      .setInt(key: Constants.fontQuran, value: value);
                },
                value: controller.fontQuran.value,
              );
            }),
            const Divider(
              height: 0,
            ),
            Obx(() {
              return FontTile(
                title: "Translation font size",
                onChange: (value) {
                  controller.fontTranslation.value = value;
                  Get.find<Preferences>()
                      .setInt(key: Constants.fontTranslation, value: value);
                },
                value: controller.fontTranslation.value,
              );
            }),
            const Divider(
              height: 0,
            ),
            Obx(() {
              return FontTile(
                title: "Explanation font size",
                onChange: (value) {
                  controller.fontExplanation.value = value;
                  Get.find<Preferences>()
                      .setInt(key: Constants.fontExplanation, value: value);
                },
                value: controller.fontExplanation.value,
              );
            }),
            const Divider(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16, 0, 8),
              child: Text(
                "Reading Mode",
                style: Get.textTheme.subtitle2,
              ),
            ),
            const Divider(
              height: 0,
            ),
            Obx(() {
              return CheckboxListTile(
                title: const Text("Hide Tafseer"),
                value: !controller.explanationVisibility.value,
                onChanged: controller.changeVisibility,
              );
            }),
          ],
        ),
      ),
    );
  }
}
