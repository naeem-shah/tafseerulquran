import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer_hafiz_abdusalam/assets/custom_fonts.dart';
import 'package:tafseer_hafiz_abdusalam/controllers/ayat/ayat_controller.dart';
import 'package:tafseer_hafiz_abdusalam/models/ayat_model.dart';
import 'package:tafseer_hafiz_abdusalam/ui/widgets/ayat_widget.dart';

class Ayat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AyatController());

    return Scaffold(
      appBar: AppBar(),
      body: Obx((){
        if (controller.ayatList.isNotEmpty)
          return ListView.builder(itemBuilder: (_,index){
            AyatModel ayatModel = controller.ayatList[index];
            return AyatWidget(ayatModel: ayatModel);
          },itemCount: controller.ayatList.length,);

        return Center(child: CircularProgressIndicator(),);
      }),
    );
  }
}
