import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/controllers/index/index_controller.dart';
import 'package:tafseer/app/models/index_model.dart';
import 'package:tafseer/app/ui/widgets/index_tile.dart';

class QuranIndex extends StatelessWidget {
  const QuranIndex({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IndexController());

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          controller.isSurah
              ? "assets/images/surah.png"
              : "assets/images/juz.png",
          color: Colors.white,
          height: 40,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.indexes.isNotEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (_, index) {
              final IndexModel indexModel = controller.indexes[index];
              return IndexTile(
                indexModel: indexModel,
                onTap: () {
                  controller.navigate(index);
                },
              );
            },
            itemCount: controller.indexes.length,
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
