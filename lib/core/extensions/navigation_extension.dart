import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/router/navigation_service.dart';

extension NavigationExtension on BuildContext {
  NavigationService get nav =>
      Provider.of<NavigationService>(this, listen: false);
}
