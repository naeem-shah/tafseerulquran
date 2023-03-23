import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:tafseer/app/controllers/home_quran_controller.dart';
import 'package:tafseer/app/routes/app_routes.dart';
import 'package:intl/intl.dart' as date_format;
import 'package:upgrader/upgrader.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../assets/custom_fonts.dart';
import '../../controllers/index/index_data_controller.dart';
import '../../services/local_notification_manager.dart';
import 'app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );
    final controller = Get.put(HomeQuranController());

    final config = AppcastConfiguration(
      url:
          "https://github.com/naeem-shah/files/blob/main/tafseerAppCast.xml?raw=true",
      supportedOS: ['android'],
    );
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
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade200,
      body: UpgradeAlert(
        upgrader: Upgrader(
          debugLogging: kDebugMode || kProfileMode,
          appcastConfig: config,
        ),
        child: SizedBox(
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
                                "${controller.hijri.hDay} ${controller.hijri.longMonthName}",
                                style: Get.textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                date_format.DateFormat("EEEE, dd-MMM-yy")
                                    .format(
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
                top: 240,
                left: 0,
                right: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () {
                          if (controller.dailyAyat.value != null) {
                            return Card(
                              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SelectableText(
                                      controller.dailyAyat.value!.ayat,
                                      style:
                                          Get.textTheme.headlineSmall?.copyWith(
                                        fontFamily: AppFonts.nooreHuda,
                                      ),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    SelectableText(
                                      "${controller.dailyAyat.value!.translation} [${Get.find<IndexDataController>()
                                              .getIndex(controller
                                                  .dailyAyat.value!.surahId)
                                              .name}]",
                                      style: Get.textTheme.titleLarge
                                          ?.copyWith(fontFamily: AppFonts.urdu),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: GestureDetector(
                            onTap: () {
                              launchUrlString(Constants.tarjumaChannel);
                            },
                            child: Image.asset(
                              "assets/images/home_banner.jpg",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                    child: AbsorbPointer(
                      child: TextFormField(
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          isCollapsed: true,
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Search",
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
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
      ),
      bottomNavigationBar: BottomAppBar(
        child: Card(
          color: Get.theme.primaryColor,
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: ListTile(
            onTap: () {
              Get.toNamed(AppRoutes.quranHome);
            },
            leading: Image.asset(
              "assets/images/quran.png",
              height: 40,
              color: Colors.white,
            ),
            title: Text(
              "Quran",
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
      ),
    );
  }
}
