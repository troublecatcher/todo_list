import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/config/logging/navigation_logger.dart';
import 'package:todo_list/config/theme/theme.dart';
import 'package:todo_list/core/helpers/formatting_helper.dart';
import 'package:todo_list/core/services/service_locator.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';
import 'package:todo_list/features/todo/data/network_repository.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/home_screen.dart';
import 'package:todo_list/features/todo/presentation/todo_single/screen/single_todo_screen.dart';
import 'package:todo_list/features/todo/presentation/common/todo_action.dart';
import 'package:todo_list/features/todo/data/persistence_repository.dart';

import 'package:todo_list/core/services/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FormattingHelper.init();

  final isarService = IsarService();
  final isar = await isarService.initIsar();

  await ServiceLocator.setupSharedPreferencesService();

  final networkRepository = NetworkTodoRepository();
  final persistenceRepository = PersistenceTodoRepository(isar);
  HttpOverrides.global = MyHttpOverrides();

  runApp(
    BlocProvider(
      create: (context) => TodoListBloc(
        networkRepository: networkRepository,
        persistenceRepository: persistenceRepository,
      )..add(Fetch()),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JUST TODO IT',
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ru', 'RU'),
      navigatorObservers: [
        NavigationLogger(),
      ],
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (_) => const HomeScreen(),
              settings: settings,
            );
          case '/todo':
            return MaterialPageRoute(
              builder: (_) =>
                  TodoScreen(action: settings.arguments as TodoAction),
              settings: settings,
            );

          default:
            return null;
        }
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
