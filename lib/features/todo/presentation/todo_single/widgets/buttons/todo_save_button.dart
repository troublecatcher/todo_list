import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/presentation/todo_single/controller/todo_single_cubit.dart';

class TodoSaveButton extends StatelessWidget {
  final Todo? currentTodo;
  const TodoSaveButton({
    super.key,
    required this.currentTodo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoSingleCubit, Todo>(
      builder: (context, todo) {
        return CustomButtonBase(
          key: const Key('saveButton'),
          margin: const EdgeInsets.only(top: 8, right: 8),
          onPressed:
              todoHasText(todo) ? () => _handleTodoSaving(context) : null,
          child: Text(
            S.of(context).todoSaveButtonTitle,
            style: context.textTheme.titleMedium,
          ),
        );
      },
    );
  }

  void _handleTodoSaving(BuildContext context) {
    Todo newTodo = context.read<TodoSingleCubit>().assignMetadata(currentTodo);
    final TodoListBloc bloc = context.read<TodoListBloc>();
    if (currentTodo == null) {
      bloc.add(TodoAdded(newTodo));
    } else {
      bloc.add(TodoUpdated(newTodo));
    }
    context.pop();
  }

  bool todoHasText(Todo todo) => todo.text.isNotEmpty;
}
