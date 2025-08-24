import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/constant.dart';
import '../../helper/cache_helper.dart';
import 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit()
      : super(
          SettingState(
            locale: CacheHelper.getData(key: AppConstants.localeKey) != null
                ? Locale(CacheHelper.getData(key: AppConstants.localeKey))
                : null,
            themeMode: CacheHelper.getData(key: AppConstants.themeKey) == 'dark'
                ? ThemeMode.dark
                : ThemeMode.light,
          ),
        );

  void toggleTheme() {
    final newTheme =
        state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    CacheHelper.saveData(
      key: AppConstants.themeKey,
      value: newTheme == ThemeMode.dark ? 'dark' : 'light',
    );

    emit(state.copyWith(themeMode: newTheme));
  }

  void toggleLanguage(Locale locale) {
    CacheHelper.saveData(
      key: AppConstants.localeKey,
      value: locale.languageCode,
    );

    emit(state.copyWith(locale: locale));
  }
}
