import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/theme/app_colors.dart';
import 'package:todo_list/core/ui/custom_button_base.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_single/cubit/single_todo_cubit.dart';
import 'package:todo_list/features/todo/presentation/common/dialog_manager.dart';
import 'package:todo_list/features/todo/presentation/common/todo_action.dart';

class TodoDeleteButton extends StatelessWidget {
  final TodoAction action;
  const TodoDeleteButton({
    super.key,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleTodoCubit, Todo>(
      builder: (context, todo) {
        return FittedBox(
          child: CustomButtonBase(
            onPressed: switch (action) {
              CreateTodo _ => null,
              EditTodo _ => () {
                  DialogManager.showDeleteConfirmationDialog(context, todo)
                      .then((result) {
                    if (result != null && result) {
                      context.read<TodoListBloc>().add(DeleteTodoEvent(todo));
                      Navigator.of(context).pop();
                    }
                  });
                }
            },
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  color: switch (action) {
                    CreateTodo _ => Theme.of(context).disabledColor,
                    EditTodo _ => AppColors.red,
                  },
                ),
                Text(
                  'Удалить',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: switch (action) {
                          CreateTodo _ => Theme.of(context).disabledColor,
                          EditTodo _ => AppColors.red,
                        },
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
