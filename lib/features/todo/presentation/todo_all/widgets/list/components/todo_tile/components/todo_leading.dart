import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';

class TodoLeading extends StatelessWidget {
  final Todo todo;
  const TodoLeading({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonBase(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Checkbox(
        splashRadius: 0,
        activeColor: context.customColors.green,
        fillColor: switch (todo.importance) {
          Importance.important => switch (todo.done) {
              true => null,
              false => WidgetStatePropertyAll(
                  context.customColors.red.withOpacity(.3),
                ),
            },
          _ => null,
        },
        side: switch (todo.importance) {
          Importance.important =>
            BorderSide(color: context.customColors.red, width: 2),
          _ => null,
        },
        value: todo.done,
        onChanged: (_) => _changeTodoCompletenessStatus(
          context.read<TodoListBloc>(),
        ),
      ),
    );
  }

  void _changeTodoCompletenessStatus(TodoListBloc bloc) {
    Log.i(
      'trying to change todo ${todo.id} completeness status to ${!todo.done}',
    );
    bloc.add(TodoUpdated(
      todo.copyWithEdit(
        done: !todo.done,
        changedAt: DateTime.now(),
        deadline: todo.deadline,
        color: todo.color,
      ),
    ));
  }
}
