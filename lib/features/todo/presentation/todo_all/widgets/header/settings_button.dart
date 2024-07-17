import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../../features.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key, required this.collapsePercent});

  final double collapsePercent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoState>(
      builder: (context, state) {
        return CustomIconButton(
          icon: Icons.settings,
          onPressed: () => context.nav.goSettings(),
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
