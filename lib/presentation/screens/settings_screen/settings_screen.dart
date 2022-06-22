import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:video_player_test/presentation/screens/settings_screen/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Get.find();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: AnimatedBuilder(
            animation: settingsController,
            builder: (context, child) {
              return ListView(
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        const Text("Dark Mode"),
                        const Spacer(),
                        Text(settingsController.currentTheme.name),
                        PopupMenuButton<ThemeMode>(
                            onSelected: (themeMode) =>
                                settingsController.changeTheme(themeMode),
                            icon: const Icon(Icons.arrow_drop_down),
                            itemBuilder: (context) => ThemeMode.values
                                .map((e) => PopupMenuItem(
                                    value: e, child: Text(e.name)))
                                .toList())
                      ],
                    ),
                  )
                ],
              );
            }));
  }

  void changeTheme(bool? value) {
    print(value);
  }
}
