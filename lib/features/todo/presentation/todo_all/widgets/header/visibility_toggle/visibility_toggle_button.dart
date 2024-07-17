import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/core.dart';
import '../../../../../domain/state_management/state_management.dart';
import 'visibility_cubit.dart';

class VisibilityToggleButton extends StatelessWidget {
  final double collapsePercent;

  const VisibilityToggleButton({super.key, required this.collapsePercent});

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
