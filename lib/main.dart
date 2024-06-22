import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/logging/navigation_logger.dart';
import 'package:todo_list/config/theme/theme.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_event.dart';
import 'package:todo_list/features/todo/presentation/pages/home_screen.dart';
import 'package:todo_list/features/todo/presentation/pages/todo_screen.dart';
import 'package:todo_list/features/todo/presentation/utility/todo_action.dart';
import 'package:todo_list/features/todo/data/isar_todo_repository.dart';

// Import your Isar service
import 'package:todo_list/core/services/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isarService = IsarService();
  final isar = await isarService.initializeIsar();
  final todoRepository = IsarTodoRepository(isar);

  runApp(
    BlocProvider(
      create: (context) =>
          TodoBloc(todoRepository: todoRepository)..add(LoadTodos()),
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
