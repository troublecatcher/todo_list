part of '../preferences_service/preferences_service.dart';

class ConfirmDialogsPreference extends BasePreference<bool> {
  static const String _confirmDialogsKey = 'confirm_dialogs';

  ConfirmDialogsPreference(SharedPreferences prefs)
      : super(prefs, _confirmDialogsKey);

  @override
  bool get value => prefs.getBool(key) ?? true;

  @override
  Future<void> set(bool value) => prefs.setBool(key, value);
}
