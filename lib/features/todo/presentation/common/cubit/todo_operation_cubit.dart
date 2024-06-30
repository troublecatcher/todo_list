import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/common/cubit/todo_operation_notifier.dart';
import 'package:todo_list/features/todo/presentation/common/cubit/todo_operation_state.dart';

class TodoOperationCubit extends Cubit<TodoOperationState>
    implements OperationStatusNotifier {
  TodoOperationCubit() : super(TodoOperationIdleState());

  @override
  void startOperation(Todo todo) =>
      emit(TodoOperationProcessingState(todo: todo));

  @override
  void endOperation() => emit(TodoOperationIdleState());
}
