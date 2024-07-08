import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';

abstract class TodoEvent {}

class TodosFetchStarted extends TodoEvent {}

class TodoAdded extends TodoEvent {
  final TodoEntity todo;

  TodoAdded(this.todo);
}

class TodoUpdated extends TodoEvent {
  final TodoEntity todo;

  TodoUpdated(this.todo);
}

class TodoDeleted extends TodoEvent {
  final TodoEntity todo;

  TodoDeleted(this.todo);
}
