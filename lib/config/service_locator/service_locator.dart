import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/config/router/navigation_service.dart';
import 'package:todo_list/config/router/router.dart';
import 'package:todo_list/config/logging/analytics.dart';
import 'package:todo_list/core/services/device_info_service.dart';
import 'package:todo_list/core/services/firebase_service.dart';
import 'package:todo_list/core/services/remote_config_service.dart';
import 'package:todo_list/core/services/settings_service.dart';
import 'package:todo_list/features/todo/data/models/local/local_todo.dart';
import 'package:todo_list/features/todo/data/todo_repository_impl.dart';
import 'package:todo_list/features/todo/data/sources/local/local_todo_source_impl.dart';
import 'package:todo_list/features/todo/data/sources/remote/remote_source/remote_todo_source_impl.dart';
import 'package:todo_list/features/todo/domain/repository/todo_repository.dart';

Future<void> initDependecies() async {
  GetIt.I.registerSingletonAsync<DeviceInfoService>(
    () => DeviceInfoService().init(),
  );
  await GetIt.I.isReady<DeviceInfoService>();
  GetIt.I.registerSingletonAsync<SettingsService>(
    () => SettingsService().init(),
  );
  await GetIt.I.isReady<SettingsService>();
  GetIt.I.registerSingletonAsync<TodoRepository>(
    () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://hive.mrdekk.ru/todo/'));
      final RemoteTodoSourceImpl remote = RemoteTodoSourceImpl(dio);

      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        [LocalTodoSchema],
        directory: dir.path,
        inspector: false,
      );

      final LocalTodoSourceImpl local = LocalTodoSourceImpl(isar);
      return TodoRepositoryImpl(
        remote: remote,
        local: local,
        revision: GetIt.I<SettingsService>().revision,
        initSync: GetIt.I<SettingsService>().initSync,
      );
    },
  );
  await GetIt.I.isReady<TodoRepository>();

  GetIt.I.registerSingletonAsync<FirebaseService>(
    () => FirebaseService().init(),
  );
  await GetIt.I.isReady<FirebaseService>();

  GetIt.I.registerSingletonAsync<RemoteConfigService>(
    () => RemoteConfigService().init(),
  );
  await GetIt.I.isReady<RemoteConfigService>();
}
