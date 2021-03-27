import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tafseer_hafiz_abdusalam/assets/custom_fonts.dart';
import 'package:tafseer_hafiz_abdusalam/controllers/ayat/ayat_controller.dart';
import 'package:tafseer_hafiz_abdusalam/controllers/ayat/more_action_dialog_controller.dart';

class MoreActionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = AyatController();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text("سیٹنگز",style: TextStyle(fontFamily: CustomFonts.urdu,fontSize: 28),),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Container(
          width: Get.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(()=>RadioListTile(value: controller.translationVisible, onChanged: (v){},title: Text("آیت مع ترجمہ",style: TextStyle(fontFamily: CustomFonts.urdu,fontSize: 20),), groupValue: 1,)),
              Obx(()=>RadioListTile(value: controller.tafsirVisible, onChanged: (v){
                controller.setTafsirVisibility(true);
              },title: Text("آیت ، ترجمہ مع تفسیر",style: TextStyle(fontFamily: CustomFonts.urdu,fontSize: 20),),groupValue: 1,)),

              SizedBox(height: 24,),

              ButtonBar(
                children: [

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
