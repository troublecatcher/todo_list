import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/core/services/preferences/base_preference/base_preference.dart';

class ThemePreference extends BasePreference<String> {
  static const String _themeKey = 'theme';

  ThemePreference(SharedPreferences prefs) : super(prefs, _themeKey);

  @override
  String get value => prefs.getString(key) ?? 'system';

  @override
  Future<void> set(String value) => prefs.setString(key, value);
}
