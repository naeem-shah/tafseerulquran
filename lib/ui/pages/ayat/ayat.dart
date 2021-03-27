import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tafseer_hafiz_abdusalam/assets/custom_fonts.dart';
import 'package:tafseer_hafiz_abdusalam/controllers/ayat/ayat_controller.dart';
import 'package:tafseer_hafiz_abdusalam/models/ayat_model.dart';
import 'package:tafseer_hafiz_abdusalam/models/index_model.dart';
import 'package:tafseer_hafiz_abdusalam/ui/widgets/ayat_widget.dart';
import 'package:tafseer_hafiz_abdusalam/ui/widgets/more_action_dialog.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Ayat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AyatController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(98.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: AppBar(
            centerTitle: true,
            title: Obx(() => Text(controller.selectedIndex.nameEng)),
            bottom: PreferredSize(
                child: Container(
                  width: Get.width,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(icon: Icon(Icons.arrow_back,size: 24,), onPressed: (){
                        int index = controller.indexes.indexOf(controller.selectedIndex);
                        if (index <= 0) return;

                        controller.onIndexChange(--index);
                      },splashColor: Colors.transparent,highlightColor: Colors.transparent,),
                      SizedBox(
                        width: Get.width*0.4,

                        child: Obx(() => Text(controller.selectedIndex.name,style: TextStyle(
                    color: Get.theme.primaryColor,
                    fontFamily: CustomFonts.nooreHuda,
                    fontSize: 20),textAlign: TextAlign.center,)),
                      ),
                    IconButton(icon: Icon(Icons.arrow_forward,size: 24,), onPressed: (){
                      int index = controller.indexes.indexOf(controller.selectedIndex);
                      if (index >= (controller.isSurah ? 113 : 29)) return;
                      controller.onIndexChange(++index);
                    },splashColor: Colors.transparent,highlightColor: Colors.transparent,),
                  ],),
                ),
                preferredSize: Size.fromHeight(47.0)
            ),
            actions: [
              // IconButton(icon: Icon(Icons.more_vert), onPressed: (){
              //   Get.dialog(MoreActionDialog(),arguments: {"verse":0});
              // })
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (controller.ayatList.isNotEmpty)
          return ScrollablePositionedList.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (_, index) {
              AyatModel ayatModel = controller.ayatList[index];
              return VisibilityDetector(
                key: Key(ayatModel.id.toString()),

                onVisibilityChanged: (VisibilityInfo info) {
                  if (info.visibleFraction == 1){
                    controller.visibleIndex = index;
                  }
                },
                child: AyatWidget(
                  ayatModel: ayatModel,

                  translationVisible: controller.translationVisible,
                  tafsirVisible: controller.tafsirVisible,
                  onBookmarkTap: () => controller.onBookmarkPressed(ayatModel, index),
                  onCopyTap: () => controller.onCopyPressed(ayatModel),
                  onShareTap: () => controller.onSharePressed(ayatModel),
                ),
              );
            },
            itemCount: controller.ayatList.length,
            itemScrollController: controller.scrollController,
          );

        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
