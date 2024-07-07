import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/preferences/preferences_service/preferences_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final _theme = GetIt.I<PreferencesService>().theme;
  ThemeCubit() : super(ThemeMode.system) {
    init();
  }
  init() =>
      emit(ThemeMode.values.firstWhere((pref) => pref.name == _theme.value));
  set(ThemeMode preference) async {
    await _theme.set(preference.name);
    emit(preference);
  }
}
