import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_constants.dart';
import 'colors/smart_app_color.dart';

class AppTheme {
  // light theme
  static ThemeData getLightTheme(context) {
    var colors = SmartAppColor(context);
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: colors.primary),
      useMaterial3: true,
      fontFamily: 'Cairo',

      // scaffold
      scaffoldBackgroundColor: colors.backgroundScreen,
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: colors.backgroundScreen),
      // app bar light
      appBarTheme: AppBarTheme(
        backgroundColor: colors.backgroundScreen,
        foregroundColor: colors.primary,
        surfaceTintColor: colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        titleTextStyle: AppConstants.bodyLargeStyle(
          colors.textPrimary,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: 1,
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStatePropertyAll(colors.backgroundScreen),
      ),

      // colors light
    );
  }

  static ThemeData getDarkTheme(BuildContext context) {
    var colors = SmartAppColor(context);
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: colors.primary, brightness: Brightness.dark),
      useMaterial3: true,
      fontFamily: 'Cairo',

      // scaffold
      scaffoldBackgroundColor: colors.backgroundScreen,
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: colors.backgroundScreen),
      // app bar dark
      appBarTheme: AppBarTheme(
        backgroundColor: colors.backgroundScreen,
        foregroundColor: colors.primary,
        surfaceTintColor: colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        titleTextStyle: AppConstants.bodyLargeStyle(
          colors.textPrimary,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: 1,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStatePropertyAll(colors.backgroundScreen),
      ),
    );
  }
}
