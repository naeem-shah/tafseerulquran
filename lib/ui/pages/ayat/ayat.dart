import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer_hafiz_abdusalam/assets/custom_fonts.dart';
import 'package:tafseer_hafiz_abdusalam/controllers/ayat/ayat_controller.dart';
import 'package:tafseer_hafiz_abdusalam/models/ayat_model.dart';
import 'package:tafseer_hafiz_abdusalam/models/index_model.dart';
import 'package:tafseer_hafiz_abdusalam/ui/widgets/ayat_widget.dart';

class Ayat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AyatController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => DropdownButton<IndexModel>(
              onChanged: (IndexModel value) => controller.onIndexChange(value),
              value: controller.selectedIndex,
              items: controller.indexes
                  .map((e) => DropdownMenuItem(
                        child: Text(
                          e.name,
                        ),
                        value: e,
                      ))
                  .toList(),
              dropdownColor: Get.theme.primaryColor,
              iconEnabledColor: Colors.white,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: CustomFonts.nooreHuda,
                  fontSize: 20),
            )),
        bottom: PreferredSize(
            child: Container(
              color: Colors.white,
              child: Obx(() {
                if (controller.ayatList.isNotEmpty)
                  return Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Center(
                              child: Text((controller.visibleIndex.value + 1)
                                  .toString()))),
                      Expanded(
                        flex: 8,
                        child: Slider(
                          value: (controller.visibleIndex.value).toDouble(),
                          onChanged: (v) => controller.visibleIndex(v.toInt()),
                          min: 0,
                          max: (controller.ayatList.length - 1).toDouble(),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Text(controller.ayatList.length.toString())),
                    ],
                  );

                return SizedBox();
              }),
            ),
            preferredSize: Size.fromHeight(48)),
      ),
      body: Obx(() {
        if (controller.ayatList.isNotEmpty)
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (_, index) {
              AyatModel ayatModel = controller.ayatList[index];
              return AyatWidget(
                ayatModel: ayatModel,
                onBookmarkTap: () => controller.onBookmarkPressed(ayatModel, index),
                onCopyTap: () => controller.onCopyPressed(ayatModel),
                onShareTap: () => controller.onSharePressed(ayatModel),
              );
            },
            itemCount: controller.ayatList.length,
          );

        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
