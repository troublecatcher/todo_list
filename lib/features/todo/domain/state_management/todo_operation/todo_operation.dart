import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_operation/todo_operation_type.dart';

abstract class TodoOperation {
  void startOperation(Todo todo, TodoOperationType type);
  void endOperation();
}
