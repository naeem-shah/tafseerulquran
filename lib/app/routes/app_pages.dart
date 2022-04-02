import 'package:get/get.dart';
import 'package:tafseer/app/routes/app_routes.dart';
import 'package:tafseer/app/ui/screens/ayat/ayat.dart';
import 'package:tafseer/app/ui/screens/bookmarks/bookmarks.dart';
import 'package:tafseer/app/ui/screens/editing/share_editing.dart';
import 'package:tafseer/app/ui/screens/home.dart';
import 'package:tafseer/app/ui/screens/home_quran.dart';
import 'package:tafseer/app/ui/screens/index/index.dart';
import 'package:tafseer/app/ui/screens/login.dart';
import 'package:tafseer/app/ui/screens/quran_simple/indexes_simple.dart';
import 'package:tafseer/app/ui/screens/quran_simple/quran_downloading.dart';
import 'package:tafseer/app/ui/screens/quran_simple/reading.dart';
import 'package:tafseer/app/ui/screens/search/search.dart';
import 'package:tafseer/app/ui/screens/settings.dart';
import 'package:tafseer/app/ui/screens/splash.dart';

final pages = [
  GetPage(name: AppRoutes.splash, page: () => const Splash()),
  GetPage(name: AppRoutes.home, page: () => const HomePage()),
  GetPage(name: AppRoutes.index, page: () => const QuranIndex()),
  GetPage(name: AppRoutes.ayat, page: () => const Ayat()),
  GetPage(name: AppRoutes.search, page: () => const Search()),
  GetPage(name: AppRoutes.bookmarks, page: () => const Bookmarks()),
  GetPage(name: AppRoutes.quranHome, page: () => const HomeQuran()),
  GetPage(name: AppRoutes.quranReading, page: () => const QuranReading()),
  GetPage(name: AppRoutes.login, page: () => const Login()),
  GetPage(name: AppRoutes.editShare, page: () => const ShareEditing()),
  GetPage(name: AppRoutes.settings, page: () => const Settings()),
  GetPage(name: AppRoutes.indexesSimple, page: () => const IndexesSimple()),
  GetPage(name: AppRoutes.quranDownloading, page: () => QuranDownloading()),
];
