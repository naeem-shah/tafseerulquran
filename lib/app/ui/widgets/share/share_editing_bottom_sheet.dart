import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/controllers/share_editing_controller.dart';

class ShareEditingBottomSheet extends StatelessWidget {
  final bool isQuran;
  final bool isTranslation;
  final bool isExplanation;

  ShareEditingBottomSheet({
    Key? key,
    this.isQuran = false,
    this.isTranslation = false,
    this.isExplanation = false,
  }) : super(key: key);

  final controller = Get.find<ShareEditingController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(
        16,
        12,
        16,
        8,
      ),
      children: [
        ListTile(
          title: const Text("Font Size"),
          contentPadding: EdgeInsets.zero,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onFontReduce,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                ),
                splashRadius: 18,
              ),
              Obx(() {
                return Text("$fontSize");
              }),
              IconButton(
                onPressed: onFontIncrease,
                icon: const Icon(
                  Icons.keyboard_arrow_up,
                ),
                splashRadius: 18,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          minLines: 2,
          textDirection: TextDirection.rtl,
          maxLines: null,
          initialValue: text,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          onChanged: onChange,
        ),
      ],
    );
  }

  String get text {
    if (isQuran) {
      return controller.quran.value;
    } else if (isTranslation) {
      return controller.translation.value;
    } else {
      return controller.explanation.value!;
    }
  }

  int get fontSize {
    if (isQuran) {
      return controller.quranFont.value;
    } else if (isTranslation) {
      return controller.translationFont.value;
    } else {
      return controller.explanationFont.value;
    }
  }

  void onChange(String text) {
    if (isQuran) {
      controller.quran.value = text;
    } else if (isTranslation) {
      controller.translation.value = text;
    } else {
      controller.explanation.value = text;
    }
  }

  void onFontIncrease() {
    if (isQuran) {
      if (controller.quranFont.value < 30) {
        controller.quranFont.value++;
      }
    } else if (isTranslation) {
      if (controller.translationFont.value < 30) {
        controller.translationFont.value++;
      }
    } else {
      if (controller.explanationFont.value < 30) {
        controller.explanationFont.value++;
      }
    }
  }

  void onFontReduce() {
    if (isQuran) {
      if (controller.quranFont.value > 10) {
        controller.quranFont.value--;
      }
    } else if (isTranslation) {
      if (controller.translationFont.value > 10) {
        controller.translationFont.value--;
      }
    } else {
      if (controller.explanationFont.value > 10) {
        controller.explanationFont.value--;
      }
    }
  }
}
