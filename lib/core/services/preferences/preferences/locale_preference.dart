import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/core/services/preferences/base_preference/base_preference.dart';

class LocalePreference extends BasePreference<String> {
  static const String _localeKey = 'locale';

  LocalePreference(SharedPreferences prefs) : super(prefs, _localeKey);

  @override
  String get value => prefs.getString(key) ?? 'ru';

  @override
  Future<void> set(String value) => prefs.setString(key, value);
}
