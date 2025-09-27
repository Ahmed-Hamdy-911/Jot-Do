import 'package:flutter/material.dart';

abstract class AppColors {
  /// Main brand color
  Color get primary;

  /// Backgrounds
  Color get backgroundScreen;
  Color get backgroundCard;
  Color get backgroundMuted;
  Color get backgroundSecondary;

  /// Text
  Color get textPrimary;
  Color get textSecondary;
  Color get textInverse;

  /// Buttons
  Color get buttonPrimary;
  Color get buttonTextPrimary;
  Color get buttonSecondary;
  Color get buttonTextSecondary;

  /// Borders & States
  Color get border;
  Color get danger;
  Color get success;
  Color get warning;
  Color get info;

  // ===== Theme Aware Colors =====
  Color get grey;
  Color get red;
  Color get yellow;
  Color get amber;
  Color get green;
  Color get blue;
  Color get fillColor;

  // ===== Colors (shared) =====
  Color get black;
  Color get white;
  Color get white70;
  Color get transparent;
  // ===== Reverse =====
  Color get reverseBackgroundColor;
  Color get reverseTextColor;
}
