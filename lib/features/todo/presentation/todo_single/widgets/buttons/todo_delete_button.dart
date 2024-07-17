import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/l10n/generated/l10n.dart';
import '../../../../../../core/core.dart';
import '../../../../../features.dart';

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
        return CustomButtonBase(
          padding: EdgeInsets.zero,
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
                          context.nav.goBack();
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
}
