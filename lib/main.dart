import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:isar/isar.dart';
import 'package:todo_list/config/api_key/api_key_cubit.dart';
import 'package:todo_list/config/dialog_confirmation/dialog_confirmation_cubit.dart';
import 'package:todo_list/config/locale/locale_cubit.dart';
import 'package:todo_list/config/theme/theme_cubit.dart';
import 'package:todo_list/core/services/service_setupper.dart';
import 'package:todo_list/features/todo/data/repository/remote_todo_repository.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/data/repository/local_todo_repository.dart';
import 'package:todo_list/core/app/todo_app.dart';
import 'package:todo_list/features/todo/domain/todo_operation_cubit/todo_operation_cubit.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  await dotenv.load(fileName: 'assets/.env');
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceSetupper.setupSharedPreferencesService();
  await ServiceSetupper.setupDeviceInfoService();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([TodoSchema], directory: dir.path);
  final localRepository = LocalTodoRepository(isar);

  final dio = Dio(BaseOptions(baseUrl: 'https://hive.mrdekk.ru/todo/'));
  final remoteRepository = RemoteTodoRepository(dio);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => DialogConfirmationCubit()),
        BlocProvider(create: (context) => ApiKeyCubit()),
        BlocProvider(create: (context) => TodoOperationCubit()),
        BlocProvider(
          create: (context) => TodoListBloc(
            remote: remoteRepository,
            local: localRepository,
            operationStatusNotifier: context.read<TodoOperationCubit>(),
          )..add(FetchTodos()),
        ),
      ],
      child: const TodoApp(),
    ),
  );
}
