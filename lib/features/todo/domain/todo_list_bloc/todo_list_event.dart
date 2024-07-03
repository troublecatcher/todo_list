import 'package:todo_list/features/todo/domain/entity/todo.dart';

abstract class TodoEvent {}

class TodosFetchStarted extends TodoEvent {}

class TodoAdded extends TodoEvent {
  final Todo todo;

  TodoAdded(this.todo);
}

class TodoUpdated extends TodoEvent {
  final Todo todo;

  TodoUpdated(this.todo);
}

class TodoDeleted extends TodoEvent {
  final Todo todo;

  TodoDeleted(this.todo);
}
