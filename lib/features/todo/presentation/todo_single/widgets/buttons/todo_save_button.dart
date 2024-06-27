import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/common/todo_action.dart';
import 'package:todo_list/features/todo/presentation/todo_single/cubit/single_todo_cubit.dart';

class TodoSaveButton extends StatelessWidget {
  final TodoAction action;
  const TodoSaveButton({
    super.key,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleTodoCubit, Todo>(
      builder: (context, todo) {
        return TextButton(
          onPressed: todoHasText(todo)
              ? () {
                  switch (action) {
                    case CreateTodo _:
                      const uuid = Uuid();
                      context.read<TodoListBloc>().add(
                            AddTodoEvent(
                              todo
                                ..createdAt = DateTime.now()
                                ..changedAt = DateTime.now()
                                ..lastUpdatedBy = 'RyanGosling'
                                ..id = uuid.v4(),
                            ),
                          );
                      break;
                    case EditTodo _:
                      context.read<TodoListBloc>().add(
                            UpdateTodoEvent(
                              todo
                                ..createdAt = todo.createdAt
                                ..changedAt = DateTime.now()
                                ..lastUpdatedBy = 'RyanGosling',
                            ),
                          );
                      break;
                  }
                  Navigator.of(context).pop();
                }
              : null,
          child: const Text('СОХРАНИТЬ'),
        );
      },
    );
  }

  bool todoHasText(Todo todo) => todo.text.isNotEmpty;
}
