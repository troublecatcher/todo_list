import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';

class DoneTodoCountWidget extends StatelessWidget {
  const DoneTodoCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: Durations.extralong1,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: switch (state) {
            TodoInitial _ => const _TodoCountText(count: 0),
            TodoLoadInProgress _ => const SizedBox.shrink(),
            TodoFailure _ => const SizedBox.shrink(),
            TodoLoadSuccess _ => _TodoCountText(
                count: state.todos.where((todo) => todo.done).length,
              ),
          },
        );
      },
    );
  }
}

class _TodoCountText extends StatelessWidget {
  final int count;
  const _TodoCountText({
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).doneTodoCount(count),
      style: context.textTheme.bodyMedium!.copyWith(
        color: context.colorScheme.tertiary,
      ),
    );
  }
}
