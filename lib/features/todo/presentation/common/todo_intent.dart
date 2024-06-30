import 'package:todo_list/features/todo/domain/entity/todo.dart';

sealed class TodoIntent {}

final class CreateTodoIntent extends TodoIntent {}

final class EditTodoIntent extends TodoIntent {
  final Todo todo;

  EditTodoIntent({required this.todo});
}
