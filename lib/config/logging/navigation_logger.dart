import 'package:flutter/material.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/core/services/analytics.dart';

class NavigationLogger extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final String? name = route.settings.name;
    Analytics.logPageVisit(name ?? '');
    Log.i('$NavigationLogger.didPush $name');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final String? name = route.settings.name;
    Analytics.logPageLeave(name ?? '');
    Log.i('$NavigationLogger.didPop $name');
    super.didPop(route, previousRoute);
  }
}
