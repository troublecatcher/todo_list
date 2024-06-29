import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final _prefs = GetIt.I<SharedPreferencesService>();
  ThemeCubit() : super(ThemeMode.system) {
    init();
  }
  init() =>
      emit(ThemeMode.values.firstWhere((pref) => pref.name == _prefs.theme));
  set(ThemeMode preference) async {
    await _prefs.setTheme(preference.name);
    emit(preference);
  }
}
