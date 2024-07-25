import '../../entities/todo.dart';
import 'todo_operation_type.dart';

abstract class TodoOperationInterface {
  void startOperation(Todo todo, TodoOperationType type);
  void endOperation();
}
