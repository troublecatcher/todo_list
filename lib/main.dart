import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/config/api_key/auth_cubit.dart';
import 'package:todo_list/config/connectivity/connectivity_cubit.dart';
import 'package:todo_list/config/service_locator/service_locator.dart';
import 'package:todo_list/config/dialog_confirmation/dialog_confirmation_cubit.dart';
import 'package:todo_list/config/l10n/locale_cubit.dart';
import 'package:todo_list/config/theme/theme_cubit.dart';
import 'package:todo_list/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/core/application/todo_app.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_operation/todo_operation_cubit.dart';

void main() async {
  await dotenv.load(fileName: 'assets/.env');
  WidgetsFlutterBinding.ensureInitialized();
  await initDependecies();
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
            todoRepository: GetIt.I<TodoRepository>(),
            todoOperation: context.read<TodoOperationCubit>(),
          )..add(TodosFetchStarted()),
        ),
      ],
      child: const TodoApp(),
    ),
  );
}
