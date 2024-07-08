import 'package:shared_preferences/shared_preferences.dart';

import '../base_preference/base_preference.dart';
part '../preferences/auth_preference.dart';
part '../preferences/confirm_dialogs_preference.dart';
part '../preferences/locale_preference.dart';
part '../preferences/revision_preference.dart';
part '../preferences/theme_preference.dart';

class PreferencesService {
  late SharedPreferences _prefs;

  late LocalePreference locale;
  late ThemePreference theme;
  late ConfirmDialogsPreference confirmDialogs;
  late RevisionPreference revision;
  late AuthPreference auth;

  Future<PreferencesService> init() async {
    _prefs = await SharedPreferences.getInstance();

    locale = LocalePreference(_prefs);
    theme = ThemePreference(_prefs);
    confirmDialogs = ConfirmDialogsPreference(_prefs);
    revision = RevisionPreference(_prefs);
    auth = AuthPreference(_prefs);

    return this;
  }
}
