part of 'todo_list_bloc.dart';

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
