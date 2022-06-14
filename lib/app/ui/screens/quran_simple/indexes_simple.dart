import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/controllers/index/index_data_controller.dart';
import 'package:tafseer/app/routes/app_routes.dart';

import '../../../models/index_model.dart';
import '../../widgets/index_tile.dart';

class IndexesSimple extends StatelessWidget {
  const IndexesSimple({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IndexDataController>();
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
