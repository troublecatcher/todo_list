import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/logging/navigation_logger.dart';
import 'package:todo_list/config/theme/theme.dart';
import 'package:todo_list/core/helpers/formatting_helper.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screens/home_screen.dart';
import 'package:todo_list/features/todo/presentation/todo_single/screens/single_todo_screen.dart';
import 'package:todo_list/features/todo/presentation/todo_single/utility/todo_action.dart';
import 'package:todo_list/features/todo/data/isar_todo_repository.dart';

import 'package:todo_list/core/services/persistence_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FormattingHelper.init();

  final isarService = IsarService();
  final isar = await isarService.initializeIsar();
  final todoRepository = IsarTodoRepository(isar);
  runApp(
    BlocProvider(
      create: (context) =>
          TodoListBloc(todoRepository: todoRepository)..add(LoadTodos()),
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
