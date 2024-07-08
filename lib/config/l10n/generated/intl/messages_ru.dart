// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(count) => "Выполнено — ${count}";

  static String m1(errorMessage) => "Ошибка: ${errorMessage}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "apiKey": MessageLookupByLibrary.simpleMessage("API ключ"),
        "backOnline":
            MessageLookupByLibrary.simpleMessage("Подключение восстановлено"),
        "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "confirmTodoDeletion":
            MessageLookupByLibrary.simpleMessage("Подтверждать удаление дел"),
        "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "doneTodoCount": m0,
        "errorMessage": m1,
        "homeHeaderTitle": MessageLookupByLibrary.simpleMessage("Мои дела"),
        "language": MessageLookupByLibrary.simpleMessage("Язык"),
        "loading": MessageLookupByLibrary.simpleMessage("Загрузка..."),
        "luckyYou":
            MessageLookupByLibrary.simpleMessage("Счастливый Вы человек!"),
        "noTodos": MessageLookupByLibrary.simpleMessage("Дел нет"),
        "offlineMode": MessageLookupByLibrary.simpleMessage("Автономный режим"),
        "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "theme": MessageLookupByLibrary.simpleMessage("Тема"),
        "todoDeadline": MessageLookupByLibrary.simpleMessage("Дедлайн"),
        "todoDeleteButtonTitle":
            MessageLookupByLibrary.simpleMessage("Удалить"),
        "todoDeleteDialogContent":
            MessageLookupByLibrary.simpleMessage("Это действие необратимо"),
        "todoDeleteDialogTitle": MessageLookupByLibrary.simpleMessage(
            "Уверены, что хотите удалить дело?"),
        "todoFastCreateTitle": MessageLookupByLibrary.simpleMessage("Новое..."),
        "todoImportance": MessageLookupByLibrary.simpleMessage("Приоритет"),
        "todoImportance_basic": MessageLookupByLibrary.simpleMessage("Нет"),
        "todoImportance_important":
            MessageLookupByLibrary.simpleMessage("!! Высокий"),
        "todoImportance_low": MessageLookupByLibrary.simpleMessage("Низкий"),
        "todoSaveButtonTitle":
            MessageLookupByLibrary.simpleMessage("Сохранить"),
        "todoTextfieldPlaceholder":
            MessageLookupByLibrary.simpleMessage("Что надо сделать..."),
        "useEnvFile":
            MessageLookupByLibrary.simpleMessage("Использовать файл .env")
      };
}
