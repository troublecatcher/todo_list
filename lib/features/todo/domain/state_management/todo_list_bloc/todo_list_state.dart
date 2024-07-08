part of 'todo_list_bloc.dart';

sealed class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoadInProgress extends TodoState {}

class TodoLoadSuccess extends TodoState {
  final List<TodoEntity> todos;

  TodoLoadSuccess(List<TodoEntity> todos)
      : todos = (todos..sort((a, b) => a.createdAt.compareTo(b.createdAt)));
}

class TodoFailure extends TodoState {
  final String message;

  TodoFailure(this.message);
}
