import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final String _revKey = 'revision';
  late SharedPreferences? _prefs;

  Future<SharedPreferencesService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  int get revision => _prefs?.getInt(_revKey) ?? -1;

  Future<void> incRev() async => await _prefs?.setInt(_revKey, revision + 1);

  Future<void> setRev(int value) async => await _prefs?.setInt(_revKey, value);
}
