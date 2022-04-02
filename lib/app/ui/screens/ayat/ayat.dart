import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tafseer/app/assets/custom_fonts.dart';
import 'package:tafseer/app/controllers/ayat/ayat_controller.dart';
import 'package:tafseer/app/models/ayat_model.dart';
import 'package:tafseer/app/ui/widgets/ayat_widget.dart';
import 'package:tafseer/app/ui/widgets/settings_bottom_sheet.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Ayat extends StatelessWidget {
  const Ayat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AyatController());

    return WillPopScope(
      onWillPop: controller.onPopScope,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,

          title: Obx(
            () => Text(
              "${controller.selectedIndex?.id} - ${controller.selectedIndex?.name}",
              style: const TextStyle(
                fontFamily: AppFonts.nooreHuda,
              ),
              // textDirection: TextDirection.rtl,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Get.bottomSheet(
                  const SettingsBottomSheet(),
                  isScrollControlled: true,
                );
              },
            )
          ],
        ),
        body: Obx(() {
          if (controller.ayahs.isNotEmpty) {
            return ScrollablePositionedList.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (_, index) {
                final AyatModel ayatModel = controller.ayahs[index];
                return VisibilityDetector(
                  key: Key(ayatModel.id.toString()),
                  onVisibilityChanged: (VisibilityInfo info) {
                    if (info.visibleFraction == 1) {
                      controller.lastVisible = index;
                    }
                  },
                  child: AyatWidget(
                    ayatModel: ayatModel,
                  ),
                );
              },
              itemCount: controller.ayahs.length,
              itemScrollController: controller.scrollController,
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
