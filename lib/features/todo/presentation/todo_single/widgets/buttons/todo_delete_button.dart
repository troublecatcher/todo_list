import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/core/extensions/navigation_extension.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/dialog_manager/dialog_manager.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/layout_type/layout_type_provider.dart';
import 'package:todo_list/features/todo/presentation/todo_all/layout/tablet_layout/tablet_layout_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_single/controller/todo_single_cubit.dart';

class TodoDeleteButton extends StatelessWidget {
  final Todo? todo;

  const TodoDeleteButton({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final layoutType = LayoutTypeProvider.of(context);
    return BlocBuilder<TodoSingleCubit, Todo>(
      builder: (context, currentTodo) {
        return CustomButtonBase(
          padding: EdgeInsets.zero,
          onPressed: switch (todo) {
            null => null,
            Todo _ => () =>
                _handleTodoDeletion(context, currentTodo, layoutType),
          },
          child: Builder(
            builder: (context) {
              final color = switch (todo) {
                null => context.disabledColor,
                Todo _ => context.customColors.red,
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
            },
          ),
        );
      },
    );
  }

  void _handleTodoDeletion(
    BuildContext context,
    Todo currentTodo,
    LayoutType type,
  ) {
    DialogManager.showDeleteConfirmationDialog(
      context,
      currentTodo,
    ).then(
      (result) {
        if (result != null && result) {
          context.read<TodoListBloc>().add(TodoDeleted(currentTodo));
          switch (type) {
            case LayoutType.mobile:
              context.nav.goBack();
              break;
            case LayoutType.tablet:
              context.read<TabletLayoutCubit>().set(TabletLayoutInitialState());
              break;
          }
        }
      },
    );
  }
}
