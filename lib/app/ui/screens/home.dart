import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/routes/app_routes.dart';
import 'package:tafseer/app/ui/widgets/home_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                Expanded(
                  child: HomeCardWidget(
                    iconData: Icons.menu_book_outlined,
                    title: "Surah",
                    onTap: () {
                      Get.toNamed(AppRoutes.index, arguments: true);
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height,
                  child: const VerticalDivider(
                    color: Colors.black54,
                    width: 1,
                  ),
                ),
                const Expanded(
                  child: HomeCardWidget(
                    iconData: Icons.menu_book_outlined,
                    title: "Last Read",
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
            color: Colors.black54,
          ),
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: HomeCardWidget(
                    iconData: Icons.search,
                    title: "Search",
                    onTap: () {
                      Get.toNamed(AppRoutes.search);
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height,
                  child: const VerticalDivider(
                    color: Colors.black54,
                    width: 1,
                  ),
                ),
                Expanded(
                  child: HomeCardWidget(
                    iconData: Icons.menu_book_outlined,
                    title: "Juz",
                    onTap: () {
                      Get.toNamed(AppRoutes.index, arguments: false);
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
            color: Colors.black54,
          ),
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: HomeCardWidget(
                    iconData: Icons.info_outline,
                    title: "Introduction",
                  ),
                ),
                SizedBox(
                  height: Get.height,
                  child: const VerticalDivider(
                    color: Colors.black54,
                    width: 1,
                  ),
                ),
                Expanded(
                  child: HomeCardWidget(
                    iconData: Icons.bookmark,
                    title: "Bookmarks",
                    onTap: () => Get.toNamed(AppRoutes.bookmarks),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
