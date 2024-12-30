import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/controllers/ayat/ayat_controller.dart';

class AyahSlider extends StatelessWidget implements PreferredSizeWidget {
  const AyahSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AyatController>();
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Obx(() {
        if (controller.ayahs.isNotEmpty) {
          return Row(
            children: [
              Text(
                "${controller.sliderValue.toInt()}",
              ),
              Expanded(
                flex: 1,
                child: Slider(
                  value: controller.sliderValue.value,
                  onChanged: (value) {
                    controller.sliderValue.value = value;
                  },
                  onChangeEnd: (value) {
                    controller.scrollToAyat(value.toInt() -
                        (controller.selectedIndex?.id == 9 ? 1 : 0));
                  },
                  min: 1,
                  max: controller.sliderLength,
                  inactiveColor: Get.theme.primaryColorLight,
                ),
              ),
              Text(
                "${controller.sliderLength.toInt()}",
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
