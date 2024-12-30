import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/assets/custom_fonts.dart';
import 'package:tafseer/app/controllers/ayat/ayat_controller.dart';
import 'package:tafseer/app/controllers/settings_bottom_sheet_controller.dart';
import 'package:tafseer/app/models/ayat_model.dart';
import 'package:tafseer/app/ui/widgets/ayat_more_bottom_sheet.dart';

class AyatWidget extends StatelessWidget {
  final AyatModel ayatModel;

  const AyatWidget({
    super.key,
    required this.ayatModel,
  });

  @override
  Widget build(BuildContext context) {
    final settingController = Get.find<SettingsBottomSheetController>();
    final ayatController = Get.find<AyatController>();
    return Card(
      elevation: 2,
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Get.theme.primaryColor.withOpacity(0.6),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Get.bottomSheet(
                          AyatMoreBottomSheet(
                            ayat: ayatModel,
                          ),
                          isScrollControlled: true),
                      icon: const Icon(
                        Icons.more_vert_rounded,
                      ),
                      padding: EdgeInsets.zero,
                      splashRadius: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    ayatModel.ayatNo != 0
                        ? "${ayatController.surahs[ayatModel.surahId - 1].name}: ${ayatModel.ayatNo}"
                        : ayatController.surahs[ayatModel.surahId - 1].name,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.bodyMedium?.copyWith(
                      fontFamily: AppFonts.nooreHuda,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox.shrink(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Obx(
              () => SelectableText(
                ayatModel.ayat,
                style: TextStyle(
                  fontSize: settingController.fontQuran.value.toDouble(),
                  fontFamily: AppFonts.nooreHuda,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Obx(
              () => SelectableText(
                ayatModel.translation,
                style: TextStyle(
                  fontSize: settingController.fontTranslation.value.toDouble(),
                  fontFamily: AppFonts.urdu,
                  height: 1.7,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          if (!GetUtils.isNullOrBlank(ayatModel.tafsir)!)
            Obx(() {
              return Visibility(
                visible: settingController.explanationVisibility.value,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 8,
                    right: 8,
                    bottom: 12,
                  ),
                  child: ParsedText(
                    text: ayatModel.tafsir!,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppFonts.urdu,
                      height: 1.7,
                      fontSize:
                          settingController.fontExplanation.value.toDouble(),
                    ),
                    selectable: true,
                    parse: [
                      // hawala jat
                      MatchText(
                        pattern: r"\[(.*?)\]",
                        style: const TextStyle(
                          color: Colors.red,
                          fontFamily: AppFonts.tradArabic,
                        ),
                        renderText: ({
                          required String str,
                          required String pattern,
                        }) {
                          final Map<String, String> map = <String, String>{};
                          final RegExp customRegExp = RegExp(pattern);
                          final Match match = customRegExp.firstMatch(str)!;
                          map['display'] = match.group(0)!;
                          return map;
                        },
                        onTap: (url) {},
                      ),
                      // ayat text
                      MatchText(
                        pattern: "{([^}]*)}",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontFamily: AppFonts.nooreHuda,
                        ),
                        renderText: ({
                          required String str,
                          required String pattern,
                        }) {
                          final Map<String, String> map = <String, String>{};
                          final RegExp customRegExp = RegExp(pattern);
                          final Match? match = customRegExp.firstMatch(str);
                          if (match == null || match.groupCount < 3) {
                            return map;
                          }
                          map['display'] = match.group(3) ?? "";
                          return map;
                        },
                        onTap: (url) {
                          // do something here with passed url
                        },
                      ),
                      // ayat text
                      MatchText(
                        pattern: "«([^»]*)»",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontFamily: AppFonts.nooreHuda,
                        ),
                        renderText: ({
                          required String str,
                          required String pattern,
                        }) {
                          final Map<String, String> map = <String, String>{};
                          final RegExp customRegExp = RegExp(pattern);
                          final Match match = customRegExp.firstMatch(str)!;
                          map['display'] = match.group(0)!;
                          return map;
                        },
                        onTap: (url) {
                          // do something here with passed url
                        },
                      ),
                      // Break line
                      MatchText(
                        pattern: "¤",
                        style: const TextStyle(
                          color: Colors.red,
                          fontFamily: AppFonts.tradArabic,
                        ),
                        renderText: ({String? str, String? pattern}) {
                          final Map<String, String> map = <String, String>{};
                          map['display'] = "\n";
                          return map;
                        },
                        onTap: (url) {},
                      ),

                    ],
                  ),
                ),
              );
            })
        ],
      ),
    );
  }
}
