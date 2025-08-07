import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../generated/l10n.dart';

class AppConstant {
  static const mainLightColor = Color(0xff7e66ee);
  static const mainDarkColor = Color(0xffb5b2f4);

  static const colorScheme = Colors.purple;

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

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: colorScheme),
    useMaterial3: true,
    fontFamily: 'Cairo',
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: mainDarkColor, brightness: Brightness.dark),
    useMaterial3: true,
    fontFamily: 'Cairo',
  );
}
