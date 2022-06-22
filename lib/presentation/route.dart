import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:video_player_test/domain/entities/video_details.dart';
import 'package:video_player_test/presentation/screens/login_screen/login_screen.dart';

import 'screens/navigation_screen/navigation_screen.dart';
import 'screens/video_player_screen/video_player_screen.dart';

class AppRoute {
  // Routes
  static const String initial = '/';
  static const String videoPlayerScreen = "/videoPlayerScreen";

  // onGenerateRoute
  static Route onGenerateRoute(RouteSettings settings) {
    final routeName = getRouteName(settings);
    final arguments = getArguments(settings);
    switch (routeName) {
      case initial:
        return MaterialPageRoute(
            settings: settings, builder: (context) => const NavigationScreen());
      case videoPlayerScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => VideoPlayerScreen(
                  videoDetails: arguments as VideoDetails,
                ));
      default:
        return MaterialPageRoute(builder: (context) => const Scaffold());
    }
  }

  static List<Route> onGenerateInitialRoute(String initialRoute) {
    return [
      MaterialPageRoute(
        builder: (context) => const AuthWrapper(),
      ),
    ];
  }
}
