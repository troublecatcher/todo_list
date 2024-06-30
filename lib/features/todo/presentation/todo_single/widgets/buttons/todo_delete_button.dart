import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_single/cubit/todo_single_cubit.dart';
import 'package:todo_list/core/ui/service/dialog_manager.dart';
import 'package:todo_list/features/todo/presentation/common/todo_intent.dart';
import 'package:todo_list/generated/l10n.dart';

class TodoDeleteButton extends StatelessWidget {
  final TodoIntent intent;
  const TodoDeleteButton({
    super.key,
    required this.intent,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoSingleCubit, Todo>(
      builder: (context, todo) {
        return FittedBox(
          child: CustomButtonBase(
            onPressed: switch (intent) {
              CreateTodoIntent _ => null,
              EditTodoIntent _ => () {
                  if (GetIt.I<SharedPreferencesService>().confirmDialogs) {
                    DialogManager.showDeleteConfirmationDialog(context, todo)
                        .then(
                      (result) {
                        if (result != null && result) {
                          context
                              .read<TodoListBloc>()
                              .add(DeleteTodoEvent(todo));
                          Navigator.of(context).pop();
                        }
                      },
                    );
                  } else {
                    context.read<TodoListBloc>().add(DeleteTodoEvent(todo));
                    Navigator.of(context).pop();
                  }
                }
            },
            child: Builder(builder: (context) {
              final color = switch (intent) {
                CreateTodoIntent _ => context.disabledColor,
                EditTodoIntent _ => context.customColors.red,
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
                    style: context.textTheme.bodyMedium!.copyWith(color: color),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
