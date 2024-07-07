import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:isar/isar.dart';
import 'package:todo_list/config/api_key/auth_cubit.dart';
import 'package:todo_list/config/connectivity/connectivity_cubit.dart';
import 'package:todo_list/config/dialog/dialog_confirmation_cubit.dart';
import 'package:todo_list/config/l10n/locale_cubit.dart';
import 'package:todo_list/config/theme/theme_cubit.dart';
import 'package:todo_list/core/services/service_setupper.dart';
import 'package:todo_list/features/todo/data/repository_impl/remote/todo_repository_remote.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/data/repository_impl/local/todo_repository_local.dart';
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
  final localRepository = TodoRepositoryLocal(isar);

  final dio = Dio(BaseOptions(baseUrl: 'https://hive.mrdekk.ru/todo/'));
  final remoteRepository = TodoRepositoryRemote(dio);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConnectivityCubit()),
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => DialogConfirmationCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => TodoOperationCubit()),
        BlocProvider(
          create: (context) => TodoListBloc(
            remote: remoteRepository,
            local: localRepository,
            operationStatusNotifier: context.read<TodoOperationCubit>(),
          )..add(TodosFetchStarted()),
        ),
      ],
      child: const TodoApp(),
    ),
  );
}
