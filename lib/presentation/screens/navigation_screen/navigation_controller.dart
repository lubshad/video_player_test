import 'package:flutter/cupertino.dart';

import '../downloads_listing/downloads_listing.dart';
import '../home_screen/home_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../settings_screen/settings_screen.dart';

class NavigationController extends ChangeNotifier {
  Screens currentScreen = Screens.home;

  changeCurrentScreen(Screens screen) {
    currentScreen = screen;
    notifyListeners();
  }
}

enum Screens {
  home,
  downloads,
  profile,
  settings,
}

extension ScreenExtension on Screens {
  Widget get icon {
    switch (this) {
      case Screens.home:
        return const Icon(CupertinoIcons.home);
      case Screens.profile:
        return const Icon(CupertinoIcons.profile_circled);
      case Screens.settings:
        return const Icon(CupertinoIcons.settings);
      case Screens.downloads:
        return const Icon(CupertinoIcons.arrow_down_to_line_alt);
    }
  }

  String get label {
    switch (this) {
      case Screens.home:
        return 'home';
      case Screens.profile:
        return 'Profile';
      case Screens.settings:
        return 'Settings';
      case Screens.downloads:
        return 'Downloads';
    }
  }

  Widget get body {
    switch (this) {
      case Screens.home:
        return const HomeScreen();
      case Screens.profile:
        return const ProfileScreen();
      case Screens.settings:
        return const SettingsScreen();
      case Screens.downloads:
        return const DownloadsListing();
    }
  }
}

