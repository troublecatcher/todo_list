import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/ui/custom_button_base.dart';
import 'package:todo_list/core/ui/custom_icon_button.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_state.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_mode.dart';

class VisibilityToggleButton extends StatelessWidget {
  const VisibilityToggleButton({super.key, required this.collapsePercent});

  final double collapsePercent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoState>(
      builder: (context, state) {
        if (state is! TodoLoading) {
          return BlocBuilder<VisibilityCubit, VisibilityMode>(
            builder: (context, mode) {
              return CustomIconButton(
                icon: switch (mode) {
                  VisibilityMode.undone => Icons.visibility,
                  VisibilityMode.all => Icons.visibility_off,
                },
                onPressed: () => context.read<VisibilityCubit>().toggle(),
                color: Theme.of(context).colorScheme.primary,
                margin: EdgeInsets.only(
                  right: lerpDouble(24, 0, collapsePercent)!,
                  bottom: lerpDouble(0, 6, collapsePercent)!,
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
