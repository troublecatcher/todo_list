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

  static String m0(count) => "Completed — ${count}";

  static String m1(errorMessage) => "Error: ${errorMessage}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "apiKey": MessageLookupByLibrary.simpleMessage("API key"),
        "backOnline": MessageLookupByLibrary.simpleMessage("Back online"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "confirmTodoDeletion":
            MessageLookupByLibrary.simpleMessage("Confirm todo deletion"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "doneTodoCount": m0,
        "duck": MessageLookupByLibrary.simpleMessage("Duck"),
        "errorMessage": m1,
        "homeHeaderTitle": MessageLookupByLibrary.simpleMessage("My todos"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
        "luckyYou": MessageLookupByLibrary.simpleMessage("Lucky you!"),
        "noTodoSelected":
            MessageLookupByLibrary.simpleMessage("No todo selected"),
        "noTodos": MessageLookupByLibrary.simpleMessage("There are no todos"),
        "offlineMode": MessageLookupByLibrary.simpleMessage("Offline mode"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "todoDeadline": MessageLookupByLibrary.simpleMessage("Deadline"),
        "todoDeleteButtonTitle": MessageLookupByLibrary.simpleMessage("Delete"),
        "todoDeleteDialogContent":
            MessageLookupByLibrary.simpleMessage("This action is irreversible"),
        "todoDeleteDialogTitle": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this todo?"),
        "todoFastCreateTitle":
            MessageLookupByLibrary.simpleMessage("Create new..."),
        "todoImportance": MessageLookupByLibrary.simpleMessage("Importance"),
        "todoImportance_basic": MessageLookupByLibrary.simpleMessage("None"),
        "todoImportance_important":
            MessageLookupByLibrary.simpleMessage("!! High"),
        "todoImportance_low": MessageLookupByLibrary.simpleMessage("Low"),
        "todoSaveButtonTitle": MessageLookupByLibrary.simpleMessage("Save"),
        "todoTextfieldPlaceholder":
            MessageLookupByLibrary.simpleMessage("What should be done..."),
        "useEnvFile": MessageLookupByLibrary.simpleMessage("Use .env file")
      };
}
