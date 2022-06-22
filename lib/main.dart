import 'package:basic_template/basic_template.dart';
import 'package:video_player_test/presentation/screens/settings_screen/settings_controller.dart';

import 'utils/setup_app.dart';
import 'package:flutter/material.dart';
import 'presentation/route.dart';
import 'presentation/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  setupApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme.setSystemOverlay();
    SettingsController settingsController = Get.find();
    return GetMaterialApp(
      title: "Video Player",
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      onGenerateRoute: AppRoute.onGenerateRoute,
      onGenerateInitialRoutes: AppRoute.onGenerateInitialRoute,
      initialRoute: AppRoute.initial,
    );
  }
}
