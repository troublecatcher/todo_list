import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/core/extensions/navigation_extension.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/widget/custom_icon_button.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key, required this.collapsePercent});

  final double collapsePercent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoState>(
      builder: (context, state) {
        return CustomIconButton(
          icon: Icons.settings,
          onPressed: () => context.nav.goToSettings(),
          color: context.colorScheme.primary,
          margin: EdgeInsets.only(
            right: lerpDouble(24, 0, collapsePercent)!,
            bottom: lerpDouble(0, 6, collapsePercent)!,
          ),
        );
      },
    );
  }
}
