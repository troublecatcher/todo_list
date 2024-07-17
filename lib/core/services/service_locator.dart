import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/todo/data/data.dart';
import '../../features/todo/domain/domain.dart';
import 'services.dart';

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
