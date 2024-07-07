import 'package:shared_preferences/shared_preferences.dart';

abstract class BasePreference<T> {
  final SharedPreferences prefs;
  final String key;

  BasePreference(this.prefs, this.key);

  T get value;
  Future<void> set(T value);
}
