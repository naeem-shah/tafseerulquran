import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/controllers/reading/reading_controller.dart';

class QuranReading extends StatelessWidget {
  const QuranReading({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReadingController());

    return PopScope(
      onPopInvokedWithResult: (didPop, results) async {
        if (didPop) {
          return;
        }
        await controller.saveLastPage();

        Get.back();
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/images/quran.png",
            color: Colors.white,
            height: 48,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Obx(() {
            if (controller.assetInitialized.value) {
              return PageView.builder(
                controller: controller.pageController,
                onPageChanged: (int page) {
                  controller.pageNo.value = page;
                },
                itemBuilder: (_, index) {
                  final File file = controller.images[index];
                  return Image.file(
                    file,
                    fit: BoxFit.fill,
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  if (controller.pageNo.value < 547) {
                    controller.pageController.nextPage(
                      duration: controller.duration,
                      curve: controller.curve,
                    );
                  }
                },
                icon: const Icon(Icons.keyboard_arrow_left),
                splashRadius: 20,
              ),
              Obx(() {
                return Text("${controller.pageNo.value + 1}");
              }),
              IconButton(
                onPressed: () {
                  controller.pageController.previousPage(
                    duration: controller.duration,
                    curve: controller.curve,
                  );
                },
                icon: const Icon(Icons.keyboard_arrow_right),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
