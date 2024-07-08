import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list/features/todo/presentation/todo_single/cubit/todo_single_cubit.dart';
import 'package:todo_list/config/dialog/dialog_manager.dart';

class TodoDeleteButton extends StatelessWidget {
  final TodoEntity? todo;
  const TodoDeleteButton({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoSingleCubit, TodoEntity>(
      builder: (context, currentTodo) {
        return FittedBox(
          child: CustomButtonBase(
            onPressed: switch (todo) {
              null => null,
              TodoEntity _ => () {
                  DialogManager.showDeleteConfirmationDialog(
                    context,
                    currentTodo,
                  ).then(
                    (result) {
                      if (result != null && result) {
                        context
                            .read<TodoListBloc>()
                            .add(TodoDeleted(currentTodo));
                        context.pop();
                      }
                    },
                  );
                }
            },
            child: Builder(
              builder: (context) {
                final color = switch (todo) {
                  null => context.disabledColor,
                  TodoEntity _ => context.customColors.red,
                };
                return Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: color,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      S.of(context).todoDeleteButtonTitle,
                      style:
                          context.textTheme.bodyMedium!.copyWith(color: color),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
