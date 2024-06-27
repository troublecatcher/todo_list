import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/config/theme/app_colors.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_single/bloc/single_todo_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_single/utility/dialog_manager.dart';
import 'package:todo_list/features/todo/presentation/todo_single/utility/todo_action.dart';

class TodoDeleteButton extends StatefulWidget {
  const TodoDeleteButton({
    super.key,
  });

  @override
  State<TodoDeleteButton> createState() => _TodoDeleteButtonState();
}

class _TodoDeleteButtonState extends State<TodoDeleteButton> {
  late TodoAction action;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    action = context.read<SingleTodoCubit>().action;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleTodoCubit, Todo>(
      builder: (context, todo) {
        return TextButton.icon(
          onPressed: switch (action) {
            CreateTodo _ => null,
            EditTodo todoAction => () {
                DialogManager.showDeleteConfirmationDialog(context)
                    .then((result) {
                  if (result != null && result) {
                    context.read<TodoListBloc>().add(DeleteTodoEvent(todo.id));
                    Navigator.of(context).pop();
                  } else {
                    Log.i('rejected to delete todo (id ${todoAction.todo.id})');
                  }
                });
              }
          },
          label: Text(
            'Удалить',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: switch (action) {
                    CreateTodo _ => Theme.of(context).disabledColor,
                    EditTodo _ => AppColors.red,
                  },
                ),
          ),
          icon: Icon(
            Icons.delete,
            color: switch (action) {
              CreateTodo _ => Theme.of(context).disabledColor,
              EditTodo _ => AppColors.red,
            },
          ),
        );
      },
    );
  }
}
