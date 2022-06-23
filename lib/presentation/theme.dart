import 'package:basic_template/basic_template.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player_test/utils/constants.dart';

class AppTheme {
  static setSystemOverlay() {
    if (kIsWeb) return;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  static ThemeData get theme => ThemeData.light().copyWith(
      inputDecorationTheme:
          const InputDecorationTheme(border: OutlineInputBorder()),
      textTheme: GoogleFonts.rubikTextTheme()
          .copyWith(caption: const TextStyle(fontSize: 10, color: Colors.grey)),
      platform: TargetPlatform.iOS,
      scaffoldBackgroundColor: mercuryGray,
      colorScheme: const ColorScheme.light().copyWith(primary: Colors.blue),
      sliderTheme: SliderThemeData(
          activeTrackColor: screaminGreen,
          thumbColor: screaminGreen,
          overlayShape: SliderComponentShape.noOverlay,
          trackHeight: 2,
          inactiveTrackColor: Colors.black26,
          thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 6, disabledThumbRadius: 6)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
      ));

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Colors.blue)),
      listTileTheme: const ListTileThemeData(
          textColor: Colors.white, iconColor: Colors.white),
      inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder()),
      textTheme: GoogleFonts.rubikTextTheme().copyWith(
          bodyText1: const TextStyle(color: Colors.white, fontSize: 12),
          caption: const TextStyle(color: Colors.white, fontSize: 10)),
      platform: TargetPlatform.iOS,
      scaffoldBackgroundColor: youtubeBlack,
      colorScheme: const ColorScheme.light().copyWith(primary: youtubeBlack),
      sliderTheme: SliderThemeData(
          activeTrackColor: Colors.red,
          thumbColor: Colors.red,
          overlayShape: SliderComponentShape.noOverlay,
          trackHeight: 2,
          inactiveTrackColor: Colors.black26,
          thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 6, disabledThumbRadius: 6)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey));
}
