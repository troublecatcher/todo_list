import 'package:flutter/material.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type.dart';

class LayoutTypeProvider extends InheritedWidget {
  final LayoutType layoutType;

  const LayoutTypeProvider({
    super.key,
    required this.layoutType,
    required super.child,
  });

  static LayoutType of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<LayoutTypeProvider>();
    assert(provider != null, 'No LayoutTypeProvider found in context');
    return provider!.layoutType;
  }

  @override
  bool updateShouldNotify(LayoutTypeProvider oldWidget) =>
      layoutType != oldWidget.layoutType;
}
