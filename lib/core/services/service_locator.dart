import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';

class ServiceLocator {
  static Future<void> setupSharedPreferencesService() async {
    GetIt.I.registerSingletonAsync(() => SharedPreferencesService().init());
    await GetIt.I.isReady<SharedPreferencesService>();
  }
}
