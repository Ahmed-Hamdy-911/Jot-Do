import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';

class AppConstants {
  static const mainLightColor = Color(0xff7e66ee);
  static const mainDarkColor = Color(0xffb5b2f4);

  static const colorScheme = Colors.purple;

// localization
  static const supportedLocales = [
    Locale('en', ''),
    Locale('ar', ''),
  ];

  static Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates = [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback =
      (locale, supportedLocales) {
    if (locale == null) return supportedLocales.first;
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  };

  static bool isArabic() {
    return Intl.getCurrentLocale().startsWith('ar');
  }

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: colorScheme),
    useMaterial3: true,
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: colorScheme,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: mainDarkColor, brightness: Brightness.dark),
    useMaterial3: true,
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: colorScheme,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0,
    ),
  );

  // Images

  // splash view
  static const String imageSplashPath = 'assets/icons/jot&do_icon.png';

  static List<Color> splashColorsList = const [
    Color(0xffa724ec),
    Color(0xff9d33ef),
    Color(0xff8c4af4),
    Color(0xff8059f8),
  ];

  // Onboarding view
  static const String imageOnBoardingPath1 =
      'assets/images/onBoarding/on_boarding1.png';
  static const String imageOnBoardingPath2 =
      'assets/images/onBoarding/on_boarding2.png';
  static const String imageOnBoardingPath3 =
      'assets/images/onBoarding/on_boarding3.png';
}
