import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _keyRevision = 'revision';

  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();
  SharedPreferences? _preferences;

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  Future<SharedPreferencesService> init() async {
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  int get revision => _preferences?.getInt(_keyRevision) ?? 0;

  Future<void> increment() async =>
      await _preferences?.setInt(_keyRevision, revision + 1);

  Future<void> set(int value) async =>
      await _preferences?.setInt(_keyRevision, value);
}
