import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/features/settings/domain/storage/settings_storage.dart';
import 'package:todo_list/features/settings/data/settings_storage_impl.dart';
import '../../../features/settings/data/model/abstract/setting.dart';

part '../../../features/settings/data/model/implementations/auth_setting.dart';
part '../../../features/settings/data/model/implementations/delete_confirmation_setting.dart';
part '../../../features/settings/data/model/implementations/locale_setting.dart';
part '../../../features/settings/data/model/implementations/revision_setting.dart';
part '../../../features/settings/data/model/implementations/theme_setting.dart';

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
