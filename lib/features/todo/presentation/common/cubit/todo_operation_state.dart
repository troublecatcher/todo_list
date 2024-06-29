import 'package:todo_list/features/todo/domain/entity/todo.dart';

sealed class TodoOperationState {}

final class TodoOperationIdleState extends TodoOperationState {}

final class TodoOperationProcessingState extends TodoOperationState {
  final Todo todo;

  TodoOperationProcessingState({required this.todo});
}
