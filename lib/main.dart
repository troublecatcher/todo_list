import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_list/config/api_key/api_key_cubit.dart';
import 'package:todo_list/config/dialog_confirmation/dialog_confirmation_cubit.dart';
import 'package:todo_list/config/locale/locale_cubit.dart';
import 'package:todo_list/config/theme/theme_cubit.dart';
import 'package:todo_list/core/helpers/formatting_helper.dart';
import 'package:todo_list/core/services/service_locator.dart';
import 'package:todo_list/features/todo/data/repository/remote_todo_repository.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/data/repository/local_todo_repository.dart';

import 'package:todo_list/core/services/isar_service.dart';
import 'package:todo_list/core/app/todo_app.dart';
import 'package:todo_list/features/todo/presentation/common/cubit/todo_operation_cubit.dart';

void main() async {
  await dotenv.load(fileName: 'assets/.env');
  WidgetsFlutterBinding.ensureInitialized();

  await FormattingHelper.init();
  await ServiceLocator.setupSharedPreferencesService();
  await ServiceLocator.setupDeviceInfoService();

  final isar = await IsarService().initIsar();
  final persistenceRepository = LocalTodoRepository(isar);
  final networkRepository = RemoteTodoRepository();

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
            remote: networkRepository,
            local: persistenceRepository,
            operationStatusNotifier: context.read<TodoOperationCubit>(),
          )..add(FetchTodos()),
        ),
      ],
      child: const TodoApp(),
    ),
  );
}
