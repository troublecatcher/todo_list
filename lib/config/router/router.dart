import 'package:go_router/go_router.dart';
import 'package:todo_list/config/logger/navigation_logger.dart';
import 'package:todo_list/features/settings/presentation/screen/settings_screen.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';
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
            final todo = state.extra as TodoEntity?;
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
