import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/device_info_service.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';

class ServiceSetupper {
  static Future<void> setupSharedPreferencesService() async {
    GetIt.I.registerSingletonAsync(() => SharedPreferencesService().init());
    await GetIt.I.isReady<SharedPreferencesService>();
  }

  static Future<void> setupDeviceInfoService() async {
    GetIt.I.registerSingletonAsync(() => DeviceInfoService().init());
    await GetIt.I.isReady<DeviceInfoService>();
  }
}
