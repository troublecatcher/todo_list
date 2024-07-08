import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/core/services/device_info/device_info_service.dart';
import 'package:todo_list/core/services/settings/settings_service.dart';
import 'package:todo_list/features/todo/data/dto/local/local_todo_dto.dart';
import 'package:todo_list/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todo_list/features/todo/data/sources/local/local_todo_source_impl.dart';
import 'package:todo_list/features/todo/data/sources/remote/remote_source/remote_todo_source_impl.dart';
import 'package:todo_list/features/todo/domain/repository/todo_repository.dart';

Future<void> initDependecies() async {
  GetIt.I.registerSingletonAsync<DeviceInfoService>(
    () => DeviceInfoService().init(),
  );
  GetIt.I.registerSingletonAsync<SettingsService>(
    () => SettingsService().init(),
  );
  GetIt.I.registerSingletonAsync<TodoRepository>(
    () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://hive.mrdekk.ru/todo/'));
      final RemoteTodoSourceImpl remote = RemoteTodoSourceImpl(dio);

      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open([LocalTodoDtoSchema], directory: dir.path);

      final LocalTodoSourceImpl local = LocalTodoSourceImpl(isar);
      return TodoRepositoryImpl(
        remote: remote,
        local: local,
      );
    },
  );

  await GetIt.I.allReady();
}
