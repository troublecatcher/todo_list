import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/widget/custom_icon_button.dart';
import 'package:todo_list/core/ui/widget/loading_widget.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_state.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/header/visibility_toggle/visibility_mode.dart';

class VisibilityToggleButton extends StatelessWidget {
  const VisibilityToggleButton({super.key, required this.collapsePercent});

  final double collapsePercent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoState>(
      builder: (context, state) {
        if (state is! TodoLoadInProgress) {
          return BlocBuilder<VisibilityCubit, VisibilityMode>(
            builder: (context, mode) {
              return CustomIconButton(
                icon: switch (mode) {
                  VisibilityMode.undone => Icons.visibility,
                  VisibilityMode.all => Icons.visibility_off,
                },
                onPressed: () => context.read<VisibilityCubit>().toggle(),
                color: context.colorScheme.primary,
                margin: EdgeInsets.only(
                  bottom: lerpDouble(0, 6, collapsePercent)!,
                ),
              );
            },
          );
        } else {
          return const Padding(
            padding: EdgeInsets.only(right: 24),
            child: LoadingWidget(padding: EdgeInsets.zero),
          );
        }
      },
    );
  }
}
