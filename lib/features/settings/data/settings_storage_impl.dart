import 'package:shared_preferences/shared_preferences.dart';

import '../domain/storage/storage.dart';

class SettingsStorageImpl implements SettingsStorage {
  final SharedPreferences _prefs;

  SettingsStorageImpl(this._prefs);

  @override
  T? get<T>(String key) {
    return _prefs.get(key) as T?;
  }

  @override
  Future<bool> set<T>(String key, T value) {
    if (value == null) {
      return _prefs.remove(key);
    }
    if (value is String) {
      return _prefs.setString(key, value);
    } else if (value is int) {
      return _prefs.setInt(key, value);
    } else if (value is bool) {
      return _prefs.setBool(key, value);
    } else if (value is double) {
      return _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      return _prefs.setStringList(key, value);
    } else {
      throw UnsupportedError('Type not supported');
    }
  }

  @override
  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }
}
