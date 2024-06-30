import 'package:flutter/material.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/features/todo/presentation/utility/todo_action.dart';

class NavigationLogger extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (route is MaterialPageRoute) {
      final args = route.settings.arguments;
      if (args != null) {
        if (args is EditTodo) {
          Log.i(
              '$NavigationLogger.didPush: ${route.settings.name}, todo (id ${args.todo.id})');
          return;
        }
      }
      Log.i('$NavigationLogger.didPush: ${route.settings.name}');
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (route is MaterialPageRoute) {
      final args = route.settings.arguments;
      if (args != null) {
        if (args is EditTodo) {
          Log.i(
              '$NavigationLogger.didPop: ${route.settings.name}, todo (id ${args.todo.id})');
          return;
        }
      }
      Log.i('$NavigationLogger.didPop: ${route.settings.name}');
    }
    super.didPop(route, previousRoute);
  }
}
