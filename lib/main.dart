import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/helpers/formatting_helper.dart';
import 'package:todo_list/core/services/service_locator.dart';
import 'package:todo_list/features/todo/data/repository/remote_todo_repository.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/data/repository/local_todo_repository.dart';

import 'package:todo_list/core/services/isar_service.dart';
import 'package:todo_list/core/app/just_todo_it_app.dart';
import 'package:todo_list/features/todo/presentation/common/cubit/todo_operation_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FormattingHelper.init();

  final isar = await IsarService().initIsar();
  await ServiceLocator.setupSharedPreferencesService();

  final networkRepository = RemoteTodoRepository();
  final persistenceRepository = LocalTodoRepository(isar);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoOperationCubit(),
        ),
        BlocProvider(
          create: (context) => TodoListBloc(
              remote: networkRepository,
              local: persistenceRepository,
              operationStatusNotifier: context.read<TodoOperationCubit>())
            ..add(FetchTodos()),
        ),
      ],
      child: const JustTodoItApp(),
    ),
  );
}
