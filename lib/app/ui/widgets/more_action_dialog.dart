import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/assets/custom_fonts.dart';
import 'package:tafseer/app/controllers/ayat/ayat_controller.dart';

class MoreActionDialog extends StatelessWidget {
  const MoreActionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = AyatController();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: const Text("سیٹنگز",style: TextStyle(fontFamily: AppFonts.urdu,fontSize: 28),),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),),
        content: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(()=>RadioListTile(value: controller.translationVisible, onChanged: (dynamic v){},title: const Text("آیت مع ترجمہ",style: TextStyle(fontFamily: AppFonts.urdu,fontSize: 20),), groupValue: 1,)),
              Obx(()=>RadioListTile(value: controller.tafsirVisible, onChanged: (dynamic v){
                controller.setTafsirVisibility(true);
              },title: const Text("آیت ، ترجمہ مع تفسیر",style: TextStyle(fontFamily: AppFonts.urdu,fontSize: 20),),groupValue: 1,),),

              const SizedBox(height: 24,),

              const ButtonBar(
                
              )
            ],
          ),
        ),
      ),
    );
  }
}
