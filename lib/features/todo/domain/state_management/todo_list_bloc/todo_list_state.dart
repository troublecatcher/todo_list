part of 'todo_list_bloc.dart';

sealed class TodoState extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoadInProgress extends TodoState {}

class TodoLoadSuccess extends TodoState {
  final List<Todo> todos;

  TodoLoadSuccess(List<Todo> todos)
      : todos = (todos..sort((a, b) => a.createdAt.compareTo(b.createdAt)));

  @override
  List<Object> get props => [todos];
}

class TodoFailure extends TodoState {
  final String message;

  TodoFailure(this.message);

  @override
  List<Object> get props => [message];
}
