import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTheme {
  // light theme
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.colorScheme),
    useMaterial3: true,
    fontFamily: 'Cairo',

    // scaffold
    scaffoldBackgroundColor: AppColor.scaffoldBGLightColor,

    // app bar light
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.transparentColor,
      foregroundColor: AppColor.blackColor,
      surfaceTintColor: AppColor.transparentColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColor.blackColor,
        fontSize: 17,
        fontFamily: 'Cairo',
      ),
    ),

    // colors light
    
  );

  // dark theme
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.mainDarkColor, brightness: Brightness.dark),
    useMaterial3: true,
    fontFamily: 'Cairo',

    // scaffold
    scaffoldBackgroundColor: AppColor.scaffoldBGDarkColor,

    // app bar dark
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.transparentColor,
      foregroundColor: AppColor.colorScheme.shade800,
      surfaceTintColor: AppColor.transparentColor,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0,
      titleTextStyle: const TextStyle(
        color: AppColor.blackColor,
        fontSize: 17,
        fontFamily: 'Cairo',
      ),
    ),
  );
}
