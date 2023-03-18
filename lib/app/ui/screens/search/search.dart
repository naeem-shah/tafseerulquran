import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/controllers/search/search_controller.dart';
import 'package:tafseer/app/models/index_model.dart';
import 'package:tafseer/app/ui/widgets/ayat_search_tile.dart';
import 'package:tafseer/app/ui/widgets/bottom_sheet_closing_widget.dart';
import 'package:tafseer/app/ui/widgets/index_tile.dart';

import '../../../models/ayat_model.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.3,
        title: TextFormField(
          controller: controller.queryController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'یہاں لکھیں',
          ),
          style: const TextStyle(
            fontFamily: "Jameel",
            fontSize: 18,
          ),
          onFieldSubmitted: (_) => controller.applySearch(),
          onChanged: (_) => controller.search(),
        ),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.grey.shade300,
                spreadRadius: 3,
              ),
            ]),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                Obx(
                  () => ChoiceChip(
                    label: Text(
                      "In Explanation",
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: controller.inExplanation.value
                            ? Colors.white
                            : Get.theme.primaryColor,
                      ),
                    ),
                    selected: controller.inExplanation.value,
                    selectedColor: controller.inExplanation.value
                        ? Get.theme.primaryColor
                        : Colors.white,
                    onSelected: (value) {
                      controller.applySearch();
                      controller.inExplanation.value = value;
                    },
                  ),
                ),
                Obx(
                  () => ChoiceChip(
                    label: Text(
                      "In Translation",
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: controller.inTranslation.value
                            ? Colors.white
                            : Get.theme.primaryColor,
                      ),
                    ),
                    selected: controller.inTranslation.value,
                    selectedColor: controller.inTranslation.value
                        ? Get.theme.primaryColor
                        : Colors.white,
                    onSelected: (value) {
                      controller.applySearch();
                      controller.inTranslation.value = value;
                    },
                  ),
                ),
                Obx(
                  () => ChoiceChip(
                    label: Text(
                      "In Quran",
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: controller.inQuran.value
                            ? Colors.white
                            : Get.theme.primaryColor,
                      ),
                    ),
                    selected: controller.inQuran.value,
                    selectedColor: controller.inQuran.value
                        ? Get.theme.primaryColor
                        : Colors.white,
                    onSelected: (value) {
                      controller.applySearch();
                      controller.inQuran.value = value;
                    },
                  ),
                ),
                Obx(
                  () {
                    if (controller.selectedSurah.value != null) {
                      return Chip(
                        label: Text(
                          controller.selectedSurah.value!.name,
                          style: Get.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontFamily: "NooreHuda",
                          ),
                        ),
                        backgroundColor: Get.theme.primaryColor,
                        deleteIconColor: Colors.white,
                        onDeleted: () {
                          controller.applySearch();
                          controller.selectedSurah.value = null;
                        },
                      );
                    }
                    return ChoiceChip(
                      label: const Text(
                        "Surah",
                      ),
                      labelStyle: Get.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                      selected: true,
                      selectedColor: Get.theme.primaryColor,
                      onSelected: (value) async {
                        final IndexModel? indexModel = await Get.bottomSheet(
                          Column(
                            children: [
                              const Directionality(
                                textDirection: TextDirection.ltr,
                                child: BottomSheetClosingWidget(
                                  title: "Surahs",
                                ),
                              ),
                              Flexible(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                  ),
                                  itemBuilder: (_, index) {
                                    final IndexModel indexModel =
                                        controller.surahs[index];
                                    return IndexTile(
                                      indexModel: indexModel,
                                      onTap: () => Get.back(
                                        result: indexModel,
                                      ),
                                    );
                                  },
                                  itemCount: controller.surahs.length,
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.white,
                        );
                        if (indexModel != null) {
                          controller.selectedSurah.value = indexModel;
                          controller.applySearch();
                        }
                      },
                    );
                  },
                ),
                Obx(
                  () {
                    if (controller.selectedJuz.value != null) {
                      return Chip(
                        label: Text(
                          controller.selectedJuz.value!.name,
                          style: Get.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontFamily: "NooreHuda",
                          ),
                        ),
                        backgroundColor: Get.theme.primaryColor,
                        deleteIconColor: Colors.white,
                        onDeleted: () {
                          controller.applySearch();
                          controller.selectedJuz.value = null;
                        },
                      );
                    }
                    return ChoiceChip(
                      label: const Text(
                        "Juz",
                      ),
                      labelStyle: Get.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                      selected: true,
                      selectedColor: Get.theme.primaryColor,
                      onSelected: (value) async {
                        final IndexModel? indexModel = await Get.bottomSheet(
                          Column(
                            children: [
                              const Directionality(
                                textDirection: TextDirection.ltr,
                                child: BottomSheetClosingWidget(
                                  title: "Juz",
                                ),
                              ),
                              Flexible(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                  ),
                                  itemBuilder: (_, index) {
                                    final IndexModel indexModel =
                                        controller.juz[index];
                                    return IndexTile(
                                      indexModel: indexModel,
                                      onTap: () => Get.back(
                                        result: indexModel,
                                      ),
                                    );
                                  },
                                  itemCount: controller.surahs.length,
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.white,
                        );
                        if (indexModel != null) {
                          controller.selectedJuz.value = indexModel;
                          controller.applySearch();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.searches.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (_, index) {
                    final AyatModel ayatModel = controller.searches[index];
                    return AyatSearchTile(
                      ayatModel: ayatModel,
                      query: controller.queryController.text,
                    );
                  },
                  itemCount: controller.searches.length,
                );
              }
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (controller.isLoading.isFalse && controller.searches.isEmpty) {
                return const Center(
                  child: Text("No Record Found"),
                );
              }
              return const SizedBox.shrink();
            }),
          ),
        ],
      ),
    );
  }
}
