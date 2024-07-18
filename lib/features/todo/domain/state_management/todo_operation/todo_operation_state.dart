part of 'todo_operation_cubit.dart';

sealed class TodoOperationState {}

final class TodoOperationIdleState extends TodoOperationState {}

final class TodoOperationProcessingState extends TodoOperationState {
  final Todo todo;

  TodoOperationProcessingState({required this.todo});
}
