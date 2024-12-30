import 'package:flutter/material.dart';
import 'package:tafseer/app/ui/widgets/settings_bottom_sheet.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings",),
      ),
      body: const SettingsBottomSheet(),
    );
  }
}
