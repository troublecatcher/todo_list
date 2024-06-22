import 'package:flutter/material.dart';
import 'package:todo_list/config/logging/logger.dart';

class NavigationLogger extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (route is MaterialPageRoute) {
      Log.i('$NavigationLogger.didPush: ${route.settings.name}');
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (route is MaterialPageRoute) {
      Log.i('$NavigationLogger.didPop: ${route.settings.name}');
    }
    super.didPop(route, previousRoute);
  }
}
