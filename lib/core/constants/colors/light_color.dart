import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppColorsLight implements AppColors {
  @override
  Color get primary => Colors.black;

  @override
  Color get backgroundScreen => Colors.white;
  @override
  Color get backgroundCard => const Color(0xFFF8F9FA);
  @override
  Color get backgroundMuted => const Color(0xFFECECF0);
  @override
  Color get backgroundSecondary => const Color(0xFFECECF0);

  @override
  Color get textPrimary => Colors.black;
  @override
  Color get textSecondary => const Color(0xFF717182);
  @override
  Color get textInverse => Colors.white;

  @override
  Color get buttonPrimary => Colors.black;
  @override
  Color get buttonTextPrimary => Colors.white;
  @override
  Color get buttonSecondary => const Color(0xFFECECF0);
  @override
  Color get buttonTextSecondary => Colors.black;

  @override
  Color get border => Colors.grey.withValues(alpha: 0.3);
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
  Color get grey => Colors.grey.shade800;
  @override
  Color get red => const Color(0xffff4d4d);
  @override
  Color get yellow => const Color(0xffffc107);
  @override
  Color get orange => const Color(0xffffa500);
  @override
  Color get amber => const Color(0xffffc107);
  @override
  Color get green => const Color(0xff26C281);
  @override
  Color get blue => const Color(0xff4fc3f7);

  @override
  Color get fillColor => Colors.grey.shade100;

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
  Color get reverseBackgroundColor => Colors.black;
  @override
  Color get reverseTextColor => Colors.white;
}
