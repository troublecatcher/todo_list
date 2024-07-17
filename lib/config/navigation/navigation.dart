import 'package:go_router/go_router.dart';
import 'package:todo_list/config/log/navigation_logger.dart';
import 'package:todo_list/features/settings/presentation/screen/settings_screen.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/todo_all_screen.dart';
import 'package:todo_list/features/todo/presentation/todo_single/screen/todo_single_screen.dart';

abstract class NavigationKeys {
  static String get home => 'home';
  static String get todo => 'todo';
  static String get settings => 'settings';
}

final GoRouter router = GoRouter(
  observers: [NavigationLogger()],
  routes: [
    GoRoute(
      path: '/',
      name: NavigationKeys.home,
      builder: (context, state) => const TodoAllScreen(),
      routes: [
        GoRoute(
          path: NavigationKeys.todo,
          name: NavigationKeys.todo,
          builder: (context, state) {
            final todo = state.extra as Todo?;
            return TodoSingleScreen(todo: todo);
          },
        ),
        GoRoute(
          path: NavigationKeys.settings,
          name: NavigationKeys.settings,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);

class NavigationManager {
  final GoRouter _router;
  NavigationManager(this._router);

  void goHome() {
    _router.goNamed(NavigationKeys.home);
  }

  void goTodoSingle({Todo? todo}) {
    _router.goNamed(NavigationKeys.todo, extra: todo);
  }

  void goSettings() {
    _router.goNamed(NavigationKeys.settings);
  }

  void goBack<T extends Object?>([T? result]) {
    _router.pop(result);
  }
}
