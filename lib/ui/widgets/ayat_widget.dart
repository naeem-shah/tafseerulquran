import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer_hafiz_abdusalam/assets/custom_fonts.dart';
import 'package:tafseer_hafiz_abdusalam/models/ayat_model.dart';

class AyatWidget extends StatelessWidget {
  final AyatModel ayatModel;

  const AyatWidget({Key key, @required this.ayatModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
          bottom: 8,left: 8,right: 8
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 12,bottom: 12),
              child: Text(ayatModel.ayat,style: TextStyle(
                  fontSize: 22,fontFamily: CustomFonts.nooreHuda
              ),),
            ),
            Container(
              width: Get.width,
              color: Get.theme.primaryColor.withOpacity(0.05),
              padding: const EdgeInsets.only(left: 8,right: 8,top: 12,bottom: 12),
              child: Text(ayatModel.translation,style: TextStyle(
                  fontSize: 22,fontFamily: CustomFonts.urdu
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12,left: 8,right: 8,bottom: 12),
              child: Text(ayatModel.tafsir,style: TextStyle(
                  fontSize: 22,fontFamily: CustomFonts.urdu,
                  height: 1.6
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
