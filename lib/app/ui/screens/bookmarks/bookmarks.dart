import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/controllers/bookmark_controller.dart';
import 'package:tafseer/app/models/ayat_model.dart';

import '../../widgets/ayat_bookmark_widget.dart';

class Bookmarks extends StatelessWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookmarkController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
      ),
      body: Obx(
        () {
          if (controller.ayahs.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (_, index) {
                final AyatModel ayatModel = controller.ayahs[index];
                return AyatBookmarkTile(
                  ayatModel: ayatModel,
                );
              },
              itemCount: controller.ayahs.length,
            );
          }

          if (controller.isLoading.value){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: Text("No bookmark added"),
          );
        },
      ),
    );
  }
}
