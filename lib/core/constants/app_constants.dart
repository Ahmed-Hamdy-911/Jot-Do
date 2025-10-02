import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../features/settings/data/models/language_model.dart';
import '../../generated/l10n.dart';

class AppConstants {
  // 👉 Typography scale

  static double scaledSp(double size) {
    if (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return size;
    }
    return size.sp;
  }

// Main app name/title - Used for the main headline "Smart Notes"
  static final double displayLarge = scaledSp(isArabic() ? 26 : 28.0);

// Section headings - For feature titles like "Works offline", "Auto sync & backup"
  static final double headlineLarge = scaledSp(22.0);
  static final double headlineMedium = scaledSp(isArabic() ? 18 : 20.0);

// Section subtitles - For secondary headings like "Your notes", "Your tasks"
  static final double headlineSmall = scaledSp(isArabic() ? 16 : 18.0);

// Large body text - For important descriptions and feature details
  static final double bodyLarge = scaledSp(isArabic() ? 13 : 16.0);

// Regular body text - Standard text size for most content
  static final double bodyMedium = scaledSp(isArabic() ? 11 : 14.0);

// Small body text - For secondary information and captions
  static final double bodySmall = scaledSp(12.0);

// Button text - Used for all button labels (Continue with Google, Sign in with Email)
  static final double buttonText = scaledSp(15.0);
  static final double buttonSmallText = scaledSp(12.0);

// Small captions - For terms and privacy policy text at the bottom
  static final double caption = scaledSp(10.0);

  static final double settingMedium = scaledSp(isArabic() ? 12 : 14.0);

  static final double largeSize = 25;
  // 👉 Font weights
  static const FontWeight fontLight = FontWeight.w300;
  static const FontWeight fontNormal = FontWeight.w400;
  static const FontWeight fontMedium = FontWeight.w500;
  static const FontWeight fontSemiBold = FontWeight.w600;
  static const FontWeight fontBold = FontWeight.w700;

  // 👉 Text styles with specific use cases

  /// Main app title - Used for the "Smart Notes" headline at the top
  /// Font: Bold, Size: 28.sp
  static TextStyle displayLargeStyle(Color color) => TextStyle(
        fontSize: displayLarge,
        fontWeight: fontBold,
        color: color,
        height: 1.2,
      );

  /// Feature section titles - For headings like "Works offline", "Auto sync & backup"
  /// Font: SemiBold, Size: 20.sp
  static TextStyle headlineMediumStyle(Color color) => TextStyle(
        fontSize: headlineMedium,
        fontWeight: fontSemiBold,
        color: color,
        height: 1.3,
      );
  static TextStyle headlineSmallStyle(Color color) => TextStyle(
        fontSize: headlineSmall,
        fontWeight: fontNormal,
        color: color,
        height: 1.3,
      );
  static TextStyle mediumAppNameStyle(Color color) => TextStyle(
        fontSize: headlineLarge,
        fontWeight: fontSemiBold,
        color: color,
        fontFamily: 'Kalam',
        letterSpacing: 0.1,
        height: 1,
      );
  static TextStyle largeAppNameStyle(Color color) => TextStyle(
        fontSize: largeSize,
        fontWeight: fontSemiBold,
        color: color,
        fontFamily: 'Kalam',
        letterSpacing: 0.2,
        height: 1,
      );

  /// Feature descriptions - The explanatory text under each feature title
  /// Font: Normal, Size: 16.sp
  static TextStyle bodyLargeStyle(Color color) => TextStyle(
        fontSize: bodyLarge,
        fontWeight: fontNormal,
        color: color,
        height: 1.4,
      );

  static TextStyle filterStyle(Color color) => TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: scaledSp(15),
      );

  /// Regular content text - Standard text for general content
  /// Font: Normal, Size: 14.sp
  static TextStyle bodyMediumStyle(Color color) => TextStyle(
        fontSize: bodyMedium,
        fontWeight: fontNormal,
        color: color,
        height: 1.4,
      );

  /// Secondary information - Less important text, metadata, hints
  /// Font: Normal, Size: 12.sp
  static TextStyle bodySmallStyle(Color color) => TextStyle(
        fontSize: bodySmall,
        fontWeight: fontNormal,
        color: color,
        height: 1.4,
      );

  /// Primary buttons - For main action buttons like "Continue with Google"
  /// Font: SemiBold, Size: 15.sp
  static TextStyle buttonPrimaryStyle(Color color) => TextStyle(
        fontSize: buttonSmallText,
        fontWeight: fontSemiBold,
        color: color,
        height: 1.2,
      );

  /// Secondary buttons - For less prominent buttons like "Continue without account"
  /// Font: Medium, Size: 15.sp
  static TextStyle buttonSecondaryStyle(Color color) => TextStyle(
        fontSize: buttonSmallText,
        fontWeight: fontMedium,
        color: color,
        height: 1.2,
      );
  static TextStyle settingItemsStyle(Color color) => TextStyle(
        fontSize: settingMedium,
        fontWeight: FontWeight.w600,
        color: color,
        height: 1,
      );

  /// Legal text - For terms of service and privacy policy at the bottom
  /// Font: Normal, Size: 10.sp
  static TextStyle captionStyle(Color color) => TextStyle(
        fontSize: caption,
        fontWeight: fontNormal,
        color: color,
        height: 1.3,
      );

  /// Email input text - Specific style for email input fields
  /// Font: Normal, Size: 14.sp
  static TextStyle inputStyle(Color color) => TextStyle(
        fontSize: bodyMedium,
        fontWeight: fontNormal,
        color: color,
      );

  /// Label text - For form labels and field titles
  /// Font: Medium, Size: 14.sp
  static TextStyle labelStyle(Color color) => TextStyle(
        fontSize: bodyMedium,
        fontWeight: fontMedium,
        color: color,
      );

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
    return Intl.getCurrentLocale() == 'ar';
  }

  // home
  static int homeBodyIndex = 0;

  static int maxLengthOfContentNoteInHomeView = 397;

  static double kRadius = 16;
  static double kMaterialButtonHeight = 55;
  static double kCheckBoxRadius = 5;

  // onboarding
  static const String onboardingFinished = 'onboardingFinished';

  // note
  static const String notesStorage = 'notes';
  static const String remoteNotesStorage = 'remote_notes';
  static const String privateNotesStorage = 'private_notes';
  static const String publicNotesStorage = 'public_notes';
  static const String sharedNotesStorage = 'shared_notes';

  // settings
  static const String settingsStorage = 'settings';
  // language
  static List<LanguageModel> languages = [
    LanguageModel(flag: "🇺🇸", key: "english", locale: "en"),
    LanguageModel(flag: "🇪🇬", key: "arabic", locale: "ar"),
  ];
  // theme
  static const themeKey = "theme";
  static const localeKey = "locale";

  // auth
  static const String userCollection = 'users';
  static const String isLoggedIn = 'isLoggedIn';
  static const String continueWithoutAccount = 'continueWithoutAccount';

  // backup
  static const String isAutoBackupAndSync = 'isAutoBackupAndSync';

  // sync
  static const String isSync = 'isSync';

  // backup and sync
  static const String BackupAndSync = 'BackupAndSync';

  // app service
  static var appService;

  // filter
  static const String filtersStorage = 'filters';
}
