import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tafseer/app/controllers/share_editing_controller.dart';
import 'package:tafseer/app/ui/widgets/share/share_editing_bottom_sheet.dart';

class ShareEditing extends StatelessWidget {
  const ShareEditing({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ShareEditingController(),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          "Editing",
        ),
        actions: [
          TextButton(
            // style: TextButton.styleFrom(
            //   foregroundColor: Colors.white,
            // ),
            onPressed: controller.onSave,
            child: const Text("SAVE"),
          ),
          TextButton(
            // style: TextButton.styleFrom(
            //   foregroundColor: Colors.white,
            // ),
            onPressed: controller.onShare,
            child: const Text("SHARE"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Screenshot(
              controller: controller.screenshotController,
              child: Obx(() {
                return Container(
                  padding: const EdgeInsets.fromLTRB(24, 60, 24, 38),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        controller.backgroundImage.value,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.reference.value,
                        style: Get.textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontFamily: "NooreHuda",
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Obx(
                                () {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.bottomSheet(
                                          ShareEditingBottomSheet(
                                            isQuran: true,
                                          ),
                                          backgroundColor: Colors.white);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        border: controller.quranSelected.value
                                            ? Border.all(
                                                color: Colors.white,
                                              )
                                            : null,
                                      ),
                                      child: AutoSizeText(
                                        controller.quran.value,
                                        style:
                                            Get.textTheme.titleMedium?.copyWith(
                                          color: Colors.black,
                                          fontFamily: "NooreHuda",
                                          height: 1.5,
                                          fontSize: controller.quranFont.value
                                              .toDouble(),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Flexible(
                              child: Obx(
                                () {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.bottomSheet(
                                          ShareEditingBottomSheet(
                                            isTranslation: true,
                                          ),
                                          backgroundColor: Colors.white);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        border:
                                            controller.translationSelected.value
                                                ? Border.all(
                                                    color: Colors.white,
                                                  )
                                                : null,
                                      ),
                                      child: AutoSizeText(
                                        controller.translation.value,
                                        style:
                                            Get.textTheme.titleMedium?.copyWith(
                                          color: Colors.black,
                                          fontFamily: "Jameel",
                                          height: 1.5,
                                          fontSize: controller
                                              .translationFont.value
                                              .toDouble(),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Obx(
                      //   () {
                      //     if (controller.explanation.value != null) {
                      //       return GestureDetector(
                      //         onTap: () {
                      //           Get.bottomSheet(
                      //             EditingBottomSheet(
                      //               isExplanation: true,
                      //             ),
                      //             backgroundColor: Colors.white,
                      //           );
                      //         },
                      //         child: Container(
                      //           padding: const EdgeInsets.symmetric(
                      //             horizontal: 4,
                      //             vertical: 6,
                      //           ),
                      //           decoration: BoxDecoration(
                      //             border: controller.explanationSelected.value
                      //                 ? Border.all(
                      //                     color: Colors.white,
                      //                   )
                      //                 : null,
                      //           ),
                      //           child: AutoSizeText(
                      //             controller.explanation.value!,
                      //             style: Get.textTheme.titleMedium?.copyWith(
                      //               color: Colors.white,
                      //               fontFamily: "Jameel",
                      //               fontSize: controller.explanationFont.value
                      //                   .toDouble(),
                      //             ),
                      //             textAlign: TextAlign.center,
                      //           ),
                      //         ),
                      //       );
                      //     }
                      //     return const SizedBox.shrink();
                      //   },
                      // ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: ButtonBar(
      //     alignment: MainAxisAlignment.start,
      //     children: [
      //       TextButton.icon(
      //         onPressed: () => Get.bottomSheet(
      //           const BackgroundChangeBottomSheet(),
      //           backgroundColor: Colors.white,
      //           barrierColor: Colors.black.withOpacity(0.3),
      //         ),
      //         icon: Obx(() {
      //           return CircleAvatar(
      //             radius: 17,
      //             backgroundImage: AssetImage(
      //               controller.backgroundImage.value,
      //             ),
      //           );
      //         }),
      //         label: const Text("Background"),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
