// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Jot&Do`
  String get appName {
    return Intl.message('Jot&Do', name: 'appName', desc: '', args: []);
  }

  /// `Welcome to Jot&Do`
  String get splashText1 {
    return Intl.message(
      'Welcome to Jot&Do',
      name: 'splashText1',
      desc: '',
      args: [],
    );
  }

  /// `Plan. Note. Do.`
  String get splashText2 {
    return Intl.message(
      'Plan. Note. Do.',
      name: 'splashText2',
      desc: '',
      args: [],
    );
  }

  /// `Organize Your Thoughts`
  String get onBoardingTitle1 {
    return Intl.message(
      'Organize Your Thoughts',
      name: 'onBoardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Write down everything on your mind and keep it all in one place.`
  String get onBoardingDesc1 {
    return Intl.message(
      'Write down everything on your mind and keep it all in one place.',
      name: 'onBoardingDesc1',
      desc: '',
      args: [],
    );
  }

  /// `Set Deadlines Easily`
  String get onBoardingTitle2 {
    return Intl.message(
      'Set Deadlines Easily',
      name: 'onBoardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Select start and end dates to never miss a task or note.`
  String get onBoardingDesc2 {
    return Intl.message(
      'Select start and end dates to never miss a task or note.',
      name: 'onBoardingDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Sync Your Notes`
  String get onBoardingTitle3 {
    return Intl.message(
      'Sync Your Notes',
      name: 'onBoardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Save your data locally or back it up to the cloud, all in one tap.`
  String get onBoardingDesc3 {
    return Intl.message(
      'Save your data locally or back it up to the cloud, all in one tap.',
      name: 'onBoardingDesc3',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get GetStarted {
    return Intl.message('Get Started', name: 'GetStarted', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
