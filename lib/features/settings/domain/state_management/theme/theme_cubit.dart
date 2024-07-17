import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/services/services.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final _theme = GetIt.I<SettingsService>().theme;
  ThemeCubit() : super(ThemeMode.system);

  void init() =>
      emit(ThemeMode.values.firstWhere((pref) => pref.name == _theme.value));
  Future<void> set(ThemeMode preference) async {
    await _theme.set(preference.name);
    emit(preference);
  }
}
