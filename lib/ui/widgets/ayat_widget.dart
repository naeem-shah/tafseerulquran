import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:get/get.dart';
import 'package:tafseer_hafiz_abdusalam/assets/custom_fonts.dart';
import 'package:tafseer_hafiz_abdusalam/models/ayat_model.dart';

class AyatWidget extends StatelessWidget {
  final AyatModel ayatModel;
  final VoidCallback onBookmarkTap,onCopyTap,onShareTap;
  final bool translationVisible, tafsirVisible;

  const AyatWidget({Key key, @required this.ayatModel, this.onBookmarkTap, this.onCopyTap, this.onShareTap, this.translationVisible, this.tafsirVisible}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
          bottom: 8,left: 8,right: 8
      ),
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8,top: 12,bottom: 12),
                  child: Text(ayatModel.ayat,style: TextStyle(
                      fontSize: 20,fontFamily: CustomFonts.nooreHuda
                  ),textDirection: TextDirection.rtl,),
                ),

                translationVisible
                    ? Container(
                  width: Get.width,
                  color: Get.theme.primaryColor.withOpacity(0.05),
                  padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
                  child: Text(ayatModel.translation,style: TextStyle(
                      fontSize: 20,fontFamily: CustomFonts.urdu,
                    height: 1.7,
                  ),),
                )
                    :SizedBox(),

                ayatModel.tafsir.isNotEmpty && tafsirVisible
                    ? Padding(
                  padding: const EdgeInsets.only(top: 12,left: 8,right: 8,bottom: 12),
                  child: ParsedText(text: ayatModel.tafsir,
                    style: TextStyle(color: Colors.black,fontFamily: CustomFonts.urdu,height: 1.7,fontSize: 16),
                    selectable: true,
                    parse: [
                      // hawala jat
                      MatchText(
                        pattern: r"\[(.*?)\]",
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: CustomFonts.tradArabic,
                        ),
                        renderText: ({String str, String pattern}) {
                          Map<String, String> map = Map<String, String>();
                          RegExp customRegExp = RegExp(pattern);
                          Match match = customRegExp.firstMatch(str);
                          map['display'] = match.group(0);
                          return map;
                        },
                        onTap: (url) {
                        },
                      ),
                      // ayat text
                      MatchText(
                        pattern: r"{([^}]*)}",
                        style: TextStyle(
                            color: Colors.blue,
                            fontFamily: CustomFonts.nooreHuda
                        ),
                        renderText: ({String str, String pattern}) {
                          Map<String, String> map = Map<String, String>();
                          RegExp customRegExp = RegExp(pattern);
                          Match match = customRegExp.firstMatch(str);
                          map['display'] = match.group(1);
                          return map;
                        },
                        onTap: (url) {
                          // do something here with passed url
                        },
                      ),
                      // ayat text
                      MatchText(
                        pattern: r"«([^»]*)»",
                        style: TextStyle(
                            color: Colors.blue,
                            fontFamily: CustomFonts.nooreHuda
                        ),
                        renderText: ({String str, String pattern}) {
                          Map<String, String> map = Map<String, String>();
                          RegExp customRegExp = RegExp(pattern);
                          Match match = customRegExp.firstMatch(str);
                          map['display'] = match.group(0);
                          return map;
                        },
                        onTap: (url) {
                          // do something here with passed url
                        },
                      ),
                      // Break line
                      MatchText(
                        pattern: "¤",
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: CustomFonts.tradArabic,
                        ),
                        renderText: ({String str, String pattern}) {
                          Map<String, String> map = Map<String, String>();
                          map['display'] = "\n";
                          return map;
                        },
                        onTap: (url) {
                        },
                      ),
                    ],
                  ),
                )
                    : SizedBox(),
              ],
            ),
          ),
          Divider(height: 0,color: Colors.grey,),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: Icon(Icons.share), onPressed: onShareTap,

              ),
              IconButton(icon: Icon(Icons.copy), onPressed: onCopyTap,

              ),
              IconButton(icon: Icon(ayatModel.isBookmark ? Icons.star : Icons.star_outline), onPressed: onBookmarkTap,),
            ],
          )
        ],
      ),
    );
  }
}
