import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/custom_button_base.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';

class ClickableCheckbox extends StatelessWidget {
  final Todo todo;
  const ClickableCheckbox({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonBase(
      padding: EdgeInsets.zero,
      onPressed: () {
        final bloc = context.read<TodoListBloc>();
        bloc.add(
          UpdateTodoEvent(
            todo.copyWithEdit(
              done: !todo.done,
              changedAt: DateTime.now(),
              deadline: todo.deadline,
              color: todo.color,
            ),
          ),
        );
        Log.i('changed todo ${todo.id} completeness status to ${!todo.done}');
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          right: 12,
          bottom: 12,
          left: 16,
        ),
        child: switch (todo.done) {
          true => Icon(
              Icons.check_box,
              color: context.customColors.green,
            ),
          false => switch (todo.importance) {
              Importance.important => Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      color: context.customColors.red.withOpacity(0.16),
                    ),
                    Icon(
                      Icons.check_box_outline_blank_rounded,
                      color: context.customColors.red,
                    ),
                  ],
                ),
              _ => Icon(
                  Icons.check_box_outline_blank,
                  color: context.dividerColor,
                ),
            },
        },
      ),
    );
  }
}
