import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import '../../features/home/presentation/views/note/note_view.dart';
import '../../features/home/presentation/views/task/task_view.dart';
import '../../generated/l10n.dart';

class AppConstants {
// localization
  static const supportedLocales = [
    Locale("en", ''),
    Locale("ar", ''),
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

  // home
  static int homeBodyIndex = 0;
  static List<Widget> homeBodyList = const [
    NoteView(),
    TaskView(),
  ];
  static int maxLengthOfContentNoteInHomeView = 500;

  static double kRadius = 16;
  static double kMaterialButtonHeight = 55;

  // onboarding
  static const String onboardingFinished = 'onboardingFinished';

  // note
  static const String notesStorage = 'notes';
  static const String privateNotesStorage = 'private_notes';
  static const String publicNotesStorage = 'public_notes';
  static const String sharedNotesStorage = 'shared_notes';

  // settings
  static const String settingsStorage = 'settings';
  // theme
  static const themeKey = "theme";
  static const localeKey = "locale";

  // auth
  static const String userCollection = 'users';
  static const String isLoggedIn = 'isLoggedIn';
  static const String skipAuthentication = 'skipAuthentication';

  // backup 
  static const String isAutoBackup = 'isAutoBackup';
}
