// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "GetStarted": MessageLookupByLibrary.simpleMessage("Get Started"),
    "appName": MessageLookupByLibrary.simpleMessage("Jot & Do"),
    "onBoardingDesc1": MessageLookupByLibrary.simpleMessage(
      "Write down everything on your mind and keep it all in one place.",
    ),
    "onBoardingDesc2": MessageLookupByLibrary.simpleMessage(
      "Select start and end dates to never miss a task or note.",
    ),
    "onBoardingDesc3": MessageLookupByLibrary.simpleMessage(
      "Save your data locally or back it up to the cloud, all in one tap.",
    ),
    "onBoardingTitle1": MessageLookupByLibrary.simpleMessage(
      "Organize Your Thoughts",
    ),
    "onBoardingTitle2": MessageLookupByLibrary.simpleMessage(
      "Set Deadlines Easily",
    ),
    "onBoardingTitle3": MessageLookupByLibrary.simpleMessage("Sync Your Notes"),
    "splashText1": MessageLookupByLibrary.simpleMessage("Welcome to Jot & Do"),
    "splashText2": MessageLookupByLibrary.simpleMessage("Plan. Note. Do."),
  };
}
