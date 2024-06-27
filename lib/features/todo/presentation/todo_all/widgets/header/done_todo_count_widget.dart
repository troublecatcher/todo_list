import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_state.dart';

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
            return const CircularProgressIndicator();
          case TodoError _:
            return Text('Ошибка: ${state.message}');
          case TodoLoaded _:
            if (state.todos.isNotEmpty) {
              final doneCount = state.todos.where((todo) => todo.done!).length;
              return _TodoCountText(count: doneCount);
            } else {
              return const _TodoCountText(count: 0);
            }
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
      'Выполнено — $count',
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Theme.of(context).colorScheme.tertiary),
    );
  }
}
