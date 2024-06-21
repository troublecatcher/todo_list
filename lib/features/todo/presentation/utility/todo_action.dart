import 'package:todo_list/features/todo/domain/todo.dart';

sealed class TodoAction {}

final class CreateTodo extends TodoAction {}

final class EditTodo extends TodoAction {
  final Todo todo;

  EditTodo({required this.todo});
}
