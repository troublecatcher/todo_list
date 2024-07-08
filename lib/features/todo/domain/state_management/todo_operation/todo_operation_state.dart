import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';

sealed class TodoOperationState {}

final class TodoOperationIdleState extends TodoOperationState {}

final class TodoOperationProcessingState extends TodoOperationState {
  final TodoEntity todo;

  TodoOperationProcessingState({required this.todo});
}
