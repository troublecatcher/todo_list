import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/router/navigation.dart';
import 'package:todo_list/config/theme/remote_colors/remote_colors_cubit.dart';
import 'package:todo_list/core/services/analytics.dart';
import 'package:todo_list/core/services/remote_config_service.dart';
import 'package:todo_list/features/settings/domain/state_management/auth/auth_cubit.dart';
import 'package:todo_list/core/services/connectivity/connectivity_cubit.dart';
import 'package:todo_list/features/settings/domain/state_management/duck/duck_cubit.dart';
import 'package:todo_list/features/settings/domain/state_management/locale/locale_cubit.dart';
import 'package:todo_list/core/services/service_locator.dart';
import 'package:todo_list/features/settings/domain/state_management/delete_confirmation/delete_confirmation_cubit.dart';
import 'package:todo_list/features/settings/domain/state_management/theme/theme_cubit.dart';
import 'package:todo_list/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/core/application/todo_app.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_operation/todo_operation_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/tablet/tablet_view_cubit.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/.env');
  WidgetsFlutterBinding.ensureInitialized();
  await initDependecies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ConnectivityCubit()..init()),
        BlocProvider(create: (_) => LocaleCubit()..init()),
        BlocProvider(create: (_) => ThemeCubit()..init()),
        BlocProvider(create: (_) => DeleteConfirmationCubit()..init()),
        BlocProvider(create: (_) => DuckCubit()..init()),
        BlocProvider(create: (_) => AuthCubit()..init()),
        BlocProvider(create: (_) => TodoOperationCubit()),
        BlocProvider(
          create: (context) => TodoListBloc(
            todoRepository: GetIt.I<TodoRepository>(),
            todoOperation: context.read<TodoOperationCubit>(),
            analytics: Analytics(),
          )..add(TodosFetchStarted()),
        ),
        BlocProvider(
          create: (_) => RemoteColorsCubit(
            GetIt.I<RemoteConfigService>(),
          )..init(),
        ),
        BlocProvider(create: (context) => TabletViewCubit()),
        Provider(create: (_) => NavigationManager(router)),
      ],
      child: const TodoApp(),
    ),
  );
}
