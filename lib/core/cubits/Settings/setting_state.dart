import 'package:flutter/material.dart';

class SettingState {
  final Locale? locale;
  final ThemeMode themeMode;

  SettingState({
    required this.locale,
    required this.themeMode,
  });

  SettingState copyWith({
    Locale? locale,
    ThemeMode? themeMode,
  }) {
    return SettingState(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
