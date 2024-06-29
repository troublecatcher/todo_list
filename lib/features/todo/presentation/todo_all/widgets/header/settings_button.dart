import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/custom_icon_button.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_state.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key, required this.collapsePercent});

  final double collapsePercent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoState>(
      builder: (context, state) {
        return CustomIconButton(
          icon: Icons.settings,
          onPressed: () => Navigator.of(context).pushNamed('/settings'),
          color: context.colorScheme.primary,
          margin: EdgeInsets.only(
            bottom: lerpDouble(0, 6, collapsePercent)!,
          ),
        );
      },
    );
  }
}
