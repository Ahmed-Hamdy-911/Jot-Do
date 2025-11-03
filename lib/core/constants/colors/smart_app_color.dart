import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/settings/presentation/cubits/setting_cubit.dart';
import 'app_colors.dart';
import 'light_color.dart';
import 'dark_color.dart';

class SmartAppColor extends AppColors {
  final BuildContext context;
  SmartAppColor(this.context);

  bool get _isDark =>
      context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
  AppColors get _colors => _isDark ? AppColorsDark() : AppColorsLight();
  List<Color> filterColors = [
    Colors.blue, // Top row - Blue
    Colors.green, // Top row - Green
    Colors.purple, // Top row - Purple
    Colors.orange, // Top row - Orange
    const Color(0xFF8B0000), // Bottom row - Red (on dark brown background)
    Colors.pink, // Bottom row - Pink (on dark brown background)
    const Color(0xFF4B0082), // Bottom row - Dark Purple (Indigo-ish)
    Colors.indigo, // Bottom row - Indigo
    Colors.teal, // Bottom row - Teal
    const Color(0xFF004D40), // Bottom row - Dark Teal (custom)
  ];
  @override
  Color get primary => _colors.primary;
  @override
  Color get backgroundScreen => _colors.backgroundScreen;
  @override
  Color get backgroundCard => _colors.backgroundCard;
  @override
  Color get backgroundMuted => _colors.backgroundMuted;
  @override
  Color get backgroundSecondary => _colors.backgroundSecondary;

  @override
  Color get textPrimary => _colors.textPrimary;
  @override
  Color get textSecondary => _colors.textSecondary;
  @override
  Color get textInverse => _colors.textInverse;

  @override
  Color get buttonPrimary => _colors.buttonPrimary;
  @override
  Color get buttonTextPrimary => _colors.buttonTextPrimary;
  @override
  Color get buttonSecondary => _colors.buttonSecondary;
  @override
  Color get buttonTextSecondary => _colors.buttonTextSecondary;

  @override
  Color get border => _colors.border;
  @override
  Color get danger => _colors.danger;
  @override
  Color get success => _colors.success;
  @override
  Color get warning => _colors.warning;
  @override
  Color get info => _colors.info;

  // ===== Theme Aware =====
  @override
  Color get grey => _colors.grey;
  @override
  Color get red => _colors.red;
  @override
  Color get yellow => _colors.yellow;
  @override
  Color get orange => _colors.orange;
  @override
  Color get amber => _colors.amber;
  @override
  Color get green => _colors.green;
  @override
  Color get blue => _colors.blue;
  @override
  Color get fillColor => _colors.fillColor;

  @override
  Color get black => _colors.black;
  @override
  Color get white => _colors.white;
  @override
  Color get white70 => _colors.white70;
  @override
  Color get transparent => _colors.transparent;

  // ===== Reverse =====
  @override
  Color get reverseBackgroundColor => _colors.reverseBackgroundColor;
  @override
  Color get reverseTextColor => _colors.reverseTextColor;
}
