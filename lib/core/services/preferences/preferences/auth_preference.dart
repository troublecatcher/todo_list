part of '../preferences_service/preferences_service.dart';

class AuthPreference extends BasePreference<String?> {
  static const String _authKey = 'auth';

  AuthPreference(SharedPreferences prefs) : super(prefs, _authKey);

  @override
  String? get value => prefs.getString(key);

  @override
  Future<void> set(String? value) async {
    if (value != null) {
      prefs.setString(key, value);
    } else {
      prefs.remove(key);
    }
  }
}
