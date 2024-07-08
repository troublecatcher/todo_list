import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/core/extensions/theme_extension.dart';
import 'package:todo_list/core/services/device_info_service.dart';
import 'package:todo_list/core/ui/layout/custom_button_base.dart';
import 'package:todo_list/config/l10n/generated/l10n.dart';
import 'package:uuid/uuid.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list/features/todo/presentation/todo_single/cubit/todo_single_cubit.dart';

class TodoSaveButton extends StatelessWidget {
  final TodoEntity? currentTodo;
  const TodoSaveButton({
    super.key,
    required this.currentTodo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoSingleCubit, TodoEntity>(
      builder: (context, todo) {
        return CustomButtonBase(
          margin: const EdgeInsets.only(top: 8, right: 8),
          onPressed: todoHasText(todo)
              ? () {
                  TodoEntity newTodo = todo.copyWith(
                    id: currentTodo?.id ?? const Uuid().v4(),
                    createdAt: currentTodo?.createdAt ?? DateTime.now(),
                    changedAt: DateTime.now(),
                    lastUpdatedBy: GetIt.I<DeviceInfoService>().info,
                  );
                  if (currentTodo == null) {
                    context.read<TodoListBloc>().add(TodoAdded(newTodo));
                  } else {
                    newTodo = newTodo.copyWith(
                      deadline: todo.deadline,
                      color: todo.color,
                    );
                    context.read<TodoListBloc>().add(TodoUpdated(newTodo));
                  }
                  context.pop();
                }
              : null,
          child: Text(
            S.of(context).todoSaveButtonTitle,
            style: context.textTheme.titleMedium,
          ),
        );
      },
    );
  }

  bool todoHasText(TodoEntity todo) => todo.text.isNotEmpty;
}
