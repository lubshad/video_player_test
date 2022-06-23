import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:video_player_test/presentation/screens/settings_screen/settings_controller.dart';

import 'components/video_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    settings();
    return Scaffold(
      appBar: AppBar(),
      body: const VideoList(),
    );
  }

  settings() async {
    await Future.delayed(const Duration(milliseconds: 100));
    SettingsController settingsController = Get.find();
  }
}
