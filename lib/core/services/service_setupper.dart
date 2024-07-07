import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/device_info_service.dart';
import 'package:todo_list/core/services/preferences/preferences_service/preferences_service.dart';

class ServiceSetupper {
  static Future<void> setupSharedPreferencesService() async {
    GetIt.I.registerSingletonAsync(() => PreferencesService().init());
    await GetIt.I.isReady<PreferencesService>();
  }

  static Future<void> setupDeviceInfoService() async {
    GetIt.I.registerSingletonAsync(() => DeviceInfoService().init());
    await GetIt.I.isReady<DeviceInfoService>();
  }
}
