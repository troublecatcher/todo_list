import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_single/bloc/single_todo_cubit.dart';

class TodoSaveButton extends StatelessWidget {
  const TodoSaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleTodoCubit, Todo>(
      builder: (context, todo) {
        return TextButton(
          onPressed: todoHasContent(todo)
              ? () {
                  context.read<TodoListBloc>().add(AddTodoEvent(todo));
                  Navigator.of(context).pop();
                }
              : null,
          child: const Text('СОХРАНИТЬ'),
        );
      },
    );
  }

  bool todoHasContent(Todo todo) => todo.content!.isNotEmpty;
}
