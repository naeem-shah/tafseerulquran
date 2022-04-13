import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(
              30.0,
            )),
          ),
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: Image.asset(
                  "assets/images/logo.png",
                  height: 50,
                ),
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(
                      30.0,
                    ),
                  ),
                ),
                accountName: const Text(
                  "Tafseer ul Quran Al Kareem",
                ),
                accountEmail: const Text(
                  "Abdus Salam bin Muhammad Bhutvi",
                ),
                margin: EdgeInsets.zero,
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.youtube,
                  color: Colors.red,
                ),
                title: const Text("Official channel"),
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () {
                  launch(Constants.officialChannel);
                },
              ),
              const Divider(
                height: 0,
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.youtube,
                  color: Colors.red,
                ),
                title: const Text("Tarjuma Tul Quran"),
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () {
                  launch(Constants.tarjumaChannel);
                },
              ),
              const Divider(
                height: 0,
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blueAccent,
                ),
                title: const Text("Facebook Page"),
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () async {
                  try {
                    bool launched = await launch("fb://page/300720972064443",
                        forceSafariVC: false);
                    if (!launched) {
                      await launch("https://www.facebook.com/300720972064443",
                          forceSafariVC: false);
                    }
                  } catch (e) {
                    await launch("https://www.facebook.com/300720972064443",
                        forceSafariVC: false);
                  }
                },
              ),
              const Divider(
                height: 0,
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.green.shade700,
                ),
                title: const Text("Whatsapp Group"),
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () {
                  launch(Constants.whatsappGroup);
                },
              ),
              const Divider(
                height: 0,
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.soundcloud,
                  color: Colors.red,
                ),
                title: const Text("Sound Cloud"),
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () {
                  launch(Constants.soundCloud);
                },
              ),
              const Divider(
                height: 0,
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.twitter,
                  color: Colors.blue,
                ),
                title: const Text("Twitter Official"),
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () async {
                  try {
                    bool launched = await launch(
                      "twitter://user?user_id=BhutviOfficial",
                      forceSafariVC: false,
                    );
                    if (!launched) {
                      await launch(
                        "https://twitter.com/search?q=BhutviOfficial",
                        forceSafariVC: false,
                      );
                    }
                  } catch (e) {
                    await launch(
                      "https://twitter.com/search?q=BhutviOfficial",
                      forceSafariVC: false,
                    );
                  }
                },
              ),
              const Divider(
                height: 0,
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.twitter,
                  color: Colors.blue,
                ),
                title: const Text("Twitter Tarjuma tul Quran"),
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () async {
                  try {
                    bool launched = await launch(
                      "twitter://user?user_id=AlQuranulKarem",
                      forceSafariVC: false,
                    );
                    if (!launched) {
                      await launch(
                        "https://twitter.com/search?q=AlQuranulKarem",
                        forceSafariVC: false,
                      );
                    }
                  } catch (e) {
                    await launch(
                      "https://twitter.com/search?q=AlQuranulKarem",
                      forceSafariVC: false,
                    );
                  }
                },
              ),
              const Divider(
                height: 0,
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.telegram,
                  color: Colors.blue,
                ),
                title: const Text("Telegram Channel"),
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () {
                  launch(Constants.telegram);
                },
              ),
              const Divider(
                height: 0,
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.circleInfo,
                  color: Colors.orange,
                ),
                title: const Text("Feedback/Complains"),
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () async {
                  try {
                    await launch(
                      "whatsapp://send?phone=+923000710483",
                      forceSafariVC: false,
                    );
                  } catch (e) {
                    Get.rawSnackbar(
                      backgroundColor: Colors.red,
                      message: "Whatsapp not installed",
                    );
                  }
                },
              ),
              const Divider(
                height: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
