import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/controllers/index/index_data_controller.dart';
import 'package:tafseer/app/controllers/jump_to_ayah_controller.dart';
import 'package:tafseer/app/models/index_model.dart';

class JumpToAyahDialog extends StatelessWidget {
  const JumpToAyahDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IndexDataController controller = Get.find<IndexDataController>();
    final JumpToAyahController jumpToAyahController = Get.put(
      JumpToAyahController(),
    );

    return SizedBox(
      width: Get.width,
      child: Form(
        key: jumpToAyahController.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField(
              value: jumpToAyahController.selectedIndex.value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              items: controller.surahs
                  .map(
                    (index) => DropdownMenuItem(
                      value: index,
                      child: RichText(
                        text: TextSpan(
                          text: "${index.id} - ",
                          children: [
                            TextSpan(
                              text: index.name,
                              style: Get.textTheme.subtitle1?.copyWith(
                                fontFamily: "NooreHuda",
                              ),
                            ),
                          ],
                          style: Get.textTheme.subtitle1?.copyWith(),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (IndexModel? value) =>
                  jumpToAyahController.selectedIndex.value = value!,
              validator: (value){
                if (value == null){
                  return "Select Surah";
                }
                return null;
              },
            ),
            const SizedBox(height: 16,),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              maxLength: 3,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: "Ayah Number",
                counterText: "",
              ),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return "Can't be empty";
                }

                if (!GetUtils.isNumericOnly(text)) {
                  return "Only Numeric Allowed";
                }
                int number = int.parse(text);
                if (number > 286) {
                  return "Invalid ayat number";
                }
                return null;
              },
              onChanged: (text) =>
                  jumpToAyahController.ayatNumber = int.tryParse(text) ?? 0,
            ),
          ],
        ),
      ),
    );
  }
}
