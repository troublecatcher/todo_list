import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/router/navigation.dart';

extension NavigationExtension on BuildContext {
  NavigationManager get nav =>
      Provider.of<NavigationManager>(this, listen: false);
}
