import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';

class SettingsController extends ChangeNotifier {
  final box = GetStorage();

  ThemeMode currentTheme = ThemeMode.light;
  SettingsController() {
    var theme = box.read("themeMode");
    currentTheme = ThemeMode.values[theme ?? 0];
    box.listenKey("themeMode", (value) {
      currentTheme = ThemeMode.values[value ?? 0];
      notifyListeners();
      Get.changeThemeMode(currentTheme);
    });
  }

  changeTheme(ThemeMode themeMode) {
    box.write("themeMode", themeMode.index);
  }
}
