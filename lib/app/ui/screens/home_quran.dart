import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as date_format;
import 'package:tafseer/app/controllers/home_quran_controller.dart';
import 'package:tafseer/app/controllers/jump_to_ayah_controller.dart';
import 'package:tafseer/app/routes/app_routes.dart';
import 'package:tafseer/app/services/preferences.dart';
import 'package:tafseer/app/ui/widgets/custom_grid_tile.dart';
import 'package:tafseer/app/ui/widgets/jump_to_ayah_dialog.dart';
import 'package:tafseer/app/ui/widgets/settings_bottom_sheet.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../assets/constants.dart';

class HomeQuran extends StatelessWidget {
  const HomeQuran({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeQuranController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
              ),
              onPressed: () {
                launchUrlString(
                  Constants.officialChannel,
                );
              },
              icon: const FaIcon(
                FontAwesomeIcons.youtube,
                color: Colors.red,
                size: 18,
              ),
              label: Text(
                "YouTube",
                style: Get.textTheme.bodyLarge?.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade200,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/home_bg.png',
                    fit: BoxFit.cover,
                  ),
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 3,
                        sigmaY: 3,
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        padding: const EdgeInsets.only(
                          top: 30,
                        ),
                        alignment: Alignment.center,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: ListTile(
                            title: Text(
                              "${controller.hijri.hDay} ${controller.hijri
                                  .longMonthName}",
                              style: Get.textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              date_format.DateFormat("EEEE, dd-MMM-yy").format(
                                controller.dateNow,
                              ),
                              style: Get.textTheme.titleSmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 175,
              left: 24,
              right: 24,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.search);
                  },
                  child: TextFormField(
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      isCollapsed: true,
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search",
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 250,
              left: 0,
              right: 0,
              bottom: 0,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2 / 1.5,
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: [
                  CustomGridTile(
                    imagePath: "assets/images/resume.png",
                    title: "Resume Reading",
                    onTap: onResume,
                  ),
                  CustomGridTile(
                    imagePath: "assets/images/quran.png",
                    title: "Read Quran",
                    onTap: () {
                      final bool hasDownloaded = Get.find<Preferences>()
                          .getBool(key: Constants.hasDownloaded) ??
                          false;
                      if (hasDownloaded) {
                        Get.toNamed(AppRoutes.indexesSimple);
                      } else {
                        Get.toNamed(AppRoutes.quranDownloading);
                      }
                    },
                  ),
                  CustomGridTile(
                    size: 50,
                    imagePath: "assets/images/surah.png",
                    title: "Surahs",
                    onTap: () {
                      Get.toNamed(AppRoutes.index, arguments: true);
                    },
                  ),
                  CustomGridTile(
                    imagePath: "assets/images/juz.png",
                    title: "Juz",
                    onTap: () {
                      Get.toNamed(AppRoutes.index, arguments: false);
                    },
                  ),
                  CustomGridTile(
                    imagePath: "assets/images/settings.png",
                    title: "Settings",
                    size: 40,
                    onTap: () => Get.bottomSheet(const SettingsBottomSheet()),
                  ),
                  CustomGridTile(
                    imagePath: "assets/images/launch.png",
                    title: "Jump to Ayah",
                    size: 40,
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Jump to Ayah',
                        content: const JumpToAyahDialog(),
                        backgroundColor: Colors.white,
                        onConfirm: (){
                          Get.find<JumpToAyahController>().jump();
                        },
                        textConfirm: "Go",
                        textCancel: "Cancel"
                      );
                    },
                  ),
                  CustomGridTile(
                    imagePath: "assets/images/bookmark.png",
                    title: "Bookmarks",
                    size: 40,
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.bookmarks,
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onResume() {
    int position = Get.find<Preferences>().getInt(
      key: Constants.recentPosition,
    ) ??
        0;
    int surahId = Get.find<Preferences>().getInt(
      key: Constants.recentSurahId,
    ) ??
        1;

    Get.toNamed(
      AppRoutes.ayat,
      arguments: {
        "isRecent": true,
        "scroll_position": position,
        "surah_id": surahId,
      },
    );
  }
}
