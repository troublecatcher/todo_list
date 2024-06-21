import 'package:flutter/material.dart';
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
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.check, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
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
      key: ValueKey(todo.hashCode),
      child: ListTile(
        leading: todo.isDone!
            ? const Icon(Icons.check_box)
            : const Icon(Icons.check_box_outline_blank_rounded),
        title: Text(
          todo.content ?? '',
          style: TextStyle(
            decoration: todo.isDone! ? TextDecoration.lineThrough : null,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: todo.deadline != null
            ? Text(todo.deadline!.toIso8601String())
            : null,
        trailing: IconButton(
          onPressed: () async {
            await _editTodo(context);
          },
          icon: const Icon(Icons.info_outline),
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
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
