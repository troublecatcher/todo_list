import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list/features/todo/domain/todo_operation_cubit/todo_operation_notifier.dart';
import 'package:todo_list/features/todo/domain/todo_operation_cubit/todo_operation_state.dart';

class TodoOperationCubit extends Cubit<TodoOperationState>
    implements OperationStatusNotifier {
  TodoOperationCubit() : super(TodoOperationIdleState());

  @override
  void startOperation(TodoEntity todo) =>
      emit(TodoOperationProcessingState(todo: todo));

  @override
  void endOperation() => emit(TodoOperationIdleState());
}
