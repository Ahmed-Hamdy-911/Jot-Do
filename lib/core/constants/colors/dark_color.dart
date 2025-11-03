import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppColorsDark implements AppColors {
  @override
  Color get primary => Colors.white;

  @override
  Color get backgroundScreen => const Color(0xFF0a0a0a);
  @override
  Color get backgroundCard => const Color(0xFF1E1E2C);
  @override
  Color get backgroundMuted => const Color(0xFF181818);
  @override
  Color get backgroundSecondary => const Color(0xFF262626);

  @override
  Color get textPrimary => Colors.white;
  @override
  Color get textSecondary => const Color(0xFFB0B0C0);
  @override
  Color get textInverse => Colors.black;

  @override
  Color get buttonPrimary => Colors.white;
  @override
  Color get buttonTextPrimary => Colors.black;
  @override
  Color get buttonSecondary => const Color(0xFF2D2D2D);
  @override
  Color get buttonTextSecondary => Colors.white;

  @override
  Color get border => const Color(0xFF2D2D2D);
  @override
  Color get danger => const Color(0xFFD4183D);
  @override
  Color get success => const Color(0xFF10B981);
  @override
  Color get warning => const Color(0xFFF59E0B);
  @override
  Color get info => const Color(0xFF3B82F6);

  // ===== Theme Aware =====
  @override
  Color get grey => Colors.grey.shade700;
  @override
  Color get red => const Color(0xffb00020);
  @override
  Color get yellow => const Color(0xffc0a800);
  @override
  Color get orange => const Color(0xffffa500);
  @override
  Color get amber => const Color(0xffc0a800);
  @override
  Color get green => const Color.fromARGB(255, 7, 122, 74);
  @override
  Color get blue => Colors.blue.shade900;
  @override
  @override
  Color get fillColor => const Color(0xff121212);

  @override
  Color get black => Colors.black;
  @override
  Color get white => Colors.white;
  @override
  Color get white70 => Colors.white70;
  @override
  Color get transparent => Colors.transparent;

  // ===== Reverse =====
  @override
  Color get reverseBackgroundColor => Colors.white;
  @override
  Color get reverseTextColor => Colors.black;
}
