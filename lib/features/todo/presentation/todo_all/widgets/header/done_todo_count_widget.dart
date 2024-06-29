import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/extensions/build_context_extension.dart';
import 'package:todo_list/core/ui/app_shimmer.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_state.dart';
import 'package:todo_list/generated/l10n.dart';

class DoneTodoCountWidget extends StatelessWidget {
  const DoneTodoCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoState>(
      builder: (context, state) {
        switch (state) {
          case TodoInitial _:
            return const _TodoCountText(count: 0);
          case TodoLoading _:
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const AppShimmer(
                enabled: true,
                child: SizedBox(
                  height: 60,
                  width: 200,
                ),
              ),
            );
          case TodoError _:
            return Text(S.of(context).errorMessage(state.message));
          case TodoLoaded _:
            final doneCount = state.todos.where((todo) => todo.done).length;
            return _TodoCountText(count: doneCount);
          case TodoOperationBeingPerformed _:
            final doneCount = state.todos.where((todo) => todo.done).length;
            return _TodoCountText(count: doneCount);
        }
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
      style: context.textTheme.bodyMedium!
          .copyWith(color: context.colorScheme.tertiary),
    );
  }
}
