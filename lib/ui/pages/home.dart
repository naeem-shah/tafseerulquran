import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer_hafiz_abdusalam/ui/pages/index/index.dart';
import 'package:tafseer_hafiz_abdusalam/ui/widgets/home_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 120,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: HomeCardWidget(iconData: Icons.menu_book_outlined,title: "Last Read",),
                ),
                Container(
                  height: Get.height,
                    child: VerticalDivider(color: Colors.black54,width: 1,)),
                Expanded(
                  flex: 1,
                  child: HomeCardWidget(iconData: Icons.menu_book_outlined,title: "Surah",onTap: (){
                    Get.to(()=> QuranIndex(),arguments: true);
                    },),
                ),
              ],
            ),
          ),
          Divider(height: 0,color: Colors.black54,),
          Container(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: HomeCardWidget(iconData: Icons.menu_book_outlined,title: "Juz",onTap: (){
                      Get.to(()=> QuranIndex(),arguments: false);
                    },),
                  ),
                ),
                Container(
                    height: Get.height,
                    child: VerticalDivider(color: Colors.black54,width: 1,)),
                Expanded(
                  flex: 1,
                  child: HomeCardWidget(iconData: Icons.settings,title: "Settings",),
                ),
              ],
            ),
          ),
          Divider(height: 0,color: Colors.black54,),
          Container(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: HomeCardWidget(iconData: Icons.bookmark,title: "Bookmarks",),
                  ),
                ),
                Container(
                    height: Get.height,
                    child: VerticalDivider(color: Colors.black54,width: 1,)),
                Expanded(
                  flex: 1,
                  child: HomeCardWidget(iconData: Icons.info_outline,title: "Intoduction",),
                ),
              ],
            ),
          ),
          Divider(height: 0,color: Colors.black54,),
        ],
      ),
    );
  }
}
