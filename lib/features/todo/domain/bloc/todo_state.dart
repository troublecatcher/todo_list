import 'package:equatable/equatable.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';

sealed class TodoState extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded(this.todos);

  @override
  List<Object> get props => [todos];
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message);

  @override
  List<Object> get props => [message];
}
