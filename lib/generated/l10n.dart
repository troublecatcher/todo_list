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

  /// `My tasks`
  String get homeHeaderTitle {
    return Intl.message(
      'My tasks',
      name: 'homeHeaderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Error: {errorMessage}`
  String errorMessage(Object errorMessage) {
    return Intl.message(
      'Error: $errorMessage',
      name: 'errorMessage',
      desc: '',
      args: [errorMessage],
    );
  }

  /// `Completed — {count}`
  String doneTodoCount(Object count) {
    return Intl.message(
      'Completed — $count',
      name: 'doneTodoCount',
      desc: '',
      args: [count],
    );
  }

  /// `Save`
  String get todoSaveButtonTitle {
    return Intl.message(
      'Save',
      name: 'todoSaveButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `What should be done...`
  String get todoTextfieldPlaceholder {
    return Intl.message(
      'What should be done...',
      name: 'todoTextfieldPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Importance`
  String get todoImportance {
    return Intl.message(
      'Importance',
      name: 'todoImportance',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get todoImportance_basic {
    return Intl.message(
      'None',
      name: 'todoImportance_basic',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get todoImportance_low {
    return Intl.message(
      'Low',
      name: 'todoImportance_low',
      desc: '',
      args: [],
    );
  }

  /// `!! High`
  String get todoImportance_important {
    return Intl.message(
      '!! High',
      name: 'todoImportance_important',
      desc: '',
      args: [],
    );
  }

  /// `Deadline`
  String get todoDeadline {
    return Intl.message(
      'Deadline',
      name: 'todoDeadline',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get todoDeleteButtonTitle {
    return Intl.message(
      'Delete',
      name: 'todoDeleteButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create new...`
  String get todoFastCreateTitle {
    return Intl.message(
      'Create new...',
      name: 'todoFastCreateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this task?`
  String get todoDeleteDialogTitle {
    return Intl.message(
      'Are you sure you want to delete this task?',
      name: 'todoDeleteDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `This action is irreversible`
  String get todoDeleteDialogContent {
    return Intl.message(
      'This action is irreversible',
      name: 'todoDeleteDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
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
      Locale.fromSubtags(languageCode: 'ru'),
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
