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
    final name = (locale.countryCode?.isEmpty ?? false)
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

  /// `Jot & Do`
  String get appName {
    return Intl.message('Jot & Do', name: 'appName', desc: '', args: []);
  }

  /// `Your thoughts, organized and synced across all devices`
  String get appDescription {
    return Intl.message(
      'Your thoughts, organized and synced across all devices',
      name: 'appDescription',
      desc: '',
      args: [],
    );
  }

  /// `Works offline`
  String get worksOffline {
    return Intl.message(
      'Works offline',
      name: 'worksOffline',
      desc: '',
      args: [],
    );
  }

  /// `Access your notes anywhere, anytime`
  String get offlineDescription {
    return Intl.message(
      'Access your notes anywhere, anytime',
      name: 'offlineDescription',
      desc: '',
      args: [],
    );
  }

  /// `Auto sync & backup`
  String get autoSyncBackup {
    return Intl.message(
      'Auto sync & backup',
      name: 'autoSyncBackup',
      desc: '',
      args: [],
    );
  }

  /// `Never lose your important notes`
  String get syncDescription {
    return Intl.message(
      'Never lose your important notes',
      name: 'syncDescription',
      desc: '',
      args: [],
    );
  }

  /// `Secure & private`
  String get securePrivate {
    return Intl.message(
      'Secure & private',
      name: 'securePrivate',
      desc: '',
      args: [],
    );
  }

  /// `Your data is encrypted and protected`
  String get securityDescription {
    return Intl.message(
      'Your data is encrypted and protected',
      name: 'securityDescription',
      desc: '',
      args: [],
    );
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

  /// `Plan. Jot. Do.`
  String get splashText2 {
    return Intl.message(
      'Plan. Jot. Do.',
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

  /// `Never lose an idea again — capture your thoughts in seconds, anytime, anywhere.`
  String get onBoardingDesc1 {
    return Intl.message(
      'Never lose an idea again — capture your thoughts in seconds, anytime, anywhere.',
      name: 'onBoardingDesc1',
      desc: '',
      args: [],
    );
  }

  /// `Set Deadlines with Ease`
  String get onBoardingTitle2 {
    return Intl.message(
      'Set Deadlines with Ease',
      name: 'onBoardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Categorize, color-code, and set dates to keep your notes organized and accessible.`
  String get onBoardingDesc2 {
    return Intl.message(
      'Categorize, color-code, and set dates to keep your notes organized and accessible.',
      name: 'onBoardingDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Sync Across Devices`
  String get onBoardingTitle3 {
    return Intl.message(
      'Sync Across Devices',
      name: 'onBoardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Save locally or back up to the cloud — all with a single tap.`
  String get onBoardingDesc3 {
    return Intl.message(
      'Save locally or back up to the cloud — all with a single tap.',
      name: 'onBoardingDesc3',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Email`
  String get signInWithEmail {
    return Intl.message(
      'Sign in with Email',
      name: 'signInWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `Continue without account`
  String get continueWithoutAccount {
    return Intl.message(
      'Continue without account',
      name: 'continueWithoutAccount',
      desc: '',
      args: [],
    );
  }

  /// `By continuing, you agree to our Terms of Service and Privacy Policy`
  String get termsAgreement {
    return Intl.message(
      'By continuing, you agree to our Terms of Service and Privacy Policy',
      name: 'termsAgreement',
      desc: '',
      args: [],
    );
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

  /// `Good to see you again! Ready to be productive?`
  String get login_welcome {
    return Intl.message(
      'Good to see you again! Ready to be productive?',
      name: 'login_welcome',
      desc: '',
      args: [],
    );
  }

  /// `Create your account now and unlock powerful features!`
  String get register_welcome {
    return Intl.message(
      'Create your account now and unlock powerful features!',
      name: 'register_welcome',
      desc: '',
      args: [],
    );
  }

  /// `Don’t wait — log in now!`
  String get login_call_to_action {
    return Intl.message(
      'Don’t wait — log in now!',
      name: 'login_call_to_action',
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

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
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

  /// `Re-enter your password`
  String get enter_confirm_password {
    return Intl.message(
      'Re-enter your password',
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

  /// `Continue with Google`
  String get google {
    return Intl.message(
      'Continue with Google',
      name: 'google',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get apple {
    return Intl.message(
      'Continue with Apple',
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

  /// `Please enter a valid email`
  String get error_invalid_email {
    return Intl.message(
      'Please enter a valid email',
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

  /// `Name cannot exceed 20 characters`
  String get error_long_name {
    return Intl.message(
      'Name cannot exceed 20 characters',
      name: 'error_long_name',
      desc: '',
      args: [],
    );
  }

  /// `Name already exists`
  String get error_name_already_exists {
    return Intl.message(
      'Name already exists',
      name: 'error_name_already_exists',
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

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Are you sure you want to sign out? Your local notes will remain on this device, but you won't be able to sync with other devices until you sign back in.`
  String get signOutConfirmation {
    return Intl.message(
      'Are you sure you want to sign out? Your local notes will remain on this device, but you won\'t be able to sync with other devices until you sign back in.',
      name: 'signOutConfirmation',
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

  /// `We’ll send you an email to reset your password.`
  String get send_password_reset {
    return Intl.message(
      'We’ll send you an email to reset your password.',
      name: 'send_password_reset',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Verify Your Email`
  String get verify_email_title {
    return Intl.message(
      'Verify Your Email',
      name: 'verify_email_title',
      desc: '',
      args: [],
    );
  }

  /// `We’ve sent a verification link to your email:\n`
  String get verify_email_message {
    return Intl.message(
      'We’ve sent a verification link to your email:\n',
      name: 'verify_email_message',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_text {
    return Intl.message('Continue', name: 'continue_text', desc: '', args: []);
  }

  /// `Resend email?`
  String get resend_code {
    return Intl.message(
      'Resend email?',
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

  /// `Sign up and unlock exclusive features.`
  String get register_excited_text {
    return Intl.message(
      'Sign up and unlock exclusive features.',
      name: 'register_excited_text',
      desc: '',
      args: [],
    );
  }

  /// `Your Notes`
  String get your_notes {
    return Intl.message('Your Notes', name: 'your_notes', desc: '', args: []);
  }

  /// `Note Details`
  String get note_details {
    return Intl.message(
      'Note Details',
      name: 'note_details',
      desc: '',
      args: [],
    );
  }

  /// `Created at: `
  String get created_at {
    return Intl.message('Created at: ', name: 'created_at', desc: '', args: []);
  }

  /// `Last updated: `
  String get last_updated {
    return Intl.message(
      'Last updated: ',
      name: 'last_updated',
      desc: '',
      args: [],
    );
  }

  /// `Add Note`
  String get add_note {
    return Intl.message('Add Note', name: 'add_note', desc: '', args: []);
  }

  /// `Note Title`
  String get note_title {
    return Intl.message('Note Title', name: 'note_title', desc: '', args: []);
  }

  /// `Note Content`
  String get note_content {
    return Intl.message(
      'Note Content',
      name: 'note_content',
      desc: '',
      args: [],
    );
  }

  /// `Save Note`
  String get save_note {
    return Intl.message('Save Note', name: 'save_note', desc: '', args: []);
  }

  /// `Update Note`
  String get update_note {
    return Intl.message('Update Note', name: 'update_note', desc: '', args: []);
  }

  /// `Delete Note`
  String get delete_note {
    return Intl.message('Delete Note', name: 'delete_note', desc: '', args: []);
  }

  /// `Note saved successfully`
  String get note_saved {
    return Intl.message(
      'Note saved successfully',
      name: 'note_saved',
      desc: '',
      args: [],
    );
  }

  /// `Note deleted successfully`
  String get note_deleted {
    return Intl.message(
      'Note deleted successfully',
      name: 'note_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Note updated successfully`
  String get note_updated {
    return Intl.message(
      'Note updated successfully',
      name: 'note_updated',
      desc: '',
      args: [],
    );
  }

  /// `No notes found`
  String get no_notes_found {
    return Intl.message(
      'No notes found',
      name: 'no_notes_found',
      desc: '',
      args: [],
    );
  }

  /// `Search notes`
  String get search_notes {
    return Intl.message(
      'Search notes',
      name: 'search_notes',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Add note or task`
  String get add_note_or_task {
    return Intl.message(
      'Add note or task',
      name: 'add_note_or_task',
      desc: '',
      args: [],
    );
  }

  /// `Choose note color`
  String get selectColorNote {
    return Intl.message(
      'Choose note color',
      name: 'selectColorNote',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message('Notes', name: 'notes', desc: '', args: []);
  }

  /// `Tasks`
  String get tasks {
    return Intl.message('Tasks', name: 'tasks', desc: '', args: []);
  }

  /// `Search notes...`
  String get search_note {
    return Intl.message(
      'Search notes...',
      name: 'search_note',
      desc: '',
      args: [],
    );
  }

  /// `Search tasks...`
  String get search_task {
    return Intl.message(
      'Search tasks...',
      name: 'search_task',
      desc: '',
      args: [],
    );
  }

  /// `Your Tasks`
  String get your_tasks {
    return Intl.message('Your Tasks', name: 'your_tasks', desc: '', args: []);
  }

  /// `Add Task`
  String get add_task {
    return Intl.message('Add Task', name: 'add_task', desc: '', args: []);
  }

  /// `Task Title`
  String get task_title {
    return Intl.message('Task Title', name: 'task_title', desc: '', args: []);
  }

  /// `Task Description`
  String get task_description {
    return Intl.message(
      'Task Description',
      name: 'task_description',
      desc: '',
      args: [],
    );
  }

  /// `Due Date`
  String get task_due_date {
    return Intl.message('Due Date', name: 'task_due_date', desc: '', args: []);
  }

  /// `Save Task`
  String get save_task {
    return Intl.message('Save Task', name: 'save_task', desc: '', args: []);
  }

  /// `Edit Task`
  String get edit_task {
    return Intl.message('Edit Task', name: 'edit_task', desc: '', args: []);
  }

  /// `Delete Task`
  String get delete_task {
    return Intl.message('Delete Task', name: 'delete_task', desc: '', args: []);
  }

  /// `Task saved successfully`
  String get task_saved {
    return Intl.message(
      'Task saved successfully',
      name: 'task_saved',
      desc: '',
      args: [],
    );
  }

  /// `Task deleted successfully`
  String get task_deleted {
    return Intl.message(
      'Task deleted successfully',
      name: 'task_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Task updated successfully`
  String get task_updated {
    return Intl.message(
      'Task updated successfully',
      name: 'task_updated',
      desc: '',
      args: [],
    );
  }

  /// `No tasks found`
  String get no_tasks_found {
    return Intl.message(
      'No tasks found',
      name: 'no_tasks_found',
      desc: '',
      args: [],
    );
  }

  /// `Task completed`
  String get task_completed {
    return Intl.message(
      'Task completed',
      name: 'task_completed',
      desc: '',
      args: [],
    );
  }

  /// `Task archived`
  String get task_archived {
    return Intl.message(
      'Task archived',
      name: 'task_archived',
      desc: '',
      args: [],
    );
  }

  /// `Task pending`
  String get task_pending {
    return Intl.message(
      'Task pending',
      name: 'task_pending',
      desc: '',
      args: [],
    );
  }

  /// `In progress`
  String get task_in_progress {
    return Intl.message(
      'In progress',
      name: 'task_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Appearance`
  String get appearance {
    return Intl.message('Appearance', name: 'appearance', desc: '', args: []);
  }

  /// `Sync & Backup`
  String get sync_and_backup {
    return Intl.message(
      'Sync & Backup',
      name: 'sync_and_backup',
      desc: '',
      args: [],
    );
  }

  /// `Auto Sync`
  String get autoSync {
    return Intl.message('Auto Sync', name: 'autoSync', desc: '', args: []);
  }

  /// `Auto Backup`
  String get autoBackup {
    return Intl.message('Auto Backup', name: 'autoBackup', desc: '', args: []);
  }

  /// `Automatically sync notes and tasks to your device when online.`
  String get autoSyncDescription {
    return Intl.message(
      'Automatically sync notes and tasks to your device when online.',
      name: 'autoSyncDescription',
      desc: '',
      args: [],
    );
  }

  /// `Automatically backup notes and tasks to the cloud.`
  String get autoBackupDescription {
    return Intl.message(
      'Automatically backup notes and tasks to the cloud.',
      name: 'autoBackupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Backup & Restore`
  String get backup_and_restore {
    return Intl.message(
      'Backup & Restore',
      name: 'backup_and_restore',
      desc: '',
      args: [],
    );
  }

  /// `Filter Notes`
  String get filter_notes {
    return Intl.message(
      'Filter Notes',
      name: 'filter_notes',
      desc: '',
      args: [],
    );
  }

  /// `Filter Tasks`
  String get filter_tasks {
    return Intl.message(
      'Filter Tasks',
      name: 'filter_tasks',
      desc: '',
      args: [],
    );
  }

  /// `DEFAULT FILTERS`
  String get default_filters {
    return Intl.message(
      'DEFAULT FILTERS',
      name: 'default_filters',
      desc: '',
      args: [],
    );
  }

  /// `CUSTOM FILTERS`
  String get custom_filters {
    return Intl.message(
      'CUSTOM FILTERS',
      name: 'custom_filters',
      desc: '',
      args: [],
    );
  }

  /// `Add Filter`
  String get add_filter {
    return Intl.message('Add Filter', name: 'add_filter', desc: '', args: []);
  }

  /// `Create Note Filter`
  String get createNoteFilter {
    return Intl.message(
      'Create Note Filter',
      name: 'createNoteFilter',
      desc: '',
      args: [],
    );
  }

  /// `Create a custom filter to organize your notes by specific criteria.`
  String get createFilterDescription {
    return Intl.message(
      'Create a custom filter to organize your notes by specific criteria.',
      name: 'createFilterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Filter Name`
  String get filterName {
    return Intl.message('Filter Name', name: 'filterName', desc: '', args: []);
  }

  /// `e.g., Work, Personal`
  String get filterNamePlaceholder {
    return Intl.message(
      'e.g., Work, Personal',
      name: 'filterNamePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `/20 characters`
  String get charactersCounter {
    return Intl.message(
      '/20 characters',
      name: 'charactersCounter',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message('Color', name: 'color', desc: '', args: []);
  }

  /// `Preview`
  String get preview {
    return Intl.message('Preview', name: 'preview', desc: '', args: []);
  }

  /// `Filter Name`
  String get previewFilterName {
    return Intl.message(
      'Filter Name',
      name: 'previewFilterName',
      desc: '',
      args: [],
    );
  }

  /// `Create Filter`
  String get createFilter {
    return Intl.message(
      'Create Filter',
      name: 'createFilter',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get filter_all {
    return Intl.message('All', name: 'filter_all', desc: '', args: []);
  }

  /// `New`
  String get filter_new {
    return Intl.message('New', name: 'filter_new', desc: '', args: []);
  }

  /// `Favorites`
  String get filter_favorite {
    return Intl.message(
      'Favorites',
      name: 'filter_favorite',
      desc: '',
      args: [],
    );
  }

  /// `Highlights`
  String get filter_highlight {
    return Intl.message(
      'Highlights',
      name: 'filter_highlight',
      desc: '',
      args: [],
    );
  }

  /// `Archived`
  String get filter_archived {
    return Intl.message(
      'Archived',
      name: 'filter_archived',
      desc: '',
      args: [],
    );
  }

  /// `Pinned`
  String get filter_pined {
    return Intl.message('Pinned', name: 'filter_pined', desc: '', args: []);
  }

  /// `Pin`
  String get pin {
    return Intl.message('Pin', name: 'pin', desc: '', args: []);
  }

  /// `Unpin`
  String get un_pin {
    return Intl.message('Unpin', name: 'un_pin', desc: '', args: []);
  }

  /// `Archive`
  String get archive {
    return Intl.message('Archive', name: 'archive', desc: '', args: []);
  }

  /// `Unarchive`
  String get un_archive {
    return Intl.message('Unarchive', name: 'un_archive', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Backup & Sync`
  String get backup_sync {
    return Intl.message(
      'Backup & Sync',
      name: 'backup_sync',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Push Notifications`
  String get push_notification {
    return Intl.message(
      'Push Notifications',
      name: 'push_notification',
      desc: '',
      args: [],
    );
  }

  /// `Receive notifications for new notes and tasks.`
  String get push_notification_description {
    return Intl.message(
      'Receive notifications for new notes and tasks.',
      name: 'push_notification_description',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `About App`
  String get about_app {
    return Intl.message('About App', name: 'about_app', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `No notes yet!`
  String get no_notes_yet {
    return Intl.message(
      'No notes yet!',
      name: 'no_notes_yet',
      desc: '',
      args: [],
    );
  }

  /// `No tasks yet!`
  String get no_tasks_yet {
    return Intl.message(
      'No tasks yet!',
      name: 'no_tasks_yet',
      desc: '',
      args: [],
    );
  }

  /// `Please login first`
  String get please_login_first {
    return Intl.message(
      'Please login first',
      name: 'please_login_first',
      desc: '',
      args: [],
    );
  }

  /// `Delete All Data`
  String get delete_all_data {
    return Intl.message(
      'Delete All Data',
      name: 'delete_all_data',
      desc: '',
      args: [],
    );
  }

  /// `This action will delete all your data permanently.`
  String get warn_delete_1 {
    return Intl.message(
      'This action will delete all your data permanently.',
      name: 'warn_delete_1',
      desc: '',
      args: [],
    );
  }

  /// `More Options`
  String get more_options {
    return Intl.message(
      'More Options',
      name: 'more_options',
      desc: '',
      args: [],
    );
  }

  /// `More Details`
  String get more_details {
    return Intl.message(
      'More Details',
      name: 'more_details',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete all data?`
  String get warn_delete_all_data {
    return Intl.message(
      'Are you sure you want to delete all data?',
      name: 'warn_delete_all_data',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `All data deleted successfully`
  String get delete_all_data_success {
    return Intl.message(
      'All data deleted successfully',
      name: 'delete_all_data_success',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete data`
  String get delete_all_data_failed {
    return Intl.message(
      'Failed to delete data',
      name: 'delete_all_data_failed',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get error {
    return Intl.message(
      'Something went wrong',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Info`
  String get info {
    return Intl.message('Info', name: 'info', desc: '', args: []);
  }

  /// `Warning`
  String get warning {
    return Intl.message('Warning', name: 'warning', desc: '', args: []);
  }

  /// `No internet connection`
  String get noInternet {
    return Intl.message(
      'No internet connection',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `Internet connection restored`
  String get connectedInternet {
    return Intl.message(
      'Internet connection restored',
      name: 'connectedInternet',
      desc: '',
      args: [],
    );
  }

  /// `Automatic backup & sync`
  String get automatically_backup_sync {
    return Intl.message(
      'Automatic backup & sync',
      name: 'automatically_backup_sync',
      desc: '',
      args: [],
    );
  }

  /// `Enable`
  String get enable {
    return Intl.message('Enable', name: 'enable', desc: '', args: []);
  }

  /// `Disable`
  String get disable {
    return Intl.message('Disable', name: 'disable', desc: '', args: []);
  }

  /// `This note hasn’t been synced yet.`
  String get note_not_synced {
    return Intl.message(
      'This note hasn’t been synced yet.',
      name: 'note_not_synced',
      desc: '',
      args: [],
    );
  }

  /// `Automatically`
  String get automatically {
    return Intl.message(
      'Automatically',
      name: 'automatically',
      desc: '',
      args: [],
    );
  }

  /// `Not yet`
  String get not_yet {
    return Intl.message('Not yet', name: 'not_yet', desc: '', args: []);
  }

  /// `Never`
  String get never {
    return Intl.message('Never', name: 'never', desc: '', args: []);
  }

  /// `Every 5 minutes`
  String get every_5_minutes {
    return Intl.message(
      'Every 5 minutes',
      name: 'every_5_minutes',
      desc: '',
      args: [],
    );
  }

  /// `Every 12 hours`
  String get every_12_hour {
    return Intl.message(
      'Every 12 hours',
      name: 'every_12_hour',
      desc: '',
      args: [],
    );
  }

  /// `Every day`
  String get every_1_day {
    return Intl.message('Every day', name: 'every_1_day', desc: '', args: []);
  }

  /// `Every week`
  String get every_1_week {
    return Intl.message('Every week', name: 'every_1_week', desc: '', args: []);
  }

  /// `Every month`
  String get every_1_month {
    return Intl.message(
      'Every month',
      name: 'every_1_month',
      desc: '',
      args: [],
    );
  }

  /// `Every year`
  String get every_1_year {
    return Intl.message('Every year', name: 'every_1_year', desc: '', args: []);
  }

  /// `Backup synced successfully`
  String get backup_synced_successfully {
    return Intl.message(
      'Backup synced successfully',
      name: 'backup_synced_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Backup sync failed`
  String get backup_synced_failed {
    return Intl.message(
      'Backup sync failed',
      name: 'backup_synced_failed',
      desc: '',
      args: [],
    );
  }

  /// `Keep your notes safe`
  String get sync_banner_title {
    return Intl.message(
      'Keep your notes safe',
      name: 'sync_banner_title',
      desc: '',
      args: [],
    );
  }

  /// `Enable sync to backup your notes online`
  String get sync_banner_subtitle {
    return Intl.message(
      'Enable sync to backup your notes online',
      name: 'sync_banner_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Enable Sync`
  String get sync_banner_enable {
    return Intl.message(
      'Enable Sync',
      name: 'sync_banner_enable',
      desc: '',
      args: [],
    );
  }

  /// `Ignore`
  String get sync_banner_ignore {
    return Intl.message(
      'Ignore',
      name: 'sync_banner_ignore',
      desc: '',
      args: [],
    );
  }

  /// `Backup found — restoring your notes...`
  String get restoringBackup {
    return Intl.message(
      'Backup found — restoring your notes...',
      name: 'restoringBackup',
      desc: '',
      args: [],
    );
  }

  /// `⚠️ You have unsynced notes. Enable auto-backup first.`
  String get unsyncedNotesMessage {
    return Intl.message(
      '⚠️ You have unsynced notes. Enable auto-backup first.',
      name: 'unsyncedNotesMessage',
      desc: '',
      args: [],
    );
  }

  /// `Coming soon`
  String get comingSoon {
    return Intl.message('Coming soon', name: 'comingSoon', desc: '', args: []);
  }

  /// `Profile update failed`
  String get profile_updated_failed {
    return Intl.message(
      'Profile update failed',
      name: 'profile_updated_failed',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profile_updated_success {
    return Intl.message(
      'Profile updated successfully',
      name: 'profile_updated_success',
      desc: '',
      args: [],
    );
  }

  /// `Sync Now`
  String get syncNow {
    return Intl.message('Sync Now', name: 'syncNow', desc: '', args: []);
  }

  /// `Synced`
  String get synced {
    return Intl.message('Synced', name: 'synced', desc: '', args: []);
  }

  /// `Synced at: `
  String get syncedAt {
    return Intl.message('Synced at: ', name: 'syncedAt', desc: '', args: []);
  }

  /// `Synced at: `
  String get syncedAtTime {
    return Intl.message(
      'Synced at: ',
      name: 'syncedAtTime',
      desc: '',
      args: [],
    );
  }

  /// `Retrying...`
  String get retrying {
    return Intl.message('Retrying...', name: 'retrying', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Retry failed. Please try again.`
  String get retryingFailedMessage {
    return Intl.message(
      'Retry failed. Please try again.',
      name: 'retryingFailedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Ensure auto backup & sync is enabled before retrying.`
  String get checkAutoBackupAndSync {
    return Intl.message(
      'Ensure auto backup & sync is enabled before retrying.',
      name: 'checkAutoBackupAndSync',
      desc: '',
      args: [],
    );
  }

  /// `Enable Now`
  String get enable_now {
    return Intl.message('Enable Now', name: 'enable_now', desc: '', args: []);
  }

  /// `Add to favorites`
  String get favorites {
    return Intl.message(
      'Add to favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Remove from favorites`
  String get un_favorites {
    return Intl.message(
      'Remove from favorites',
      name: 'un_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Added to favorites`
  String get favorited {
    return Intl.message(
      'Added to favorites',
      name: 'favorited',
      desc: '',
      args: [],
    );
  }

  /// `Removed from favorites`
  String get unfavorited {
    return Intl.message(
      'Removed from favorites',
      name: 'unfavorited',
      desc: '',
      args: [],
    );
  }

  /// `Note archived`
  String get note_archived {
    return Intl.message(
      'Note archived',
      name: 'note_archived',
      desc: '',
      args: [],
    );
  }

  /// `Note unarchive`
  String get note_unarchived {
    return Intl.message(
      'Note unarchive',
      name: 'note_unarchived',
      desc: '',
      args: [],
    );
  }

  /// `Note unpinned`
  String get note_unpined {
    return Intl.message(
      'Note unpinned',
      name: 'note_unpined',
      desc: '',
      args: [],
    );
  }

  /// `Note pinned`
  String get note_pined {
    return Intl.message('Note pinned', name: 'note_pined', desc: '', args: []);
  }

  /// `Are you sure you want to delete this note?`
  String get delete_note_confirmation {
    return Intl.message(
      'Are you sure you want to delete this note?',
      name: 'delete_note_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Backup Status`
  String get backupStatus {
    return Intl.message(
      'Backup Status',
      name: 'backupStatus',
      desc: '',
      args: [],
    );
  }

  /// `data ready for backup`
  String get dataReadyForBackup {
    return Intl.message(
      'data ready for backup',
      name: 'dataReadyForBackup',
      desc: '',
      args: [],
    );
  }

  /// `Last backup`
  String get lastBackup {
    return Intl.message('Last backup', name: 'lastBackup', desc: '', args: []);
  }

  /// `Create Backup`
  String get createBackup {
    return Intl.message(
      'Create Backup',
      name: 'createBackup',
      desc: '',
      args: [],
    );
  }

  /// `Restore from Backup`
  String get restoreFromBackup {
    return Intl.message(
      'Restore from Backup',
      name: 'restoreFromBackup',
      desc: '',
      args: [],
    );
  }

  /// `Local Backup`
  String get localBackup {
    return Intl.message(
      'Local Backup',
      name: 'localBackup',
      desc: '',
      args: [],
    );
  }

  /// `Export Data`
  String get exportData {
    return Intl.message('Export Data', name: 'exportData', desc: '', args: []);
  }

  /// `Download all your data as a backup file`
  String get exportDescription {
    return Intl.message(
      'Download all your data as a backup file',
      name: 'exportDescription',
      desc: '',
      args: [],
    );
  }

  /// `Export Data`
  String get exportNotes {
    return Intl.message('Export Data', name: 'exportNotes', desc: '', args: []);
  }

  /// ` (.json)`
  String get json {
    return Intl.message(' (.json)', name: 'json', desc: '', args: []);
  }

  /// `Import Data`
  String get importData {
    return Intl.message('Import Data', name: 'importData', desc: '', args: []);
  }

  /// `Restore data from a backup file`
  String get importDescription {
    return Intl.message(
      'Restore data from a backup file',
      name: 'importDescription',
      desc: '',
      args: [],
    );
  }

  /// `Import Data`
  String get importNotes {
    return Intl.message('Import Data', name: 'importNotes', desc: '', args: []);
  }

  /// `About Backups`
  String get aboutBackups {
    return Intl.message(
      'About Backups',
      name: 'aboutBackups',
      desc: '',
      args: [],
    );
  }

  /// `Cloud backups are encrypted and stored securely`
  String get backupFeature1 {
    return Intl.message(
      'Cloud backups are encrypted and stored securely',
      name: 'backupFeature1',
      desc: '',
      args: [],
    );
  }

  /// `Local exports can be stored on your device or cloud storage`
  String get backupFeature2 {
    return Intl.message(
      'Local exports can be stored on your device or cloud storage',
      name: 'backupFeature2',
      desc: '',
      args: [],
    );
  }

  /// `Automatic backups happen when enabled in settings`
  String get backupFeature3 {
    return Intl.message(
      'Automatic backups happen when enabled in settings',
      name: 'backupFeature3',
      desc: '',
      args: [],
    );
  }

  /// `Restoring will merge with existing data, not replace them`
  String get backupFeature4 {
    return Intl.message(
      'Restoring will merge with existing data, not replace them',
      name: 'backupFeature4',
      desc: '',
      args: [],
    );
  }

  /// `Recovery Code`
  String get recovery_code_title {
    return Intl.message(
      'Recovery Code',
      name: 'recovery_code_title',
      desc: '',
      args: [],
    );
  }

  /// `Save this code to restore your notes on another device.`
  String get recovery_code_subtitle {
    return Intl.message(
      'Save this code to restore your notes on another device.',
      name: 'recovery_code_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `This code allows you to recover encrypted notes if you sign in on another device.`
  String get recovery_code_instruction {
    return Intl.message(
      'This code allows you to recover encrypted notes if you sign in on another device.',
      name: 'recovery_code_instruction',
      desc: '',
      args: [],
    );
  }

  /// `Your recovery code`
  String get recovery_code_generated_label {
    return Intl.message(
      'Your recovery code',
      name: 'recovery_code_generated_label',
      desc: '',
      args: [],
    );
  }

  /// `Copy code`
  String get recovery_code_copy_button {
    return Intl.message(
      'Copy code',
      name: 'recovery_code_copy_button',
      desc: '',
      args: [],
    );
  }

  /// `Save as file`
  String get recovery_code_save_file_button {
    return Intl.message(
      'Save as file',
      name: 'recovery_code_save_file_button',
      desc: '',
      args: [],
    );
  }

  /// `Print`
  String get recovery_code_print_button {
    return Intl.message(
      'Print',
      name: 'recovery_code_print_button',
      desc: '',
      args: [],
    );
  }

  /// `Show QR`
  String get recovery_code_show_qr_button {
    return Intl.message(
      'Show QR',
      name: 'recovery_code_show_qr_button',
      desc: '',
      args: [],
    );
  }

  /// `I saved it`
  String get recovery_code_done_button {
    return Intl.message(
      'I saved it',
      name: 'recovery_code_done_button',
      desc: '',
      args: [],
    );
  }

  /// `Remind me later`
  String get recovery_code_remind_me_later {
    return Intl.message(
      'Remind me later',
      name: 'recovery_code_remind_me_later',
      desc: '',
      args: [],
    );
  }

  /// `Important — Save your recovery code`
  String get recovery_code_warning_title {
    return Intl.message(
      'Important — Save your recovery code',
      name: 'recovery_code_warning_title',
      desc: '',
      args: [],
    );
  }

  /// `We only show this recovery code once. If you lose it and you don't have another recovery method (password or a registered device), you will not be able to restore your encrypted notes.`
  String get recovery_code_warning_text {
    return Intl.message(
      'We only show this recovery code once. If you lose it and you don\'t have another recovery method (password or a registered device), you will not be able to restore your encrypted notes.',
      name: 'recovery_code_warning_text',
      desc: '',
      args: [],
    );
  }

  /// `Keep this code safe. We can't recover your notes without it.`
  String get recovery_code_warning_short {
    return Intl.message(
      'Keep this code safe. We can\'t recover your notes without it.',
      name: 'recovery_code_warning_short',
      desc: '',
      args: [],
    );
  }

  /// `Recovery code copied to clipboard.`
  String get recovery_code_copy_success {
    return Intl.message(
      'Recovery code copied to clipboard.',
      name: 'recovery_code_copy_success',
      desc: '',
      args: [],
    );
  }

  /// `Failed to copy. Try again.`
  String get recovery_code_copy_fail {
    return Intl.message(
      'Failed to copy. Try again.',
      name: 'recovery_code_copy_fail',
      desc: '',
      args: [],
    );
  }

  /// `Discard recovery code?`
  String get recovery_code_confirm_discard_title {
    return Intl.message(
      'Discard recovery code?',
      name: 'recovery_code_confirm_discard_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to skip saving the code? You may lose access to your notes if no other recovery method exists.`
  String get recovery_code_confirm_discard_text {
    return Intl.message(
      'Are you sure you want to skip saving the code? You may lose access to your notes if no other recovery method exists.',
      name: 'recovery_code_confirm_discard_text',
      desc: '',
      args: [],
    );
  }

  /// `Tip: Store this code in a password manager or write it down and keep it in a safe place.`
  String get recovery_code_security_tip {
    return Intl.message(
      'Tip: Store this code in a password manager or write it down and keep it in a safe place.',
      name: 'recovery_code_security_tip',
      desc: '',
      args: [],
    );
  }

  /// `QR code for recovery code`
  String get recovery_code_qr_alt {
    return Intl.message(
      'QR code for recovery code',
      name: 'recovery_code_qr_alt',
      desc: '',
      args: [],
    );
  }

  /// `Scan this QR code to transfer your recovery code to another device`
  String get recovery_code_qr_description {
    return Intl.message(
      'Scan this QR code to transfer your recovery code to another device',
      name: 'recovery_code_qr_description',
      desc: '',
      args: [],
    );
  }

  /// `Note: This code will be shown only one time.`
  String get recovery_code_show_once_note {
    return Intl.message(
      'Note: This code will be shown only one time.',
      name: 'recovery_code_show_once_note',
      desc: '',
      args: [],
    );
  }

  /// `Recommended backup options`
  String get recovery_code_backups_label {
    return Intl.message(
      'Recommended backup options',
      name: 'recovery_code_backups_label',
      desc: '',
      args: [],
    );
  }

  /// `Save it in your password manager.`
  String get recovery_code_backup_password_manager {
    return Intl.message(
      'Save it in your password manager.',
      name: 'recovery_code_backup_password_manager',
      desc: '',
      args: [],
    );
  }

  /// `Store it in a safe deposit box.`
  String get recovery_code_backup_print {
    return Intl.message(
      'Store it in a safe deposit box.',
      name: 'recovery_code_backup_print',
      desc: '',
      args: [],
    );
  }

  /// `Give a copy to someone you trust.`
  String get recovery_code_backup_trusted_person {
    return Intl.message(
      'Give a copy to someone you trust.',
      name: 'recovery_code_backup_trusted_person',
      desc: '',
      args: [],
    );
  }

  /// `Save in your secure notes (offline)`
  String get recovery_code_backup_cloud_note {
    return Intl.message(
      'Save in your secure notes (offline)',
      name: 'recovery_code_backup_cloud_note',
      desc: '',
      args: [],
    );
  }

  /// `Save securely`
  String get recovery_code_action_save_secure {
    return Intl.message(
      'Save securely',
      name: 'recovery_code_action_save_secure',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get recovery_code_action_cancel {
    return Intl.message(
      'Cancel',
      name: 'recovery_code_action_cancel',
      desc: '',
      args: [],
    );
  }

  /// `The app is performing some important operations, please wait...`
  String get app_performing_some_operations {
    return Intl.message(
      'The app is performing some important operations, please wait...',
      name: 'app_performing_some_operations',
      desc: '',
      args: [],
    );
  }

  /// `I have saved the code`
  String get radio_recovery_code_title {
    return Intl.message(
      'I have saved the code',
      name: 'radio_recovery_code_title',
      desc: '',
      args: [],
    );
  }

  /// `I saved it`
  String get recovery_button_save_it {
    return Intl.message(
      'I saved it',
      name: 'recovery_button_save_it',
      desc: '',
      args: [],
    );
  }

  /// `Remind me later`
  String get recovery_button_remind_me_later {
    return Intl.message(
      'Remind me later',
      name: 'recovery_button_remind_me_later',
      desc: '',
      args: [],
    );
  }

  /// `Skip anyway`
  String get recovery_button_skip {
    return Intl.message(
      'Skip anyway',
      name: 'recovery_button_skip',
      desc: '',
      args: [],
    );
  }

  /// `Important`
  String get recovery_info_title {
    return Intl.message(
      'Important',
      name: 'recovery_info_title',
      desc: '',
      args: [],
    );
  }

  /// `Your recovery code is the only way to restore your cloud data. If you lose it, you won’t be able to recover your data or sync with the cloud again. Please store this code in a safe and private place.`
  String get recovery_info_description {
    return Intl.message(
      'Your recovery code is the only way to restore your cloud data. If you lose it, you won’t be able to recover your data or sync with the cloud again. Please store this code in a safe and private place.',
      name: 'recovery_info_description',
      desc: '',
      args: [],
    );
  }

  /// `If you lost your recovery code, your cloud data cannot be restored. You can still use the app in offline mode, but syncing will be disabled until you enter the correct recovery code. To use cloud sync again, you’ll need to delete your account and create a new one. This will also erase all existing data. Please keep your recovery code in a safe place.`
  String get recovery_lost_description {
    return Intl.message(
      'If you lost your recovery code, your cloud data cannot be restored. You can still use the app in offline mode, but syncing will be disabled until you enter the correct recovery code. To use cloud sync again, you’ll need to delete your account and create a new one. This will also erase all existing data. Please keep your recovery code in a safe place.',
      name: 'recovery_lost_description',
      desc: '',
      args: [],
    );
  }

  /// `Enter The Code`
  String get with_code {
    return Intl.message(
      'Enter The Code',
      name: 'with_code',
      desc: '',
      args: [],
    );
  }

  /// `Scan The QR Code`
  String get with_scan {
    return Intl.message(
      'Scan The QR Code',
      name: 'with_scan',
      desc: '',
      args: [],
    );
  }

  /// `Enter Recovery Code`
  String get enterRecoveryCode {
    return Intl.message(
      'Enter Recovery Code',
      name: 'enterRecoveryCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter your recovery code to restore your encrypted data.`
  String get recoveryCodeDescription {
    return Intl.message(
      'Enter your recovery code to restore your encrypted data.',
      name: 'recoveryCodeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Your recovery code is 36 characters long and contains letters and numbers. You can enter it with or without dashes.`
  String get recoveryCodeLength {
    return Intl.message(
      'Your recovery code is 36 characters long and contains letters and numbers. You can enter it with or without dashes.',
      name: 'recoveryCodeLength',
      desc: '',
      args: [],
    );
  }

  /// `Recovery Code`
  String get recoveryCode {
    return Intl.message(
      'Recovery Code',
      name: 'recoveryCode',
      desc: '',
      args: [],
    );
  }

  /// `AbCd12Ef6h341jK15fMnOp780pSt9BUvMx`
  String get recoveryCodeExample {
    return Intl.message(
      'AbCd12Ef6h341jK15fMnOp780pSt9BUvMx',
      name: 'recoveryCodeExample',
      desc: '',
      args: [],
    );
  }

  /// `Enter the 36-character code you saved when setting up recovery.`
  String get enterRecoveryCodeHint {
    return Intl.message(
      'Enter the 36-character code you saved when setting up recovery.',
      name: 'enterRecoveryCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Restore Data`
  String get restoreData {
    return Intl.message(
      'Restore Data',
      name: 'restoreData',
      desc: '',
      args: [],
    );
  }

  /// `Can't find your recovery code?`
  String get cantFindRecoveryCode {
    return Intl.message(
      'Can\'t find your recovery code?',
      name: 'cantFindRecoveryCode',
      desc: '',
      args: [],
    );
  }

  /// `Check your password manager`
  String get recoveryTip1 {
    return Intl.message(
      'Check your password manager',
      name: 'recoveryTip1',
      desc: '',
      args: [],
    );
  }

  /// `Look for a printed copy in a safe place`
  String get recoveryTip2 {
    return Intl.message(
      'Look for a printed copy in a safe place',
      name: 'recoveryTip2',
      desc: '',
      args: [],
    );
  }

  /// `Check your secure notes or backup files`
  String get recoveryTip3 {
    return Intl.message(
      'Check your secure notes or backup files',
      name: 'recoveryTip3',
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
