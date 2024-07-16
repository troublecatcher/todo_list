import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/config/theme/remote_colors/remote_colors_cubit.dart';
import 'package:todo_list/core/services/remote_config_service.dart';
import 'package:todo_list/features/settings/domain/state_management/auth/auth_cubit.dart';
import 'package:todo_list/config/connectivity/connectivity_cubit.dart';
import 'package:todo_list/features/settings/domain/state_management/locale/locale_cubit.dart';
import 'package:todo_list/config/service_locator/service_locator.dart';
import 'package:todo_list/features/settings/domain/state_management/delete_confirmation/delete_confirmation_cubit.dart';
import 'package:todo_list/features/settings/domain/state_management/theme/theme_cubit.dart';
import 'package:todo_list/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/core/application/todo_app.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_operation/todo_operation_cubit.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/.env');
  WidgetsFlutterBinding.ensureInitialized();
  await initDependecies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConnectivityCubit()..init()),
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => DeleteConfirmationCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => TodoOperationCubit()),
        BlocProvider(
          create: (context) => TodoListBloc(
            todoRepository: GetIt.I<TodoRepository>(),
            todoOperation: context.read<TodoOperationCubit>(),
          )..add(TodosFetchStarted()),
        ),
        BlocProvider(
          create: (context) =>
              RemoteColorsCubit(GetIt.I<RemoteConfigService>()),
        ),
      ],
      child: const TodoApp(),
    ),
  );
}
