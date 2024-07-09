import 'package:flutter/material.dart';
import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';

class NavigationLogger extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logRoute('didPush', route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logRoute('didPop', route);
    super.didPop(route, previousRoute);
  }

  void _logRoute(String methodName, Route<dynamic> route) {
    final settings = route.settings;
    if (settings.arguments is Todo) {
      final todo = settings.arguments as Todo;
      Log.i('$NavigationLogger.$methodName: ${settings.name}, todo ${todo.id}');
    } else {
      Log.i('$NavigationLogger.$methodName: ${settings.name}');
    }
  }
}
