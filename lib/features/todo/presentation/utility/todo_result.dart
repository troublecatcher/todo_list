import 'package:todo_list/features/todo/domain/todo.dart';

sealed class TodoResult {}

final class CreatedTodo extends TodoResult {
  final Todo todo;

  CreatedTodo({required this.todo});
}

final class EditedTodo extends TodoResult {
  final Todo? todo;

  EditedTodo({required this.todo});
}

final class DeletedTodo extends TodoResult {}
