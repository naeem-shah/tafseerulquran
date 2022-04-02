import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/controllers/ayat/ayat_more_bottom_sheet_controller.dart';
import 'package:tafseer/app/models/ayat_model.dart';
import 'package:tafseer/app/ui/widgets/bottom_sheet_closing_widget.dart';


class AyatMoreBottomSheet extends StatelessWidget {
  const AyatMoreBottomSheet({Key? key, required this.ayat}) : super(key: key);

  final AyatModel ayat;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      MoreBottomSheetController(),
    );
    controller.ayat = ayat;

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
        child: ListView(
          shrinkWrap: true,
          children: [
            const BottomSheetClosingWidget(),
            ListTile(
              leading: const Icon(
                Icons.play_arrow,
                color: Colors.black54,
              ),
              title: const Text("Play Ayah"),
              onTap: controller.onPlay,
            ),
            ListTile(
              leading: Obx(() {
                return Icon(
                  ayat.isBookmark.value
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  color: Colors.black54,
                );
              }),
              title: const Text("Bookmark"),
              onTap: controller.onBookmark,
            ),
            ListTile(
              leading: const Icon(
                Icons.copy,
                color: Colors.black54,
              ),
              title: const Text("Copy"),
              onTap: controller.onCopy,
            ),
            ListTile(
              leading: const Icon(
                Icons.share,
                color: Colors.black54,
              ),
              title: const Text("Share only text"),
              onTap: controller.onShare,
            ),
            ListTile(
              leading: const Icon(
                Icons.image,
                color: Colors.black54,
              ),
              title: const Text("Share text with background"),
              onTap: controller.onShareAsImage,
            ),
          ],
        ),
      ),
    );
  }
}
