import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static String get _localeKey => 'locale';
  static String get _themeKey => 'theme';
  static String get _confirmDialogs => 'confirm_dialogs';
  static String get _revKey => 'revision';
  static String get _deviceIdKey => 'device_id';
  static String get _bearer => 'bearer';
  static String get _oauth => 'oauth';
  late SharedPreferences? _prefs;

  Future<SharedPreferencesService> init() async {
    _prefs = await SharedPreferences.getInstance();
    final String? locale = _prefs!.getString(_localeKey);
    if (locale == null) await setLocale('en');
    final String? theme = _prefs!.getString(_themeKey);
    if (theme == null) await setTheme('system');
    final bool? confirmDialogs = _prefs!.getBool(_confirmDialogs);
    if (confirmDialogs == null) await setConfirmDialogs(true);

    return this;
  }

  String get locale => _prefs!.getString(_localeKey)!;
  Future<void> setLocale(String locale) =>
      _prefs!.setString(_localeKey, locale);
  String get theme => _prefs!.getString(_themeKey)!;
  Future<void> setTheme(String theme) => _prefs!.setString(_themeKey, theme);
  bool get confirmDialogs => _prefs!.getBool(_confirmDialogs)!;
  Future<void> setConfirmDialogs(bool confirm) =>
      _prefs!.setBool(_confirmDialogs, confirm);

  String? get bearer => _prefs!.getString(_bearer);
  Future<void> setBearer(String bearer) => _prefs!.setString(_bearer, bearer);
  Future<void> clearBearer() => _prefs!.remove(_bearer);

  String? get oauth => _prefs!.getString(_oauth);
  Future<void> setOAuth(String oauth) => _prefs!.setString(_oauth, oauth);
  Future<void> clearOAuth() => _prefs!.remove(_oauth);

  int get revision => _prefs?.getInt(_revKey) ?? -1;
  Future<void> incRev() async => await _prefs?.setInt(_revKey, revision + 1);
  Future<void> setRev(int value) async => await _prefs?.setInt(_revKey, value);

  String? get deviceId => _prefs?.getString(_deviceIdKey);
  Future<void> setDeviceId(String id) async =>
      await _prefs?.setString(_deviceIdKey, id);
}
