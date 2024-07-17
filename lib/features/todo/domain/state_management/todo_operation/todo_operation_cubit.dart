import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/todo.dart';
import 'todo_operation_interface.dart';
import 'todo_operation_type.dart';

part 'todo_operation_state.dart';

class TodoOperationCubit extends Cubit<TodoOperationState>
    implements TodoOperationInterface {
  TodoOperationCubit() : super(TodoOperationIdleState());

  @override
  void startOperation(Todo todo, TodoOperationType type) => emit(
        TodoOperationProcessingState(
          todo: todo,
          type: type,
        ),
      );

  @override
  void endOperation() => emit(TodoOperationIdleState());
}
