import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/config/logger/logger.dart';

class NavigationLogger extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (route is GoRoute) {
      // final args = route.settings.arguments;
      // if (args != null) {
      //   if (args is EditTodoIntent) {
      //     Log.i(
      //         '$NavigationLogger.didPush: ${route.settings}, todo ${args.todo.id})');
      //     return;
      //   }
      // }
      Log.i('$NavigationLogger.didPush: ${route.settings.name}');
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (route is PageRoute) {
      // final args = route.settings.arguments;
      // if (args != null) {
      //   if (args is EditTodoIntent) {
      //     Log.i(
      //         '$NavigationLogger.didPop: ${route.settings}, todo ${args.todo.id})');
      //     return;
      //   }
      // }
      Log.i('$NavigationLogger.didPop: ${route.settings.name}');
    }
    super.didPop(route, previousRoute);
  }
}
