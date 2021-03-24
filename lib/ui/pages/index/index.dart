import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer_hafiz_abdusalam/assets/custom_fonts.dart';
import 'package:tafseer_hafiz_abdusalam/controllers/index/index_controller.dart';
import 'package:tafseer_hafiz_abdusalam/models/index_model.dart';
import 'package:tafseer_hafiz_abdusalam/ui/pages/ayat/ayat.dart';

class QuranIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IndexController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Surah"),
      ),
      body: Obx((){
        if (controller.indexes.isNotEmpty)
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (_,index){
              IndexModel indexModel = controller.indexes[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8,left: 8,right: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: (){
                    Get.to(()=> Ayat(),arguments: {
                      "indexes":controller.indexes,
                      "index":index,
                      "isSurah":controller.isSurah
                    });
                  },
                  child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListTile(
                    leading: Text("${index+1}"),
                    trailing: Text(indexModel.nameEng,style: TextStyle(
                    ),),
                    title: Text(indexModel.name,
                      style: TextStyle(
                        fontFamily: CustomFonts.nooreHuda,
                        fontSize: 22
                      ),),
                  ),
              ),
                ),);
            },
            itemCount: controller.indexes.length,);

        return Center(child: CircularProgressIndicator(),);
      }),
    );
  }
}
