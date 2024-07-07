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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Мои дела`
  String get homeHeaderTitle {
    return Intl.message(
      'Мои дела',
      name: 'homeHeaderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ошибка: {errorMessage}`
  String errorMessage(Object errorMessage) {
    return Intl.message(
      'Ошибка: $errorMessage',
      name: 'errorMessage',
      desc: '',
      args: [errorMessage],
    );
  }

  /// `Выполнено — {count}`
  String doneTodoCount(Object count) {
    return Intl.message(
      'Выполнено — $count',
      name: 'doneTodoCount',
      desc: '',
      args: [count],
    );
  }

  /// `Сохранить`
  String get todoSaveButtonTitle {
    return Intl.message(
      'Сохранить',
      name: 'todoSaveButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Что надо сделать...`
  String get todoTextfieldPlaceholder {
    return Intl.message(
      'Что надо сделать...',
      name: 'todoTextfieldPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Приоритет`
  String get todoImportance {
    return Intl.message(
      'Приоритет',
      name: 'todoImportance',
      desc: '',
      args: [],
    );
  }

  /// `Нет`
  String get todoImportance_basic {
    return Intl.message(
      'Нет',
      name: 'todoImportance_basic',
      desc: '',
      args: [],
    );
  }

  /// `Низкий`
  String get todoImportance_low {
    return Intl.message(
      'Низкий',
      name: 'todoImportance_low',
      desc: '',
      args: [],
    );
  }

  /// `!! Высокий`
  String get todoImportance_important {
    return Intl.message(
      '!! Высокий',
      name: 'todoImportance_important',
      desc: '',
      args: [],
    );
  }

  /// `Дедлайн`
  String get todoDeadline {
    return Intl.message(
      'Дедлайн',
      name: 'todoDeadline',
      desc: '',
      args: [],
    );
  }

  /// `Удалить`
  String get todoDeleteButtonTitle {
    return Intl.message(
      'Удалить',
      name: 'todoDeleteButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Новое...`
  String get todoFastCreateTitle {
    return Intl.message(
      'Новое...',
      name: 'todoFastCreateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Уверены, что хотите удалить дело?`
  String get todoDeleteDialogTitle {
    return Intl.message(
      'Уверены, что хотите удалить дело?',
      name: 'todoDeleteDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Это действие необратимо`
  String get todoDeleteDialogContent {
    return Intl.message(
      'Это действие необратимо',
      name: 'todoDeleteDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Отмена`
  String get cancel {
    return Intl.message(
      'Отмена',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Удалить`
  String get delete {
    return Intl.message(
      'Удалить',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Настройки`
  String get settings {
    return Intl.message(
      'Настройки',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Тема`
  String get theme {
    return Intl.message(
      'Тема',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Язык`
  String get language {
    return Intl.message(
      'Язык',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Подтверждать удаление дел`
  String get confirmTodoDeletion {
    return Intl.message(
      'Подтверждать удаление дел',
      name: 'confirmTodoDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Дел нет`
  String get noTodos {
    return Intl.message(
      'Дел нет',
      name: 'noTodos',
      desc: '',
      args: [],
    );
  }

  /// `Счастливый Вы человек!`
  String get luckyYou {
    return Intl.message(
      'Счастливый Вы человек!',
      name: 'luckyYou',
      desc: '',
      args: [],
    );
  }

  /// `Сохранить`
  String get save {
    return Intl.message(
      'Сохранить',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Загрузка...`
  String get loading {
    return Intl.message(
      'Загрузка...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Автономный режим`
  String get offlineMode {
    return Intl.message(
      'Автономный режим',
      name: 'offlineMode',
      desc: '',
      args: [],
    );
  }

  /// `Подключение восстановлено`
  String get backOnline {
    return Intl.message(
      'Подключение восстановлено',
      name: 'backOnline',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'en'),
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
