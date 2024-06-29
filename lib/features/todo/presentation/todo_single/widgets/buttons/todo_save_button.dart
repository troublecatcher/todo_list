import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/ui/custom_button_base.dart';
import 'package:todo_list/generated/l10n.dart';
import 'package:uuid/uuid.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/common/todo_action.dart';
import 'package:todo_list/features/todo/presentation/todo_single/cubit/todo_single_cubit.dart';

class TodoSaveButton extends StatelessWidget {
  final TodoAction action;
  const TodoSaveButton({
    super.key,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoSingleCubit, Todo>(
      builder: (context, todo) {
        return CustomButtonBase(
          margin: const EdgeInsets.only(top: 8, right: 8),
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
                                ..lastUpdatedBy = 'Ryan Gosling'
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
                                ..lastUpdatedBy = 'Ryan Gosling',
                            ),
                          );
                      break;
                  }
                  Navigator.of(context).pop();
                }
              : null,
          child: Text(
            S.of(context).todoSaveButtonTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      },
    );
  }

  bool todoHasText(Todo todo) => todo.text.isNotEmpty;
}
