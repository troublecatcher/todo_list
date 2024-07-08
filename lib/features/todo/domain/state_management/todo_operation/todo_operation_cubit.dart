import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_operation/todo_operation.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_operation/todo_operation_state.dart';

class TodoOperationCubit extends Cubit<TodoOperationState>
    implements TodoOperation {
  TodoOperationCubit() : super(TodoOperationIdleState());

  @override
  void startOperation(TodoEntity todo) =>
      emit(TodoOperationProcessingState(todo: todo));

  @override
  void endOperation() => emit(TodoOperationIdleState());
}
