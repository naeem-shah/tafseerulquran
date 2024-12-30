import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/enums.dart';
import 'package:tafseer/app/ui/widgets/bottom_sheet_closing_widget.dart';

class ShareTextBottomSheet extends StatelessWidget {
  const ShareTextBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              16,
            ),
          ),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {

            if (index == 0){
              return const BottomSheetClosingWidget();
            }
            ShareEnums eValue = ShareEnums.values[index-1];
            String value = EnumToString.convertToString(
              eValue,
              camelCase: true,
            );
            return ListTile(
              title: Text(value),
              onTap: ()=> Get.back(result: eValue),
            );
          },
          itemCount: ShareEnums.values.length + 1,
        ),
      ),
    );
  }
}
