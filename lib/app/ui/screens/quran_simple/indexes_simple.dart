import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:tafseer/app/controllers/index/index_data_controller.dart';
import 'package:tafseer/app/routes/app_routes.dart';
import 'package:tafseer/app/services/preferences.dart';

import '../../../models/index_model.dart';
import '../../widgets/index_tile.dart';

class IndexesSimple extends StatelessWidget {
  const IndexesSimple({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IndexDataController>();

    int? recentPage = Get.find<Preferences>().getInt(key: Constants.recentPage);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/juz.png",
          color: Colors.white,
          height: 40,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (_, index) {
          final IndexModel indexModel = controller.juz[index];
          return IndexTile(
            indexModel: indexModel,
            onTap: () {
              Get.toNamed(
                AppRoutes.quranReading,
                arguments: pageNumbers[index],
              );
            },
          );
        },
        itemCount: controller.juz.length,
      ),
      bottomNavigationBar: recentPage != null
          ? BottomAppBar(
              child: Card(
                color: Get.theme.primaryColor,
                margin: EdgeInsets.zero,
                child: ListTile(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.quranReading,
                      arguments: recentPage,
                    );
                  },
                  leading: Image.asset(
                    "assets/images/quran.png",
                    height: 40,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Resume Reading",
                    style: Get.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : null,
    );
  }

  List<int> get pageNumbers => [
        0,
        19,
        37,
        55,
        73,
        91,
        109,
        127,
        145,
        163,
        181,
        199,
        217,
        235,
        253,
        271,
        289,
        307,
        325,
        343,
        361,
        379,
        397,
        415,
        433,
        451,
        469,
        487,
        507,
        527,
      ];
}
