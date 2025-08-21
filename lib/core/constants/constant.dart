import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import '../../features/home/presentation/views/note/note_view.dart';
import '../../features/home/presentation/views/task/task_view.dart';
import '../../generated/l10n.dart';

class AppConstants {
  static const mainLightColor = Color(0xff7e66ee);
  static const mainDarkColor = Color(0xffb5b2f4);

  static const colorScheme = Colors.purple;

// localization
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

  static bool isArabic() {
    return Intl.getCurrentLocale().startsWith('ar');
  }

// theme
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: colorScheme),
    useMaterial3: true,
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: colorScheme,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: mainDarkColor, brightness: Brightness.dark),
    useMaterial3: true,
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: colorScheme,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0,
    ),
  );

  // Images

  // splash view
  static const String imageSplashPath = 'assets/icons/jot&do_icon.png';

  static List<Color> splashColorsList = const [
    Color(0xffa724ec),
    Color(0xff9d33ef),
    Color(0xff8c4af4),
    Color(0xff8059f8),
  ];

  // Onboarding view
  static const String imageOnBoardingPath1 =
      'assets/images/onBoarding/on_boarding1.png';
  static const String imageOnBoardingPath2 =
      'assets/images/onBoarding/on_boarding2.png';
  static const String imageOnBoardingPath3 =
      'assets/images/onBoarding/on_boarding3.png';
  static int maxLengthOfContentNoteInHomeView = 500;
  // truncate the text
  static String getTruncatedText({required String text, int? maxLengthToDesc}) {
    maxLengthToDesc = maxLengthOfContentNoteInHomeView;
    if (text.length > maxLengthToDesc) {
      return text = "${text.substring(0, maxLengthToDesc - 3)}...";
    }
    return text;
  }

  // format datetime
  static String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('d/M/yyyy h:mm a');
    return formatter.format(dateTime);
  }

  // home
  static int homeBodyIndex = 0;

  static List<Widget> homeBodyList = const [
    NoteView(),
    TaskView(),
  ];

  // notes
  static final List<Color> noteColors = const [
    Color(0xff26C281),
    Color(0xff2CC7C9),
    Color(0xff25A4F2),
    Color(0xff5C6BC0),
    Color(0xffA76CE6),
    Color(0xffB2AA8E),
    Color(0xffE07BD2),
    Color(0xffF28EA0),
    Color(0xffDA5A48),
    Color(0xffF89B4C),
    Color(0xffF7DC3A),
    Color(0xffC8E6C9),
    Color(0xff676F54),
    Color(0xffFA9839),
    Color(0xffF9E23B),
    Color(0xff4DD0FC),
    Color(0xff4EF2C0),
    Color(0xffA0F51C),
  ];

  // add Note color
  static Color addNoteBGColor = noteColors[0];
  static double kRadius = 16;

  // note
  static const String notesStorage = 'notes';

  // settings
  static const String settingsStorage = 'settings';
}
