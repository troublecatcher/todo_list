import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/config/theme/app_colors.dart';
import 'package:todo_list/features/todo/domain/todo.dart';
import 'package:todo_list/features/todo/presentation/state_management/todo_controller.dart';
import 'package:todo_list/features/todo/presentation/pages/new_todo_screen.dart';
import 'package:todo_list/features/todo/presentation/utility/todo_action.dart';
import 'package:todo_list/features/todo/presentation/utility/todo_result.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.todo,
    required this.todoBloc,
  });

  final Todo todo;
  final TodoController todoBloc;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: switch (todo.isDone!) {
          true => Theme.of(context).dividerColor,
          false => AppColors.green,
        },
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Icon(todo.isDone! ? Icons.close_rounded : Icons.check,
            color: AppColors.white),
      ),
      secondaryBackground: Container(
        color: AppColors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: const Icon(Icons.delete, color: AppColors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          todoBloc.update(todo.copyWith(
            id: todo.id,
            content: todo.content,
            isDone: !todo.isDone!,
            deadline: todo.deadline,
            priority: todo.priority,
          ));
          return false;
        } else if (direction == DismissDirection.endToStart) {
          final shouldDelete = await _showConfirmationDialog(context);
          if (shouldDelete) {
            todoBloc.delete(todo.id);
          }
          return shouldDelete;
        }
        return false;
      },
      key: ValueKey(todo),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (todo.isDone!)
              const Icon(
                Icons.check_box,
                color: AppColors.green,
              )
            else
              switch (todo.priority) {
                TodoPriority.high => Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        color: AppColors.red.withOpacity(0.16),
                      ),
                      const Icon(
                        Icons.check_box_outline_blank_rounded,
                        color: AppColors.red,
                      ),
                    ],
                  ),
                _ => Icon(
                    Icons.check_box_outline_blank,
                    color: Theme.of(context).dividerColor,
                  ),
              },
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (!todo.isDone!)
                          switch (todo.priority) {
                            TodoPriority.high => Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/icons/priority/high.svg'),
                                  const SizedBox(width: 3),
                                ],
                              ),
                            TodoPriority.low => Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/icons/priority/low.svg'),
                                  const SizedBox(width: 3),
                                ],
                              ),
                            TodoPriority.none => const SizedBox.shrink(),
                          },
                        Expanded(
                          child: Text(
                            todo.content!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: switch (todo.isDone!) {
                                    true =>
                                      Theme.of(context).colorScheme.tertiary,
                                    false => null,
                                  },
                                  decoration: switch (todo.isDone!) {
                                    true => TextDecoration.lineThrough,
                                    false => TextDecoration.none,
                                  },
                                ),
                          ),
                        ),
                      ],
                    ),
                    if (todo.deadline != null)
                      Column(
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            todo.deadline!.toIso8601String(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () async {
                await _editTodo(context);
              },
              icon: Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editTodo(BuildContext context) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewTodoScreen(
        action: EditTodo(
          todo: todo,
        ),
      ),
    ));
    if (result is EditedTodo) {
      final resultTodo = result.todo;
      if (resultTodo != null) {
        todoBloc.update(
          todo.copyWith(
            id: todo.id,
            content: resultTodo.content,
            priority: resultTodo.priority,
            deadline: resultTodo.deadline,
          ),
        );
      }
    } else if (result is DeletedTodo) {
      todoBloc.delete(todo.id);
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Уверены?'),
            content: const Text('Хотите удалить это дело?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('НЕТ'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('ДА'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
