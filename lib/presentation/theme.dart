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
      textTheme: GoogleFonts.rubikTextTheme(),
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
      inputDecorationTheme:
          const InputDecorationTheme(border: OutlineInputBorder()),
      textTheme: GoogleFonts.rubikTextTheme(),
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
      ));
}
