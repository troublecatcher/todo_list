import 'package:go_router/go_router.dart';
import 'package:todo_list/config/logger/navigation_logger.dart';
import 'package:todo_list/features/settings/screen/settings_screen.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/todo_all_screen.dart';
import 'package:todo_list/features/todo/presentation/todo_single/screen/todo_single_screen.dart';

final GoRouter appRouter = GoRouter(
  observers: [NavigationLogger()],
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TodoAllScreen(),
      routes: [
        GoRoute(
          path: 'todo',
          builder: (context, state) {
            final todo = state.extra as Todo?;
            return TodoSingleScreen(todo: todo);
          },
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
