import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';

class SettingsController extends ChangeNotifier {
  final box = GetStorage();

  ThemeMode currentTheme = ThemeMode.light;
  SettingsController() {
    var theme = box.read("themeMode");
    setTheme(theme);
    box.listenKey("themeMode", (value) {
      setTheme(value);
    });
  }

  setTheme(int? value) {
    currentTheme = ThemeMode.values[value ?? 0];
    Get.changeThemeMode(currentTheme);
  }

  changeTheme(ThemeMode themeMode) {
    box.write("themeMode", themeMode.index);
  }
}
