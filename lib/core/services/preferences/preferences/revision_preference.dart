import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/core/services/preferences/base_preference/base_preference.dart';

class RevisionPreference extends BasePreference<int> {
  static const String _revKey = 'revision';

  RevisionPreference(SharedPreferences prefs) : super(prefs, _revKey);

  @override
  int get value => prefs.getInt(key) ?? -1;

  @override
  Future<void> set(int value) => prefs.setInt(key, value);

  Future<void> increment() => prefs.setInt(key, value + 1);
}
