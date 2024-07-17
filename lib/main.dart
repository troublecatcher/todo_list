import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'config/config.dart';
import 'core/core.dart';
import 'features/features.dart';

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
