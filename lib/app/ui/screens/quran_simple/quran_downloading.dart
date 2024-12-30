import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:tafseer/app/controllers/reading/quran_download_controller.dart';

class QuranDownloading extends StatelessWidget {
  QuranDownloading({super.key});
  final controller =
      Get.find<QuranDownloadController>(tag: Constants.hasDownloaded);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Downloading"),
      ),
      body: Center(
        child: Obx(
          () {
            if (controller.progress.value != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Please don't close the application.",
                      style: Get.textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Please Wait..."),
                            Text(
                              "${(controller.progress.value!).toStringAsFixed(2)} %",
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        LinearProgressIndicator(
                          value: controller.progress.value! / 100,
                          minHeight: 15,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Download 16 line quran by tap on Download button.",
                    style: Get.textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  ElevatedButton.icon(
                    onPressed: controller.downloadQuran,
                    icon: const Icon(Icons.download),
                    label: const Text("Download"),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
