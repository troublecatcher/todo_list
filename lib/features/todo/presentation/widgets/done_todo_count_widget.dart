import 'package:flutter/material.dart';
import 'package:todo_list/features/todo/domain/todo.dart';
import 'package:todo_list/features/todo/domain/todo_bloc.dart';
import 'package:todo_list/features/todo/presentation/widgets/todo_count_text.dart';

class DoneTodoCountWidget extends StatelessWidget {
  const DoneTodoCountWidget({
    super.key,
    required this.todoBloc,
  });

  final TodoBloc todoBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
      stream: todoBloc.todos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const TodoCountText(count: 0);
        } else if (snapshot.hasError) {
          return Text('Ошибка: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const TodoCountText(count: 0);
        }
        final doneCount = snapshot.data!.where((todo) => todo.isDone!).length;
        return TodoCountText(count: doneCount);
      },
    );
  }
}
