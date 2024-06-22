import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_state.dart';

class DoneTodoCountWidget extends StatelessWidget {
  const DoneTodoCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoading) {
          return const CircularProgressIndicator();
        } else if (state is TodoError) {
          return Text('Ошибка: ${state.message}');
        } else if (state is TodoLoaded) {
          final doneCount = state.todos.where((todo) => todo.done!).length;
          return _TodoCountText(count: doneCount);
        } else {
          return const _TodoCountText(count: 0);
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
