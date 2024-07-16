import 'package:firebase_analytics/observer.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/config/logging/navigation_logger.dart';
import 'package:todo_list/config/logging/analytics.dart';
import 'package:todo_list/features/settings/presentation/screen/settings_screen.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/todo_all_screen.dart';
import 'package:todo_list/features/todo/presentation/todo_single/screen/todo_single_screen.dart';

final GoRouter appRouter = GoRouter(
  observers: [NavigationLogger()],
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const TodoAllScreen(),
      routes: [
        GoRoute(
          path: 'todo',
          name: 'todo',
          builder: (context, state) {
            final todo = state.extra as Todo?;
            return TodoSingleScreen(todo: todo);
          },
        ),
        GoRoute(
          path: 'settings',
          name: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
