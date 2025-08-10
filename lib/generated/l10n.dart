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

  /// `Never let a thought slip away — jot down your ideas in seconds, anywhere, anytime.`
  String get onBoardingDesc1 {
    return Intl.message(
      'Never let a thought slip away — jot down your ideas in seconds, anywhere, anytime.',
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

  /// `Categorize, color-code, and set dates to keep your notes neat and easy to find.`
  String get onBoardingDesc2 {
    return Intl.message(
      'Categorize, color-code, and set dates to keep your notes neat and easy to find.',
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

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Welcome Back`
  String get welcome_back {
    return Intl.message(
      'Welcome Back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Login to continue`
  String get login_to_continue {
    return Intl.message(
      'Login to continue',
      name: 'login_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get remember_me {
    return Intl.message('Remember Me', name: 'remember_me', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Create an Account`
  String get create_account {
    return Intl.message(
      'Create an Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enter_email {
    return Intl.message(
      'Enter your email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enter_name {
    return Intl.message(
      'Enter your name',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enter_password {
    return Intl.message(
      'Enter your password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password again`
  String get enter_confirm_password {
    return Intl.message(
      'Enter your password again',
      name: 'enter_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Or continue with`
  String get or_continue_with {
    return Intl.message(
      'Or continue with',
      name: 'or_continue_with',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get google {
    return Intl.message(
      'Sign in with Google',
      name: 'google',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Apple`
  String get apple {
    return Intl.message(
      'Sign in with Apple',
      name: 'apple',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get dont_have_account {
    return Intl.message(
      'Don’t have an account?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get error_required_field {
    return Intl.message(
      'This field is required',
      name: 'error_required_field',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get error_invalid_email {
    return Intl.message(
      'Invalid email address',
      name: 'error_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get error_short_password {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'error_short_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get error_passwords_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'error_passwords_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Name must be at least 3 characters`
  String get error_short_name {
    return Intl.message(
      'Name must be at least 3 characters',
      name: 'error_short_name',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot start with a number`
  String get error_name_starts_with_number {
    return Intl.message(
      'Name cannot start with a number',
      name: 'error_name_starts_with_number',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot contain special characters`
  String get error_name_contains_special_characters {
    return Intl.message(
      'Name cannot contain special characters',
      name: 'error_name_contains_special_characters',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful`
  String get success_registration {
    return Intl.message(
      'Registration successful',
      name: 'success_registration',
      desc: '',
      args: [],
    );
  }

  /// `Login successful`
  String get success_login {
    return Intl.message(
      'Login successful',
      name: 'success_login',
      desc: '',
      args: [],
    );
  }

  /// `Logging in...`
  String get logging_in {
    return Intl.message(
      'Logging in...',
      name: 'logging_in',
      desc: '',
      args: [],
    );
  }

  /// `Registering...`
  String get registering {
    return Intl.message(
      'Registering...',
      name: 'registering',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `We will send you an email to change your password.`
  String get send_password_reset {
    return Intl.message(
      'We will send you an email to change your password.',
      name: 'send_password_reset',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Verify Your Email...`
  String get verify_email_title {
    return Intl.message(
      'Verify Your Email...',
      name: 'verify_email_title',
      desc: '',
      args: [],
    );
  }

  /// `We have sent you a link to verify your email address.\n to `
  String get verify_email_message {
    return Intl.message(
      'We have sent you a link to verify your email address.\n to ',
      name: 'verify_email_message',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_text {
    return Intl.message('Continue', name: 'continue_text', desc: '', args: []);
  }

  /// `Resend Code?`
  String get resend_code {
    return Intl.message(
      'Resend Code?',
      name: 'resend_code',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get back_to_login {
    return Intl.message(
      'Back to Login',
      name: 'back_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Happy to see you again!`
  String get login_excited_text {
    return Intl.message(
      'Happy to see you again!',
      name: 'login_excited_text',
      desc: '',
      args: [],
    );
  }

  /// `Create your account and unlock exclusive features.`
  String get register_excited_text {
    return Intl.message(
      'Create your account and unlock exclusive features.',
      name: 'register_excited_text',
      desc: '',
      args: [],
    );
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
