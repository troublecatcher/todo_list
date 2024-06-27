import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/ui/custom_icon_button.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_state.dart';

class VisibilityToggleButton extends StatelessWidget {
  const VisibilityToggleButton({super.key, required this.collapsePercent});

  final double collapsePercent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoState>(
      builder: (context, state) {
        if (state is! TodoLoading) {
          return CustomIconButton(
            icon: switch (context.watch<TodoListBloc>().mode) {
              VisibilityMode.undone => Icons.visibility,
              VisibilityMode.all => Icons.visibility_off,
            },
            onPressed: () {
              context.read<TodoListBloc>().add(ToggleVisibilityMode());
            },
            color: Theme.of(context).colorScheme.primary,
            margin: EdgeInsets.only(
              right: lerpDouble(24, 0, collapsePercent)!,
              bottom: lerpDouble(0, 6, collapsePercent)!,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
