import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/core/extensions/navigation_extension.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_all/screen/tablet/tablet_view_cubit.dart';
import 'package:todo_list/features/todo/presentation/todo_all/widgets/list/components/todo_tile/todo_tile.dart';
import 'package:todo_list/features/todo/presentation/todo_single/controller/todo_single_cubit.dart';
import 'package:todo_list/core/ui/dialog_manager/dialog_manager.dart';

class TodoDeleteButton extends StatelessWidget {
  final Todo? todo;
  final LayoutType type;

  const TodoDeleteButton({
    super.key,
    required this.todo,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoSingleCubit, Todo>(
      builder: (context, currentTodo) {
        return FittedBox(
          child: CustomButtonBase(
            onPressed: switch (todo) {
              null => null,
              Todo _ => () {
                  DialogManager.showDeleteConfirmationDialog(
                    context,
                    currentTodo,
                  ).then(
                    (result) {
                      if (result != null && result) {
                        context
                            .read<TodoListBloc>()
                            .add(TodoDeleted(currentTodo));
                        switch (type) {
                          case LayoutType.mobile:
                            context.nav.pop();
                            break;
                          case LayoutType.tablet:
                            context
                                .read<TabletViewCubit>()
                                .set(TabletViewInitialState());
                            break;
                        }
                      }
                    },
                  );
                }
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
