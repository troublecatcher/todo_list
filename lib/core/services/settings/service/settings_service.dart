import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/core/services/settings/storage/settings_storage.dart';
import 'package:todo_list/core/services/settings/storage/settings_storage_impl.dart';
import '../setting/abstract/setting.dart';

part '../setting/implementations/auth_setting.dart';
part '../setting/implementations/delete_confirmation_setting.dart';
part '../setting/implementations/locale_setting.dart';
part '../setting/implementations/revision_setting.dart';
part '../setting/implementations/theme_setting.dart';

class SettingsService {
  late LocaleSetting locale;
  late ThemeSetting theme;
  late DeleteConfirmationSetting confirmDialogs;
  late RevisionSetting revision;
  late AuthSetting auth;

  Future<SettingsService> init() async {
    final prefs = await SharedPreferences.getInstance();
    final storage = SettingsStorageImpl(prefs);

    locale = LocaleSetting._(storage);
    theme = ThemeSetting._(storage);
    confirmDialogs = DeleteConfirmationSetting._(storage);
    revision = RevisionSetting._(storage);
    auth = AuthSetting._(storage);

    return this;
  }
}
