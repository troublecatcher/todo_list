import 'package:todo_list/features/todo/domain/entity/todo.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  AddTodoEvent(this.todo);
}

class UpdateTodoEvent extends TodoEvent {
  final Todo todo;

  UpdateTodoEvent(this.todo);
}

class DeleteTodoEvent extends TodoEvent {
  final Todo todo;

  DeleteTodoEvent(this.todo);
}

class FetchTodos extends TodoEvent {}
