import 'package:todo_list/features/todo/domain/entity/todo.dart';

sealed class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded(List<Todo> todos)
      : todos = (todos..sort((a, b) => a.createdAt.compareTo(b.createdAt)));
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message);
}
