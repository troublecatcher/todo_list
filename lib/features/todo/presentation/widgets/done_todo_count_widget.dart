import 'package:flutter/material.dart';
import 'package:todo_list/features/todo/domain/todo.dart';
import 'package:todo_list/features/todo/presentation/controller/todo_controller.dart';

class DoneTodoCountWidget extends StatelessWidget {
  const DoneTodoCountWidget({
    super.key,
    required this.todoBloc,
  });

  final TodoController todoBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
      stream: todoBloc.todos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _TodoCountText(count: 0);
        } else if (snapshot.hasError) {
          return Text('Ошибка: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const _TodoCountText(count: 0);
        }
        final doneCount = snapshot.data!.where((todo) => todo.done!).length;
        return _TodoCountText(count: doneCount);
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
