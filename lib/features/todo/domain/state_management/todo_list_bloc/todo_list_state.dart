part of 'todo_list_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoadInProgress extends TodoState {}

class TodoLoadSuccess extends TodoState {
  final List<Todo> todos;

  const TodoLoadSuccess(this.todos);

  @override
  List<Object?> get props => [todos];
}

class TodoFailure extends TodoState {
  final String error;

  const TodoFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class TodoUnauthorized extends TodoState {}
